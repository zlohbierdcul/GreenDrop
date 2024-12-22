import 'package:flutter/material.dart';
import 'package:greendrop/src/presentation/common_widgets/center_constrained_body.dart';
import 'package:provider/provider.dart';
import '../../products/provider/cart_provider.dart';
import 'package:greendrop/src/presentation/products/widgets/product_card.dart';
import '../widgets/total_summery_widget.dart';
import '../widgets/order_type_toggle_widget.dart';
import 'package:greendrop/src/domain/models/shop.dart';
import 'package:greendrop/src/presentation/common_widgets/app_drawer.dart';
import 'package:greendrop/src/presentation/cart/provider/ordertype_toggle_provider.dart';

class CartScreen extends StatelessWidget {
  final Shop shop;
  const CartScreen({super.key, required this.shop});
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    cartProvider.shop = shop;
    cartProvider.orderTypeToggle =
        Provider.of<OrderTypeToggleProvider>(context);

    return Consumer<CartProvider>(
      builder: (context, cartProvider, child) => Scaffold(
        appBar: AppDrawer.buildGreendropsAppBar(context),
        body: CenterConstrainedBody(
           body:  Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 20.0),
                        child: Text(
                          "Warenkorb",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ),
                      OrderTypeToggleWidget(
                          toggleProvider: cartProvider.orderTypeToggle),
                      IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: cartProvider.resetCart),
                    ],
                  )
                ),
                Expanded(
                  child: cartProvider.toCartItemList().isNotEmpty
                      ? ListView.builder(
                          itemCount: cartProvider.toCartItemList().length,
                          itemBuilder: (context, index) {
                            final item = cartProvider.toCartItemList()[index];
                            return ProductCard(product: item.product);
                          },
                        )
                      : const Center(
                          child: Text("Keine Produkte im Warenkorb.")),
                ),
                Padding(padding: EdgeInsets.all(16.0),
                
                  child: cartProvider.cart.isNotEmpty?  const TotalSummaryWidget() : null ,
                )
                  
              ],
            ),
          ],
        ),
      ),
    ),
    );
  }
}
