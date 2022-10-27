import 'package:http/http.dart' as http;

class PostReq {
  PostReq._();

  static Future<http.Response> post(String url, {Map<String, dynamic>? body}) async {
    return await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: body,
    );
  }
}
