import 'package:example_one/providers/cart/cart_products.dart';
import 'package:example_one/providers/products/products_provider.dart';
import 'package:example_one/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'widgets/theme_switch_button.dart';

class HomeView extends ConsumerWidget {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('10\$ Store'),
        leading: const ThemeSwitcherButton(),
        actions: [
          Stack(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(AppRoutes.cart);
                },
                icon: const Icon(Icons.shopping_cart),
              ),
              Positioned(
                left: 5,
                top: 5,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 16,
                    minHeight: 16,
                  ),
                  child: Consumer(
                    builder: (context, reference, child) {
                      final items = reference.watch(cartProductsProvider);
                      return Text(
                        items.length.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                        textAlign: TextAlign.center,
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: Consumer(
        builder: (context, reference, child) {
          final items = reference.watch(allProductsProvider);
          return items.when(
            data: (data) {
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    child: ListTile(
                      leading: SizedBox(
                        width: 80,
                        height: 100,
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: Image.network(
                                data[index].image,
                                fit: BoxFit.contain,
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Text(
                                  data[index].price.toString(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      title: Text(
                        data[index].title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Text(
                        data[index].description,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          ref.read(cartProductsProvider.notifier).addProduct(data[index]);
                        },
                      ),
                    ),
                  );
                },
              );
            },
            error: (_, __) => Center(child: Text('Error: ${items.error}')),
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
    );
  }
}
