import 'package:flutter/material.dart';
import 'package:greendrop/src/domain/models/shop.dart';
import 'package:greendrop/src/presentation/common_widgets/app_drawer.dart';
import 'package:greendrop/src/presentation/order/pages/order_page.dart';
import 'package:greendrop/src/presentation/products/provider/cart_provider.dart';
import 'package:greendrop/src/presentation/products/provider/product_provider.dart';
import 'package:greendrop/src/presentation/products/widgets/product_list.dart';
import 'package:greendrop/src/presentation/products/widgets/shop_info.dart';
import 'package:provider/provider.dart';

class ShopPage extends StatelessWidget {
  final Shop shop;

  const ShopPage({super.key, required this.shop});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ProductProvider>(context, listen: false).clearProducts();
      Provider.of<ProductProvider>(context, listen: false).loadShopProducts(shop);
      Provider.of<CartProvider>(context, listen: false).resetCart();
    });
    return Consumer<CartProvider>(
      builder: (context, cartProvider, child) => Scaffold(
          appBar: AppDrawer.buildGreendropsAppBar(context),
          body: Stack(alignment: Alignment.bottomCenter, children: [
            Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ShopInfo(
                            shop: shop,
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 20.0),
                            child: Text(
                              "Produkte",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                          ),
                          const ProductList(),
                          const SizedBox(
                            height: 80,
                          )
                        ]),
                  ),
                ),
              ],
            ),
            if (cartProvider.cart.isNotEmpty) ...[
              Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: FilledButton(
                      onPressed: () => {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => OrderPage(shop: shop)))
                          },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.shopping_cart),
                          const SizedBox(width: 20),
                          const Text(
                            "Zum Warenkorb",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 30,
                              height: 30,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                  borderRadius: BorderRadius.circular(15)),
                              child: Text(
                                cartProvider.getProductCount().toString(),
                                style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.primary),
                              ),
                            ),
                          )
                        ],
                      )))
            ]
          ])),
    );
  }
}
