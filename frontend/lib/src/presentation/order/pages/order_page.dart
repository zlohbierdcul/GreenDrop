import 'package:flutter/material.dart';
import 'package:greendrop/src/domain/models/shop.dart';
import 'package:greendrop/src/presentation/account/provider/account_data_provider.dart';
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

class OrderPage extends StatelessWidget {
  final Shop shop;

  const OrderPage({super.key, required this.shop});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppDrawer.buildGreendropsAppBar(context),
      body: Consumer3<AccountProvider, CartProvider, OrderProvider>(
        builder: (context, accountProvider, cartProvider, orderProvider, child) => CenterConstrainedBody(
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
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        const SizedBox(height: 12),
                        OrderUserInfo(account: accountProvider.user),
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
                child: FilledButton(
                  onPressed: () {
                    accountProvider.updateGreendops(cartProvider.getTotalCosts(), orderProvider.discount.value);
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const OrderConfirmationPage(),
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
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
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
        ),
      ),
    );
  }

}
