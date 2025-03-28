import 'dart:convert';
import 'dart:io';

class TranslateService {
  final String apiKey = 'b24d214c-036a-4ed3-bcd0-968daa3b9115:fx'; // Replace with your actual DeepL API key

  Future<String> translateToFrench(String text) async {
    final httpClient = HttpClient()
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
    print('Translating text: $text');
    try {
      final request = await httpClient.postUrl(Uri.parse('https://api-free.deepl.com/v2/translate'));
      request.headers.set(HttpHeaders.contentTypeHeader, 'application/x-www-form-urlencoded');
      request.headers.set('Authorization', 'DeepL-Auth-Key $apiKey'); // Add the API key to the headers
      print('Request URI: ${request.uri}');
      print('Request Headers: ${request.headers}');
      final requestBody = 'text=$text&source_lang=EN&target_lang=FR';
      print('Request Body: $requestBody');

      request.add(utf8.encode(requestBody));
      final response = await request.close();
      print('Response Status Code: ${response.statusCode}');
      print('Response Headers: ${response.headers}');

      if (response.statusCode == 200) {
        final responseBody = await response.transform(utf8.decoder).join();
        final data = json.decode(responseBody);
        return data['translations'][0]['text'];
      } else {
        final responseBody = await response.transform(utf8.decoder).join();
        print('Response Body: $responseBody');
        throw Exception('Failed to translate text: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception occurred: $e');
      throw Exception('Failed to translate text: $e');
    }
  }
}