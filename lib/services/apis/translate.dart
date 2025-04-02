import 'dart:convert';
import 'dart:io';

// Permet de traduire du texte en français à l'aide de l'API DeepL
class TranslateService {
  final String apiKey = 'b24d214c-036a-4ed3-bcd0-968daa3b9115:fx'; // Replace with your actual DeepL API key

  Future<String> translateToFrench(String text) async {
    final httpClient = HttpClient()
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
    try {
      final request = await httpClient.postUrl(Uri.parse('https://api-free.deepl.com/v2/translate'));
      request.headers.set(HttpHeaders.contentTypeHeader, 'application/x-www-form-urlencoded');
      request.headers.set('Authorization', 'DeepL-Auth-Key $apiKey'); // Add the API key to the headers
      final requestBody = 'text=$text&source_lang=EN&target_lang=FR';

      request.add(utf8.encode(requestBody));
      final response = await request.close();

      if (response.statusCode == 200) {
        final responseBody = await response.transform(utf8.decoder).join();
        final data = json.decode(responseBody);
        return data['translations'][0]['text'];
      } else {
        final responseBody = await response.transform(utf8.decoder).join();
        throw Exception('Failed to translate text: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to translate text: $e');
    }
  }
}