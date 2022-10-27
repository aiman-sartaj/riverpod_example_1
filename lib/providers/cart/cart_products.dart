import 'package:example_one/models/sale_item/sale_item.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartProductsNotifer extends StateNotifier<List<SaleItem>> {
  CartProductsNotifer() : super([]);

  void addProduct(SaleItem product) {
    state = [...state, product];
  }

  void removeProduct(SaleItem product) {
    state = state.where((p) => p.id != product.id).toList();
  }

  num getTotal(List<SaleItem> items) {
    if (items.isEmpty) {
      return 0.0;
    }
    return items.map((e) => e.price).reduce((value, element) => value + element).floorToDouble();
  }

  num getTotalWithDilivery(List<SaleItem> items) {
    if (hasFreeDelivery) {
      return getTotal(items);
    } else {
      return getTotal(items) + deliveryFee;
    }
  }

  void clear() {
    state = [];
  }

  bool get hasFreeDelivery => getTotal(state) >= 500;

  num get deliveryFee {
    if (state.isEmpty) {
      return 0.0;
    }
    return hasFreeDelivery ? 0 : 20;
  }

  List<List<SaleItem>> groupedItems() {
    List<List<SaleItem>> grouped = [];
    for (var element in state) {
      if (grouped.isEmpty) {
        grouped.add([element]);
      } else {
        bool found = false;
        for (int i = 0; i < grouped.length; i++) {
          if (grouped[i][0].id == element.id) {
            grouped[i].add(element);
            found = true;
            break;
          }
        }
        if (!found) {
          grouped.add([element]);
        }
      }
    }
    return grouped;
  }
}

final cartProductsProvider = StateNotifierProvider<CartProductsNotifer, List<SaleItem>>((ref) => CartProductsNotifer());
