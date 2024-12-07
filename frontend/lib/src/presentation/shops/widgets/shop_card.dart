import 'package:flutter/material.dart';
import 'package:greendrop/src/domain/models/shop.dart';
import 'package:greendrop/src/presentation/products/pages/product_page.dart';
import 'package:greendrop/src/presentation/products/provider/cart_provider.dart';
import 'package:greendrop/src/presentation/products/provider/product_provider.dart';
import 'package:greendrop/src/presentation/shops/widgets/shop_card_mobile.dart';
import 'package:greendrop/src/presentation/shops/widgets/shop_card_web.dart';
import 'package:provider/provider.dart';

class ShopCard extends StatelessWidget {
  final Shop shop;

  const ShopCard({super.key, required this.shop});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final bool isLargeScreen = width > 800;

    return Consumer2<ProductProvider, CartProvider>(
      builder: (context, productProvider, cartProvider, child) => MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () {
            productProvider.clearProducts();
            productProvider.loadShopProducts(shop);
            cartProvider.resetCart();
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
