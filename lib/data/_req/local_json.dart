import 'dart:convert';

import 'package:flutter/services.dart';

class AssetReq {
  AssetReq._();

  static Future<List<Map<String, dynamic>>> asset(String fileName) async {
    final String jsonString = await rootBundle.loadString('assets/json/$fileName');
    final jsonElements = jsonDecode(jsonString);
    return List<Map<String, dynamic>>.from(jsonElements);
  }
}
