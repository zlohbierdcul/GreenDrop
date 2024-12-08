import 'package:flutter/material.dart';
import 'package:greendrop/src/presentation/account/provider/account_data_provider.dart';
import 'package:greendrop/src/presentation/common_widgets/app_drawer.dart';
import 'package:greendrop/src/presentation/order/pages/order_confirmation_page.dart';
import 'package:greendrop/src/presentation/order/widgets/order_greendrop_discount.dart';
import 'package:greendrop/src/presentation/order/widgets/order_payment_selection.dart';
import 'package:greendrop/src/presentation/order/widgets/order_product_list.dart';
import 'package:greendrop/src/presentation/order/widgets/order_user_info.dart';
import 'package:provider/provider.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppDrawer.buildGreendropsAppBar(context),
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
                OrderUserInfo(account: accountProvider.user),
                const OrderPaymentSelection(),
                const OrderGreendropDiscount(),
                const OrderProductList()
              ],
            ),
          ),
          Padding(
              padding: const EdgeInsets.all(16.0),
              child: FilledButton(
                  onPressed: () => {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const OrderConfirmationPage()))
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
                  )))
        ]),
      ),
    );
  }
}
