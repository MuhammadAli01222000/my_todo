abstract class IVoiceService {
  Future<bool> initialize();

  Future<void> startListening({
    required Function(String recognizedText) onResult,
    required String languageCode,
  });

  Future<void> stopListening();

  Future<void> speak(String text, {String? languageCode});
  Future<void> stopSpeaking();
}
