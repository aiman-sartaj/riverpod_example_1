import 'package:example_one/providers/cart/cart_products.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartView extends ConsumerWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mqSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wish list'),
      ),
      body: Column(
        children: [
          SizedBox(
            width: mqSize.width,
            height: mqSize.height * 0.7,
            child: Consumer(
              builder: (BuildContext context, WidgetRef ref, Widget? child) {
                ref.watch(cartProductsProvider);
                final notifier = ref.read(cartProductsProvider.notifier);
                return ListView.builder(
                  itemCount: notifier.groupedItems().length,
                  itemBuilder: (ctx, index) {
                    return Column(
                      children: [
                        ListTile(
                          title: Text(
                            notifier.groupedItems()[index][0].title,
                            maxLines: 1,
                          ),
                          subtitle: Text("${notifier.groupedItems()[index][0].price} x ${notifier.groupedItems()[index].length}"),
                          trailing: IconButton(
                            onPressed: () {
                              notifier.removeProduct(notifier.groupedItems()[index][0]);
                            },
                            icon: const Icon(Icons.delete),
                          ),
                        ),
                        const Divider(),
                      ],
                    );
                  },
                );
              },
            ),
          ),
          Expanded(
            child: Container(
              width: mqSize.width,
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).primaryColorLight.withOpacity(0.2),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Consumer(
                builder: (context, ref, child) {
                  final items = ref.watch(cartProductsProvider);
                  final notifier = ref.read(cartProductsProvider.notifier);
                  return Column(
                    children: [
                      Text("Total: \$${notifier.getTotal(items)}"),
                      const SizedBox(height: 10),
                      Text("Delivery: \$${notifier.deliveryFee}"),
                      const SizedBox(height: 10),
                      Text("Grand Total: \$${notifier.getTotalWithDilivery(items)}"),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          notifier.clear();
                        },
                        child: const Text("Checkout"),
                      ),
                    ],
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
