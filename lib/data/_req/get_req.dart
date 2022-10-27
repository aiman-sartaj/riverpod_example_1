import 'package:http/http.dart' as http;

class GetReq {
  GetReq._();

  static Future<http.Response> get(String url) async {
    return await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );
  }
}
