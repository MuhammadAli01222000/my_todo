import 'package:speech_to_text/speech_to_text.dart';

class SpeechToTextService {
  static final SpeechToTextService _instance = SpeechToTextService._internal();
  factory SpeechToTextService() => _instance;
  SpeechToTextService._internal();

  final SpeechToText _speech = SpeechToText();
  bool _isAvailable = false;

  Future<bool> initSpeech() async {
    _isAvailable = await _speech.initialize();
    return _isAvailable;
  }

  Future<void> startListening({
    required void Function(String result) onResult,
    required String localeId,
  }) async {
    if (_isAvailable) {
      await _speech.listen(
        onResult: (result) => onResult(result.recognizedWords),
        localeId: localeId,
      );
    }
  }

  void stopListening() {
    _speech.stop();
  }
}
