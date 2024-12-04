import 'package:flutter/material.dart';
import 'package:greendrop/src/features/products/presentation/pages/product_page.dart';
import 'package:greendrop/src/features/products/presentation/provider/product_provider.dart';
import 'package:greendrop/src/features/shops/data/shop.dart';
import 'package:greendrop/src/features/shops/presentation/shops/shop_card_mobile.dart';
import 'package:greendrop/src/features/shops/presentation/shops/shop_card_web.dart';
import 'package:provider/provider.dart';

class ShopCard extends StatelessWidget {
  final Shop shop;

  const ShopCard({super.key, required this.shop});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final bool isLargeScreen = width > 800;

    return Consumer<ProductProvider>(
      builder: (context, productProvider, child) => MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () {
            productProvider.setShopProducts(shop.products);
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
      ),
    );
  }
}
