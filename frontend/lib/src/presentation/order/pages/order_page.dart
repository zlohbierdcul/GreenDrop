import 'package:flutter/material.dart';
import 'package:greendrop/src/domain/models/shop.dart';
import 'package:greendrop/src/presentation/account/provider/account_data_provider.dart';
import 'package:greendrop/src/presentation/common_widgets/app_drawer.dart';
import 'package:greendrop/src/presentation/order/pages/order_confirmation_page.dart';
import 'package:greendrop/src/presentation/order/provider/order_provider.dart';
import 'package:greendrop/src/presentation/order/widgets/order_greendrop_discount.dart';
import 'package:greendrop/src/presentation/order/widgets/order_payment_selection.dart';
import 'package:greendrop/src/presentation/order/widgets/order_product_list.dart';
import 'package:greendrop/src/presentation/order/widgets/order_user_info.dart';
import 'package:greendrop/src/presentation/products/provider/cart_provider.dart';
import 'package:provider/provider.dart';

class OrderPage extends StatelessWidget {
  final Shop shop;

  const OrderPage({super.key, required this.shop});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppDrawer.buildGreendropsAppBar(context),
      body: Consumer2<AccountProvider, CartProvider>(
        builder: (context, accountProvider, cartProvider, child) =>
            Stack(alignment: Alignment.bottomCenter, children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(
                  "Bestellung bei ${shop.name}",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20),
                ),
                const OrderUserInfo(),
                const OrderPaymentSelection(),
                const OrderGreendropDiscount(),
                const OrderProductList()
              ],
            ),
          ),
          Consumer2<OrderProvider, CartProvider>(
            builder: (context, orderProvider, cartProvider, child) => Padding(
                padding: const EdgeInsets.all(16.0),
                child: FilledButton(
                    onPressed: () => {
                          orderProvider.createOrder(
                              shop, cartProvider.orderItems),
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  const OrderConfirmationPage()))
                        },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Jetzt bestellen!",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(Icons.receipt)
                      ],
                    ))),
          )
        ]),
      ),
    );
  }
}
