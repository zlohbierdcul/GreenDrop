import 'package:flutter/material.dart';
import 'package:greendrop/src/common_widgets/app_scaffold.dart';
import 'package:greendrop/src/features/products/presentation/widgets/shop_info.dart';
import 'package:greendrop/src/features/products/presentation/widgets/shop_product_list.dart';
import 'package:greendrop/src/features/shops/data/shop.dart';

class ShopPage extends StatelessWidget {
  final Shop shop;

  const ShopPage({super.key, required this.shop});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
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
