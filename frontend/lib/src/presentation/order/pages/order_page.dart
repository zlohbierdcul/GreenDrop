import 'package:flutter/material.dart';
import 'package:greendrop/src/domain/models/shop.dart';
import 'package:greendrop/src/presentation/account/provider/user_provider.dart';
import 'package:greendrop/src/presentation/common_widgets/app_drawer.dart';
import 'package:greendrop/src/presentation/common_widgets/center_constrained_body.dart';
import 'package:greendrop/src/presentation/order/pages/order_confirmation_page.dart';
import 'package:greendrop/src/presentation/order/widgets/order_greendrop_discount.dart';
import 'package:greendrop/src/presentation/order/widgets/order_payment_selection.dart';
import 'package:greendrop/src/presentation/order/widgets/order_product_list.dart';
import 'package:greendrop/src/presentation/order/widgets/order_user_info.dart';
import 'package:greendrop/src/presentation/products/provider/cart_provider.dart';
import 'package:provider/provider.dart';

import 'package:greendrop/src/presentation/order/provider/order_provider.dart';

import '../../common_widgets/no_swipe_page_route.dart';

class OrderPage extends StatelessWidget {
  final Shop shop;

  const OrderPage({super.key, required this.shop});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // loading Appbar
      appBar: AppDrawer.buildGreendropsAppBar(context),
      body: Consumer3<UserProvider, CartProvider, OrderProvider>(
        builder: (context, userProvider, cartProvider, orderProvider, child) {
          WidgetsBinding.instance.addPostFrameCallback(
                  (_) => orderProvider.initializeSelectedAddress());
          return CenterConstrainedBody(
            body: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          const SizedBox(height: 12),
                          Text(
                            "Bestellung bei ${shop.name}",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          // load in side content widgets
                          const SizedBox(height: 12),
                          OrderUserInfo(shop: shop),
                          const SizedBox(height: 12),
                          const OrderPaymentSelection(),
                          const SizedBox(height: 12),
                          const OrderGreendropDiscount(),
                          const SizedBox(height: 12),
                          OrderProductList(shop: shop),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  // Button creates the Order and updates user GreenDrops
                  child: FilledButton(
                    onPressed: () {
                      orderProvider.createOrder(shop, cartProvider.orderItems);
                      userProvider.updateGreendops(cartProvider.getTotalCosts(),
                          orderProvider.discount.value);
                      Navigator.of(context).push(
                        NoSwipePageRoute(
                          builder: (context) =>
                              OrderConfirmationPage(
                                earnedGreenDrops: cartProvider
                                    .getTotalCosts() ~/ 2,
                                orderID: orderProvider.order?.id,),
                        ),
                      );
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 10),
                          Text(
                            "Jetzt bestellen!",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          SizedBox(width: 15),
                          Icon(Icons.receipt),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      )
    );
  }
}
