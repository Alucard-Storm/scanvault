import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';

import '../models/document.dart';
import '../models/folder.dart';
import '../models/tag.dart';

/// Database service for local storage operations
class DatabaseService {
  static Database? _database;
  static const _uuid = Uuid();

  /// Initialize the database
  static Future<void> initialize() async {
    if (_database != null) return;

    final appDir = await getApplicationDocumentsDirectory();
    final dbPath = p.join(appDir.path, 'scanvault.db');

    _database = await openDatabase(
      dbPath,
      version: 1,
      onCreate: _onCreate,
    );
  }

  /// Create database tables
  static Future<void> _onCreate(Database db, int version) async {
    // Documents table
    await db.execute('''
      CREATE TABLE documents (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        created_at INTEGER NOT NULL,
        modified_at INTEGER NOT NULL,
        folder_id TEXT,
        ocr_text TEXT,
        thumbnail_path TEXT,
        FOREIGN KEY (folder_id) REFERENCES folders(id) ON DELETE SET NULL
      )
    ''');

    // Pages table
    await db.execute('''
      CREATE TABLE pages (
        id TEXT PRIMARY KEY,
        document_id TEXT NOT NULL,
        image_path TEXT NOT NULL,
        processed_image_path TEXT,
        page_number INTEGER NOT NULL,
        applied_filter TEXT DEFAULT 'original',
        ocr_text TEXT,
        FOREIGN KEY (document_id) REFERENCES documents(id) ON DELETE CASCADE
      )
    ''');

    // Folders table
    await db.execute('''
      CREATE TABLE folders (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        icon_name TEXT,
        color_value INTEGER DEFAULT 16752507,
        created_at INTEGER NOT NULL
      )
    ''');

    // Tags table
    await db.execute('''
      CREATE TABLE tags (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        color_value INTEGER DEFAULT 8150271
      )
    ''');

    // Document-Tags junction table
    await db.execute('''
      CREATE TABLE document_tags (
        document_id TEXT NOT NULL,
        tag_id TEXT NOT NULL,
        PRIMARY KEY (document_id, tag_id),
        FOREIGN KEY (document_id) REFERENCES documents(id) ON DELETE CASCADE,
        FOREIGN KEY (tag_id) REFERENCES tags(id) ON DELETE CASCADE
      )
    ''');

    // Create indexes
    await db.execute(
        'CREATE INDEX idx_documents_folder ON documents(folder_id)');
    await db.execute(
        'CREATE INDEX idx_pages_document ON pages(document_id)');
  }

  /// Get database instance
  static Database get db {
    if (_database == null) {
      throw StateError('Database not initialized. Call initialize() first.');
    }
    return _database!;
  }

  /// Generate a new UUID
  static String generateId() => _uuid.v4();

  // ============ Document Operations ============

  /// Insert a new document
  static Future<void> insertDocument(Document document) async {
    await db.insert('documents', {
      'id': document.id,
      'name': document.name,
      'created_at': document.createdAt.millisecondsSinceEpoch,
      'modified_at': document.modifiedAt.millisecondsSinceEpoch,
      'folder_id': document.folderId,
      'ocr_text': document.ocrText,
      'thumbnail_path': document.thumbnailPath,
    });

    // Insert pages
    for (final page in document.pages) {
      await insertPage(document.id, page);
    }

    // Insert tag associations
    for (final tagId in document.tagIds) {
      await db.insert('document_tags', {
        'document_id': document.id,
        'tag_id': tagId,
      });
    }
  }

  /// Get all documents
  static Future<List<Document>> getAllDocuments() async {
    final docs = await db.query('documents', orderBy: 'modified_at DESC');
    final documents = <Document>[];

    for (final doc in docs) {
      final pages = await getPagesForDocument(doc['id'] as String);
      final tagIds = await getTagIdsForDocument(doc['id'] as String);

      documents.add(Document(
        id: doc['id'] as String,
        name: doc['name'] as String,
        createdAt:
            DateTime.fromMillisecondsSinceEpoch(doc['created_at'] as int),
        modifiedAt:
            DateTime.fromMillisecondsSinceEpoch(doc['modified_at'] as int),
        folderId: doc['folder_id'] as String?,
        ocrText: doc['ocr_text'] as String?,
        thumbnailPath: doc['thumbnail_path'] as String?,
        pages: pages,
        tagIds: tagIds,
      ));
    }

    return documents;
  }

