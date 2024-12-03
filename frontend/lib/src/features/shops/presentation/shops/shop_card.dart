import 'package:flutter/material.dart';
import 'package:greendrop/src/features/products/presentation/pages/shop_page.dart';
import 'package:greendrop/src/features/shops/data/shop.dart';
import 'package:greendrop/src/features/shops/presentation/shops/shop_card_mobile.dart';
import 'package:greendrop/src/features/shops/presentation/shops/shop_card_web.dart';

class ShopCard extends StatelessWidget {
  final Shop shop;

  const ShopCard({super.key, required this.shop});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final bool isLargeScreen = width > 800;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ShopPage(shop: shop)));
        },
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: isLargeScreen ? 200 : 350,
          ),
          child: isLargeScreen
              ? WebShopCard(shop: shop)
              : MobileShopCard(shop: shop),
        ),
      ),
    );
  }
}
