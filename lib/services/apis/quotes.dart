import 'dart:convert';
import 'dart:io';

class QuotesService {
  Future<Map<String, String>> generateQuote() async {
    final httpClient = HttpClient()
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;

    final request = await httpClient.getUrl(Uri.parse('https://api.quotable.io/random?maxLength=130'));
    final response = await request.close();

    if (response.statusCode == 200) {
      final responseBody = await response.transform(utf8.decoder).join();
      final data = json.decode(responseBody);
      return {
        'content': data['content'],
        'author': data['author'],
      };
    } else {
      throw Exception('Failed to load quote');
    }
  }
}