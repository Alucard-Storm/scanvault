import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../models/tag.dart';
import '../../providers/document_provider.dart';

class TagsSheet extends ConsumerStatefulWidget {
  final List<String> selectedTagIds;
  final bool isSelectionMode;
  final ValueChanged<String>? onTagSelected;

  const TagsSheet({
    super.key,
    this.selectedTagIds = const [],
    this.isSelectionMode = false,
    this.onTagSelected,
  });

  @override
  ConsumerState<TagsSheet> createState() => _TagsSheetState();
}

class _TagsSheetState extends ConsumerState<TagsSheet> {
  final _textController = TextEditingController();
  bool _isCreating = false;

  void _createTag() async {
    final name = _textController.text.trim();
    if (name.isEmpty) return;

    setState(() => _isCreating = true);

    try {
      final newTag = Tag(
        id: const Uuid().v4(),
        name: name,
        colorValue: (Colors.primaries[name.length % Colors.primaries.length].toARGB32()),
      );

      await ref.read(tagsProvider.notifier).addTag(newTag);
      _textController.clear();
      if (mounted) FocusScope.of(context).unfocus();
    } finally {
      if (mounted) setState(() => _isCreating = false);
    }
  }

  void _deleteTag(Tag tag) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Tag'),
        content: Text('Are you sure you want to delete "${tag.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      await ref.read(tagsProvider.notifier).deleteTag(tag.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    final tagsAsync = ref.watch(tagsProvider);

    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              widget.isSelectionMode ? 'Select Tags' : 'Manage Tags',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          const Divider(height: 1),
          Flexible(
            child: tagsAsync.when(
              data: (tags) {
                if (tags.isEmpty) {
                  return const Padding(
                    padding: EdgeInsets.all(32),
                    child: Center(
                      child: Text('No tags created yet'),
                    ),
                  );
                }
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: tags.length,
                  itemBuilder: (context, index) {
                    final tag = tags[index];
                    final isSelected = widget.selectedTagIds.contains(tag.id);

                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Color(tag.colorValue),
                        radius: 12,
                      ),
                      title: Text(tag.name),
                      trailing: widget.isSelectionMode
                          ? isSelected
                              ? Icon(Icons.check_circle, color: Theme.of(context).primaryColor)
                              : const Icon(Icons.circle_outlined)
                          : IconButton(
                              icon: const Icon(Icons.delete_outline),
                              onPressed: () => _deleteTag(tag),
                            ),
                      onTap: () {
                        if (widget.onTagSelected != null) {
                          widget.onTagSelected!(tag.id);
                        }
                      },
                    );
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, _) => Center(child: Text('Error: $err')),
            ),
          ),
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textController,
                    decoration: const InputDecoration(
                      hintText: 'New Tag Name',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    ),
                    onSubmitted: (_) => _createTag(),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton.filled(
                  onPressed: _isCreating ? null : _createTag,
                  icon: _isCreating
                      ? const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                        )
                      : const Icon(Icons.add),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
