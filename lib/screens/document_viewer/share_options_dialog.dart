import 'package:flutter/material.dart';
import '../../models/document.dart';

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
    return AlertDialog(
      title: const Text('Export PDF'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             // Include OCR Toggle
             CheckboxListTile(
               contentPadding: EdgeInsets.zero,
               title: const Text('Include OCR Text'),
               subtitle: const Text('Adds a separate page with extracted text'),
               value: _includeOcrText,
               onChanged: (val) => setState(() => _includeOcrText = val ?? false),
               enabled: widget.document.ocrText != null && widget.document.ocrText!.isNotEmpty,
             ),
             
             const Divider(),
             
             // Page Selection Header
             Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                 Text('Pages (${_selectedPages.where((p) => p).length})', 
                   style: Theme.of(context).textTheme.titleSmall,
                 ),
                 TextButton(
                   onPressed: _toggleSelectAll,
                   child: Text(_isAllSelected ? 'Deselect All' : 'Select All'),
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
                             'Page ${index + 1}',
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
          child: const Text('Cancel'),
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
          child: const Text('Export'),
        ),
      ],
    );
  }
}
