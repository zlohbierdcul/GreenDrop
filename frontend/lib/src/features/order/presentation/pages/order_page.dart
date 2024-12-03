import 'package:flutter/material.dart';
import 'package:greendrop/src/features/account/domain/account_data_provider.dart';
import 'package:greendrop/src/features/hamburger_menu/presentation/hamburger_menu.dart';
import 'package:greendrop/src/features/order/presentation/order/order_greendrop_discount.dart';
import 'package:greendrop/src/features/order/presentation/order/order_payment_selection.dart';
import 'package:greendrop/src/features/order/presentation/order/order_user_info.dart';
import 'package:greendrop/src/features/order/presentation/pages/order_confirmation.dart';
import 'package:provider/provider.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppDrawer.buildGreendropsAppBar(),
      body: Consumer<AccountProvider>(
        builder: (context, accountProvider, child) =>
            Stack(alignment: Alignment.bottomCenter, children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const Text(
                  "Bestellung bei {shop}",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                OrderUserInfo(account: accountProvider.account),
                OrderPaymentSelection(),
                OrderGreendropDiscount(),
              ],
            ),
          ),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: FilledButton(
                  onPressed: () => {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => OrderConfirmationPage()))
                      },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Jetzt bestellen!",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Icon(Icons.shopping_cart)
                    ],
                  )))
        ]),
      ),
    );
  }
}
