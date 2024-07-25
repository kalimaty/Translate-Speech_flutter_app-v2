import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:translator/translator.dart';

class TranslationViewModel extends ChangeNotifier {
  FlutterTts _flutterTts = FlutterTts();
  GoogleTranslator _translator = GoogleTranslator();
  TextEditingController _textEditingController = TextEditingController();

  List<String> _translatedTexts = List.filled(9, '');
  List<bool> _showTranslation = List.filled(9, false);
  List<bool> _selectedLanguages =
      List.filled(9, false); // Track selected languages

  bool _loading = false;
  String _inputText = '';

  List<String> _languagesCode = [
    'ar',
    'en',
    'fr',
    'zh-cn',
    'hi',
    'de',
    'it',
    'es',
    'ja',
  ];

  List<String> _defaultTexts = [
    'Arabic Egypt',
    'English United Kingdom',
    'French',
    'Chinese',
    'Hindi',
    'German',
    'Italian',
    'Spanish',
    'Japanese',
  ];

  List<String> _flags = [
    'egypt.jpg',
    'united-kingdom.png',
    'france.png',
    'china.png',
    'india.png',
    'germany.png',
    'italy.png',
    'spain.png',
    'japan.png',
  ];

  // Getters
  List<String> get translatedTexts => _translatedTexts;
  List<bool> get showTranslation => _showTranslation;
  List<bool> get selectedLanguages =>
      _selectedLanguages; // Getter for selectedLanguages
  List<String> get languagesCode => _languagesCode;
  List<String> get defaultTexts => _defaultTexts;
  List<String> get flags => _flags;
  bool get loading => _loading;
  String get inputText => _inputText;
  TextEditingController get textController => _textEditingController;

  set inputText(String value) {
    _inputText = value;
  }

  Future<void> translate() async {
    _loading = true;
    notifyListeners();

    List<String> translatedTexts = [];
    for (String code in _languagesCode) {
      Translation translation =
          await _translator.translate(_inputText, to: code);
      translatedTexts.add(translation.text);
    }

    _translatedTexts = translatedTexts;
    _showTranslation = List.filled(9, false);
    _selectedLanguages = List.filled(9, false); // Reset selected languages
    _loading = false;
    notifyListeners();
  }

  Future<void> speak(String languageCode, String text) async {
    await _flutterTts.setLanguage(languageCode);
    await _flutterTts.setPitch(1);
    await _flutterTts.setVolume(1);
    await _flutterTts.setSpeechRate(1);
    await _flutterTts.speak(text);
  }

  void toggleTranslation(int index) {
    _showTranslation[index] = !_showTranslation[index];
    _selectedLanguages[index] = true; // Mark the language as selected
    notifyListeners();
  }

  void reset() {
    _inputText = '';
    _textEditingController.clear();
    _translatedTexts = List.filled(9, '');
    _showTranslation = List.filled(9, false);
    _selectedLanguages = List.filled(9, false); // Reset selected languages
    notifyListeners();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }
}
