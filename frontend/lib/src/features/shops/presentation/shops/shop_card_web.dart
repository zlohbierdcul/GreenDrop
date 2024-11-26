import 'package:flutter/material.dart';
import 'package:greendrop/src/features/shops/data/shop.dart';
import 'package:greendrop/src/features/shops/presentation/shops/shop_card_costs.dart';
import 'package:greendrop/src/features/shops/presentation/shops/shop_card_details.dart';

class WebShopCard extends StatelessWidget {
  final Shop shop;

  const WebShopCard({super.key, required this.shop});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          // Image section
          Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
              child: AspectRatio(
                aspectRatio: 3 / 2,
                child: Image.asset(
                  "assets/images/shop1.jpg",
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Flexible(
            fit: FlexFit.tight,
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                ShopDetailRow(shop: shop),
                Expanded(child: Container()),
                ShopCostsRow(shop: shop)
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
