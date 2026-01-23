import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mlkit_translation/google_mlkit_translation.dart';
import 'package:scanvault/services/translation_service.dart';

class TranslationScreen extends StatefulWidget {
  final String? initialText;

  const TranslationScreen({
    super.key,
    this.initialText,
  });

  @override
  State<TranslationScreen> createState() => _TranslationScreenState();
}

class _TranslationScreenState extends State<TranslationScreen> {
  late TextEditingController _sourceController;
  late TextEditingController _targetController;
  
  TranslateLanguage _sourceLanguage = TranslateLanguage.english;
  TranslateLanguage _targetLanguage = TranslateLanguage.spanish;
  
  bool _isTranslating = false;
  bool _isDownloading = false;
  String? _errorMessage;

  final List<LanguageInfo> _languages = TranslationService.getAvailableLanguages();

  @override
  void initState() {
    super.initState();
    _sourceController = TextEditingController(text: widget.initialText);
    _targetController = TextEditingController();
    
    // Initial translation if text is provided
    if (widget.initialText != null && widget.initialText!.isNotEmpty) {
      _translate();
    }
  }

  @override
  void dispose() {
    _sourceController.dispose();
    _targetController.dispose();
    super.dispose();
  }

  Future<void> _translate() async {
    if (_sourceController.text.isEmpty) return;
    
    setState(() {
      _isTranslating = true;
      _errorMessage = null;
    });

    try {
      // Check/Download models
      if (!await TranslationService.isModelDownloaded(_sourceLanguage)) {
        setState(() => _isDownloading = true);
        await TranslationService.downloadModel(_sourceLanguage);
      }
      
      if (!await TranslationService.isModelDownloaded(_targetLanguage)) {
        setState(() => _isDownloading = true);
        await TranslationService.downloadModel(_targetLanguage);
      }
      setState(() => _isDownloading = false);

      final result = await TranslationService.translate(
        _sourceController.text,
        _sourceLanguage,
        _targetLanguage,
      );

      if (mounted) {
        _targetController.text = result;
      }
    } catch (e) {
      if (mounted) {
        setState(() => _errorMessage = e.toString());
      }
    } finally {
      if (mounted) {
        setState(() => _isTranslating = false);
      }
    }
  }

  void _swapLanguages() {
    setState(() {
      final temp = _sourceLanguage;
      _sourceLanguage = _targetLanguage;
      _targetLanguage = temp;
      
      final tempText = _sourceController.text;
      _sourceController.text = _targetController.text;
      _targetController.text = tempText;
    });
    _translate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Translation'),
        elevation: 0,
      ),
      body: Column(
        children: [
          // Language Selectors
          Card(
            margin: EdgeInsets.zero,
            shape: const RoundedRectangleBorder(),
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: _buildLanguageDropdown(
                      _sourceLanguage,
                      (lang) {
                        if (lang != null) {
                          setState(() => _sourceLanguage = lang);
                          _translate();
                        }
                      },
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.swap_horiz),
                    onPressed: _swapLanguages,
                  ),
                  Expanded(
                    child: _buildLanguageDropdown(
                      _targetLanguage,
                      (lang) {
                        if (lang != null) {
                          setState(() => _targetLanguage = lang);
                          _translate();
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          if (_isDownloading)
            const LinearProgressIndicator(),

          if (_errorMessage != null)
             Container(
               padding: const EdgeInsets.all(8),
               color: Colors.red.withValues(alpha: 0.1),
               width: double.infinity,
               child: Text(
                 _errorMessage!,
                 style: const TextStyle(color: Colors.red),
                 textAlign: TextAlign.center,
               ),
             ),

          // Text Areas
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _buildTextField(
                  controller: _sourceController,
                  label: 'Source Text',
                  onChanged: (_) {}, // Could handle auto-translate debounce
                ),
                const SizedBox(height: 16),
                Center(
                  child: ElevatedButton.icon(
                    onPressed: _isTranslating ? null : _translate,
                    icon: _isTranslating 
                        ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2)) 
                        : const Icon(Icons.translate),
                    label: const Text('Translate'),
                  ),
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: _targetController,
                  label: 'Translation',
                  readOnly: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageDropdown(
    TranslateLanguage current,
    ValueChanged<TranslateLanguage?> onChanged,
  ) {
    return DropdownButtonHideUnderline(
      child: DropdownButton<TranslateLanguage>(
        value: current,
        isExpanded: true,
        onChanged: onChanged,
        items: _languages.map((info) {
          return DropdownMenuItem(
            value: info.language,
            child: Text(
              info.name,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 14),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    bool readOnly = false,
    ValueChanged<String>? onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: Theme.of(context).textTheme.labelMedium),
            if (readOnly && controller.text.isNotEmpty)
              IconButton(
                icon: const Icon(Icons.copy, size: 18),
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: controller.text));
                   ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Copied to clipboard')),
                  );
                },
                tooltip: 'Copy',
              ),
            if (!readOnly && controller.text.isNotEmpty)
               IconButton(
                icon: const Icon(Icons.clear, size: 18),
                onPressed: () {
                   controller.clear();
                   setState(() {});
                },
              ),
          ],
        ),
        const SizedBox(height: 4),
        TextField(
          controller: controller,
          readOnly: readOnly,
          onChanged: onChanged,
          maxLines: null,
          minLines: 5,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            filled: true,
            fillColor: Theme.of(context).colorScheme.surfaceContainerLow,
          ),
        ),
      ],
    );
  }
}
