import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/document.dart';
import '../models/folder.dart';
import '../models/tag.dart';
import '../services/database_service.dart';

/// Provider for managing documents state
final documentsProvider =
    StateNotifierProvider<DocumentsNotifier, AsyncValue<List<Document>>>((ref) {
  return DocumentsNotifier();
});

class DocumentsNotifier extends StateNotifier<AsyncValue<List<Document>>> {
  DocumentsNotifier() : super(const AsyncValue.loading()) {
    loadDocuments();
  }

  /// Load all documents from database
  Future<void> loadDocuments() async {
    state = const AsyncValue.loading();
    try {
      final documents = await DatabaseService.getAllDocuments();
      state = AsyncValue.data(documents);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  /// Add a new document
  Future<void> addDocument(Document document) async {
    await DatabaseService.insertDocument(document);
    await loadDocuments();
  }

  /// Update an existing document
  Future<void> updateDocument(Document document) async {
    await DatabaseService.updateDocument(document);
    await loadDocuments();
  }

  /// Delete a document
  Future<void> deleteDocument(String id) async {
    await DatabaseService.deleteDocument(id);
    await loadDocuments();
  }

  /// Get document by ID
  Document? getDocumentById(String id) {
    return state.whenOrNull(
      data: (docs) => docs.where((d) => d.id == id).firstOrNull,
    );
  }
}

/// Provider for managing folders state
final foldersProvider =
    StateNotifierProvider<FoldersNotifier, AsyncValue<List<Folder>>>((ref) {
  return FoldersNotifier();
});

class FoldersNotifier extends StateNotifier<AsyncValue<List<Folder>>> {
  FoldersNotifier() : super(const AsyncValue.loading()) {
    loadFolders();
  }

  /// Load all folders from database
  Future<void> loadFolders() async {
    state = const AsyncValue.loading();
    try {
      final folders = await DatabaseService.getAllFolders();
      state = AsyncValue.data(folders);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  /// Add a new folder
  Future<void> addFolder(Folder folder) async {
    await DatabaseService.insertFolder(folder);
    await loadFolders();
  }

  /// Delete a folder
  Future<void> deleteFolder(String id) async {
    await DatabaseService.deleteFolder(id);
    await loadFolders();
  }

  /// Update a folder
  Future<void> updateFolder(Folder folder) async {
    await DatabaseService.updateFolder(folder);
    await loadFolders();
  }
}

/// Provider for current document being viewed/edited
final currentDocumentProvider = StateProvider<Document?>((ref) => null);

/// Provider for selected filter type
final selectedFilterProvider = StateProvider<FilterType>((ref) => FilterType.original);

/// Provider for managing tags state
final tagsProvider =
    StateNotifierProvider<TagsNotifier, AsyncValue<List<Tag>>>((ref) {
  return TagsNotifier();
});

class TagsNotifier extends StateNotifier<AsyncValue<List<Tag>>> {
  TagsNotifier() : super(const AsyncValue.loading()) {
    loadTags();
  }

  /// Load all tags from database
  Future<void> loadTags() async {
    state = const AsyncValue.loading();
    try {
      final tags = await DatabaseService.getAllTags();
      state = AsyncValue.data(tags);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  /// Add a new tag
  Future<void> addTag(Tag tag) async {
    await DatabaseService.insertTag(tag);
    await loadTags();
  }

  /// Delete a tag
  Future<void> deleteTag(String id) async {
    await DatabaseService.deleteTag(id);
    await loadTags();
  }
}
