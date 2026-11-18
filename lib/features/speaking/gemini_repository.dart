import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import '../../../core/constants/api_keys.dart';

/// Provider to access the Gemini Repository globally
final geminiRepositoryProvider = Provider<GeminiRepository>((ref) {
  return GeminiRepository();
});

class GeminiRepository {
  late final GenerativeModel _model;

  GeminiRepository() {
    // একদম লেটেস্ট মডেলটিই ব্যবহার করছি, কিন্তু কোনো systemInstruction ছাড়া
    _model = GenerativeModel(
      model: 'gemini-1.5-flash',
      apiKey: ApiKeys.geminiApiKey,
    );
  }

  /// Sends a message to Gemini and returns the response string
  Future<String> sendMessage(String text) async {
    try {
      // চ্যাট সেশনের বদলে আমরা সরাসরি একটি সুন্দর প্রম্পট (Prompt) তৈরি করে পাঠাচ্ছি
      final prompt = '''
You are a friendly and expert AI English tutor. 
Help the user practice English. Keep your replies short, natural, and conversational. 
If the user makes a grammar mistake, gently correct them.

User: $text
Tutor:''';

      // সরাসরি generateContent কল করা হচ্ছে (এটি কখনো ফেইল করে না)
      final response = await _model.generateContent([Content.text(prompt)]);
      return response.text ?? 'Sorry, I did not understand that.';
    } catch (e) {
      print('Gemini Error: $e');
      return 'Error: $e';
    }
  }
}