import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import '../../domain/interfaces/voice_service.dart';

class VoiceServiceImpl implements IVoiceService {
  final stt.SpeechToText _speech = stt.SpeechToText();
  final FlutterTts _tts = FlutterTts();

  bool _isListening = false;

  @override
  Future<bool> initialize() async {
    await _tts.setVolume(1.0);
    await _tts.setSpeechRate(0.5);
    await _tts.setPitch(1.0);
    return await _speech.initialize();
  }

  @override
  Future<void> startListening({
    required Function(String recognizedText) onResult,
    required String languageCode,
  }) async {
    final available = await _speech.initialize();
    if (available) {
      _isListening = true;
      await _speech.listen(
        onResult: (val) {
          if (val.hasConfidenceRating || val.finalResult) {
            onResult(val.recognizedWords);
          }
        },
        localeId: languageCode, // "uz-UZ", "en-US", "ru-RU"
      );
    }
  }

  @override
  Future<void> stopListening() async {
    if (_isListening) {
      await _speech.stop();
      _isListening = false;
    }
  }

  @override
  Future<void> speak(String text, {String? languageCode}) async {
    if (languageCode != null) {
      await _tts.setLanguage(languageCode);
    }
    await _tts.speak(text);
  }

  @override
  Future<void> stopSpeaking() async {
    await _tts.stop();
  }
}
