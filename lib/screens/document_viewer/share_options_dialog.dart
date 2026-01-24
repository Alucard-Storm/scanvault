import 'package:flutter/material.dart';
import '../../models/document.dart';
import '../../l10n/app_localizations.dart';

class ShareOptionsDialog extends StatefulWidget {
  final Document document;

  const ShareOptionsDialog({
    super.key,
    required this.document,
  });

  @override
  State<ShareOptionsDialog> createState() => _ShareOptionsDialogState();
}

class _ShareOptionsDialogState extends State<ShareOptionsDialog> {
  late List<bool> _selectedPages;
  bool _includeOcrText = false;
  bool _isAllSelected = true;

  @override
  void initState() {
    super.initState();
    _selectedPages = List.filled(widget.document.pages.length, true);
  }

  void _toggleSelectAll() {
    setState(() {
      _isAllSelected = !_isAllSelected;
      for (int i = 0; i < _selectedPages.length; i++) {
        _selectedPages[i] = _isAllSelected;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return AlertDialog(
      title: Text(l10n.exportPdfTitle),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             // Include OCR Toggle
             CheckboxListTile(
               contentPadding: EdgeInsets.zero,
               title: Text(l10n.includeOcrText),
               subtitle: Text(l10n.includeOcrTextSubtitle),
               value: _includeOcrText,
               onChanged: (val) => setState(() => _includeOcrText = val ?? false),
               enabled: widget.document.ocrText != null && widget.document.ocrText!.isNotEmpty,
             ),
             
             const Divider(),
             
             // Page Selection Header
             Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                 Text('${l10n.pagesHeader} (${_selectedPages.where((p) => p).length})', 
                   style: Theme.of(context).textTheme.titleSmall,
                 ),
                 TextButton(
                   onPressed: _toggleSelectAll,
                   child: Text(_isAllSelected ? l10n.deselectAll : l10n.selectAll),
                 ),
               ],
             ),
             
             // Page Grid
             SizedBox(
               width: double.maxFinite,
               height: 200, // Fixed height for scrolling
               child: GridView.builder(
                 itemCount: widget.document.pages.length,
                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                   crossAxisCount: 3,
                   childAspectRatio: 0.8,
                   crossAxisSpacing: 8,
                   mainAxisSpacing: 8,
                 ),
                 itemBuilder: (context, index) {
                   final isSelected = _selectedPages[index];
                   return InkWell(
                     onTap: () {
                        setState(() {
                          _selectedPages[index] = !_selectedPages[index];
                           // Update Select All state based on individual selection
                          _isAllSelected = _selectedPages.every((p) => p);
                        });
                     },
                     child: Container(
                       decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(8),
                         border: Border.all(
                           color: isSelected ? Theme.of(context).primaryColor : Colors.grey.withValues(alpha: 0.3),
                           width: isSelected ? 2 : 1,
                         ),
                         color: isSelected ? Theme.of(context).colorScheme.surfaceContainerHighest : null,
                       ),
                       child: Column(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                           Icon(
                             Icons.description_outlined,
                             color: isSelected ? Theme.of(context).primaryColor : Colors.grey,
                             size: 32,
                           ),
                           const SizedBox(height: 4),
                           Text(
                             l10n.pageIndex(index + 1),
                             style: TextStyle(
                               color: isSelected ? Theme.of(context).primaryColor : Colors.grey,
                               fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                             ),
                           ),
                           if (isSelected)
                             const Icon(Icons.check_circle, size: 16, color: Colors.green),
                         ],
                       ),
                     ),
                   );
                 },
               ),
             ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(l10n.cancel),
        ),
        FilledButton(
          onPressed: _selectedPages.contains(true) 
             ? () {
                 final selectedIndices = <int>[];
                 for (int i = 0; i < _selectedPages.length; i++) {
                   if (_selectedPages[i]) selectedIndices.add(i);
                 }
                 
                 Navigator.pop(context, {
                   'includeOcr': _includeOcrText,
                   'selectedIndices': selectedIndices,
                 });
               }
             : null, // Disable if no pages selected
          child: Text(l10n.exportAction),
        ),
      ],
    );
  }
}
