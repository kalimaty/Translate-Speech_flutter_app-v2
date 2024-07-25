import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class TranslationDetailsScreen extends StatelessWidget {
  final String originalText;
  final List<String> translations;
  final List<String> languages;
  final List<String>? languageCodes;

  TranslationDetailsScreen({
    required this.originalText,
    required this.translations,
    required this.languages,
    this.languageCodes,
  });

  final FlutterTts flutterTts = FlutterTts();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('تفاصيل الترجمة'),
        centerTitle: true,
        backgroundColor: Color(0xffFFC100),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text(
              'النص الأصلي: $originalText',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Table(
                  border: TableBorder.all(color: Colors.grey),
                  columnWidths: const {
                    0: FlexColumnWidth(2),
                    1: FlexColumnWidth(3),
                    // 2: FlexColumnWidth(2),
                    3: FlexColumnWidth(1),
                  },
                  children: [
                    TableRow(
                      decoration: BoxDecoration(color: Colors.amberAccent),
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('اللغة',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('الترجمة',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.all(8.0),
                        //   child: Text('كود اللغة',
                        //       textAlign: TextAlign.center,
                        //       style: TextStyle(fontWeight: FontWeight.bold)),
                        // ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('الصوت',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                    ...List.generate(translations.length, (index) {
                      return TableRow(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(languages[index],
                                textAlign: TextAlign.center),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(translations[index],
                                textAlign: TextAlign.center),
                          ),
                          // Padding(
                          //   padding: const EdgeInsets.all(8.0),
                          //   child: Text(languageCodes[index],
                          //       textAlign: TextAlign.center),
                          // ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: IconButton(
                              icon: Icon(Icons.volume_up),
                              onPressed: () {
                                _speak(
                                    translations[index], languageCodes![index]);
                              },
                            ),
                          ),
                        ],
                      );
                    }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _speak(String text, String languageCode) async {
    await flutterTts.setLanguage(languageCode);
    await flutterTts.setPitch(1);
    await flutterTts.setVolume(1);
    await flutterTts.setSpeechRate(1);
    await flutterTts.speak(text);
  }
}
