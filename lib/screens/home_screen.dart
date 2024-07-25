import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_models/translation_view_model.dart';
import '../widgets/language_list_view.dart';
import 'translation_details_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<TranslationViewModel>(
      builder: (context, viewModel, child) {
        return Scaffold(
          backgroundColor: Colors.amber,
          appBar: AppBar(
            title: Text('Translate & Speech'),
            centerTitle: true,
            backgroundColor: Color(0xffFFC100),
            actions: [
              IconButton(
                icon: Icon(Icons.refresh),
                onPressed: viewModel.reset,
              ),
            ],
          ),
          body: Column(
            children: [
              TextField(
                controller: viewModel.textController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(25),
                  hintText: 'Enter Text...',
                  hintStyle: TextStyle(color: Colors.white),
                  border: InputBorder.none,
                  filled: true,
                  fillColor: Color(0xff263238),
                  suffixIcon: viewModel.loading
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.white,
                          ),
                        )
                      : IconButton(
                          icon: Icon(
                            Icons.translate,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            if (viewModel.inputText.isNotEmpty)
                              viewModel.translate();
                          },
                        ),
                ),
                onChanged: (input) {
                  viewModel.inputText = input;
                },
              ),
              LanguageListView(),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (viewModel.translatedTexts.isNotEmpty) {
                    _showSaveDialog(context, viewModel);
                  }
                },
                child: Text('حفظ الترجمة'),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showSaveDialog(BuildContext context, TranslationViewModel viewModel) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('حفظ الترجمة'),
          content: Text('هل تريد حفظ الترجمة والذهاب إلى شاشة التفاصيل؟'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('إلغاء'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                List<String> selectedTranslations = [];
                List<String> selectedLanguages = [];
                List<String> selectedLanguageCodes = [];

                for (int i = 0; i < viewModel.selectedLanguages.length; i++) {
                  if (viewModel.selectedLanguages[i]) {
                    selectedTranslations.add(viewModel.translatedTexts[i]);
                    selectedLanguages.add(viewModel.defaultTexts[i]);
                    selectedLanguageCodes.add(viewModel.languagesCode[i]);
                  }
                }

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TranslationDetailsScreen(
                      originalText: viewModel.inputText,
                      translations: selectedTranslations,
                      languages: selectedLanguages,
                      languageCodes: selectedLanguageCodes,
                    ),
                  ),
                ).then((_) {
                  // Call reset when returning to HomeScreen
                  viewModel.reset();
                });
              },
              child: Text('نعم'),
            ),
          ],
        );
      },
    );
  }
}