  /// Get a document by ID
  static Future<Document?> getDocument(String id) async {
    final docs = await db.query('documents', where: 'id = ?', whereArgs: [id]);
    if (docs.isEmpty) return null;

    final doc = docs.first;
    final pages = await getPagesForDocument(id);
    final tagIds = await getTagIdsForDocument(id);

    return Document(
      id: doc['id'] as String,
      name: doc['name'] as String,
      createdAt: DateTime.fromMillisecondsSinceEpoch(doc['created_at'] as int),
      modifiedAt:
          DateTime.fromMillisecondsSinceEpoch(doc['modified_at'] as int),
      folderId: doc['folder_id'] as String?,
      ocrText: doc['ocr_text'] as String?,
      thumbnailPath: doc['thumbnail_path'] as String?,
      pages: pages,
      tagIds: tagIds,
    );
  }

  /// Update a document
  static Future<void> updateDocument(Document document) async {
    await db.update(
      'documents',
      {
        'name': document.name,
        'modified_at': document.modifiedAt.millisecondsSinceEpoch,
        'folder_id': document.folderId,
        'ocr_text': document.ocrText,
        'thumbnail_path': document.thumbnailPath,
      },
      where: 'id = ?',
      whereArgs: [document.id],
    );
  }

  /// Delete a document
  static Future<void> deleteDocument(String id) async {
    await db.delete('documents', where: 'id = ?', whereArgs: [id]);
  }

  // ============ Page Operations ============

  /// Insert a page
  static Future<void> insertPage(String documentId, ScannedPage page) async {
    await db.insert('pages', {
      'id': page.id,
      'document_id': documentId,
      'image_path': page.imagePath,
      'processed_image_path': page.processedImagePath,
      'page_number': page.pageNumber,
      'applied_filter': page.appliedFilter.name,
      'ocr_text': page.ocrText,
    });
  }

  /// Get pages for a document
  static Future<List<ScannedPage>> getPagesForDocument(
      String documentId) async {
    final pages = await db.query(
      'pages',
      where: 'document_id = ?',
      whereArgs: [documentId],
      orderBy: 'page_number ASC',
    );

    return pages
        .map((p) => ScannedPage(
              id: p['id'] as String,
              imagePath: p['image_path'] as String,
              processedImagePath: p['processed_image_path'] as String?,
              pageNumber: p['page_number'] as int,
              appliedFilter: FilterType.values.firstWhere(
                (f) => f.name == p['applied_filter'],
                orElse: () => FilterType.original,
              ),
              ocrText: p['ocr_text'] as String?,
            ))
        .toList();
  }

  // ============ Folder Operations ============

  /// Insert a folder
  static Future<void> insertFolder(Folder folder) async {
    await db.insert('folders', {
      'id': folder.id,
      'name': folder.name,
      'icon_name': folder.iconName,
      'color_value': folder.colorValue,
      'created_at': folder.createdAt.millisecondsSinceEpoch,
    });
  }

  /// Get all folders with document counts
  static Future<List<Folder>> getAllFolders() async {
    final folders = await db.rawQuery('''
      SELECT f.*, COUNT(d.id) as doc_count
      FROM folders f
      LEFT JOIN documents d ON d.folder_id = f.id
      GROUP BY f.id
      ORDER BY f.name ASC
    ''');

    return folders
        .map((f) => Folder(
              id: f['id'] as String,
              name: f['name'] as String,
              iconName: f['icon_name'] as String?,
              colorValue: f['color_value'] as int,
              createdAt:
                  DateTime.fromMillisecondsSinceEpoch(f['created_at'] as int),
              documentCount: f['doc_count'] as int,
            ))
        .toList();
  }

  /// Delete a folder
  static Future<void> deleteFolder(String id) async {
    await db.delete('folders', where: 'id = ?', whereArgs: [id]);
  }

  /// Update a folder
  static Future<void> updateFolder(Folder folder) async {
    await db.update(
      'folders',
      {
        'name': folder.name,
        'icon_name': folder.iconName,
        'color_value': folder.colorValue,
      },
      where: 'id = ?',
      whereArgs: [folder.id],
    );
  }

  // ============ Tag Operations ============

  /// Insert a tag
  static Future<void> insertTag(Tag tag) async {
    await db.insert('tags', {
      'id': tag.id,
      'name': tag.name,
      'color_value': tag.colorValue,
    });
  }

  /// Get all tags
  static Future<List<Tag>> getAllTags() async {
    final tags = await db.query('tags', orderBy: 'name ASC');
    return tags
        .map((t) => Tag(
              id: t['id'] as String,
              name: t['name'] as String,
              colorValue: t['color_value'] as int,
            ))
        .toList();
  }

  /// Get tag IDs for a document
  static Future<List<String>> getTagIdsForDocument(String documentId) async {
    final result = await db.query(
      'document_tags',
      columns: ['tag_id'],
      where: 'document_id = ?',
      whereArgs: [documentId],
    );
    return result.map((r) => r['tag_id'] as String).toList();
  }

  /// Delete a tag
  static Future<void> deleteTag(String id) async {
    await db.delete('tags', where: 'id = ?', whereArgs: [id]);
  }
}
