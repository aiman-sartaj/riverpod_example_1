import 'package:example_one/data/_req/local_json.dart';

class SaleItemsData {
  SaleItemsData._();

  static Future<List<Map<String, dynamic>>> getAllItems() async {
    return await AssetReq.asset('products.json');
  }
}
