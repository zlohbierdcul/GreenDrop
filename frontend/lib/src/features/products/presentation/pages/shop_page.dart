import 'package:flutter/material.dart';
import 'package:greendrop/src/features/products/presentation/widgets/shop_info.dart';
import 'package:greendrop/src/features/products/presentation/widgets/shop_product_list.dart';
import 'package:greendrop/src/features/shops/data/shop.dart';

class ShopPage extends StatelessWidget {
  final Shop shop;

  const ShopPage({super.key, required this.shop});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Row(
              children: [
                const Text('Greendrops'),
                const SizedBox(width: 8),
                TextButton(
                  onPressed: () {
                    print('2233 Greendrops');
                  },
                  child: const Text(
                    '#2233',
                  ),
                ),
              ],
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 32.0),
                child: Image.asset(
                  'assets/images/logo.png',
                  width: 40,
                  height: 40,
                ),
              ),
            ]),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(children: [
                  ShopInfo(
                    shop: shop,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Card(
                      child: ShopProductList(products: shop.products),
                    ),
                  )
                ]),
              ),
            ),
          ],
        ));
  }
}
