import 'package:flutter/material.dart';
import 'package:greendrop/src/presentation/order/provider/order_provider.dart';
import 'package:provider/provider.dart';

class OrderUserInfo extends StatelessWidget {
  const OrderUserInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Bestellddetails:",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                Consumer<OrderProvider>(
                  builder: (context, orderProvider, child) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${orderProvider.user.firstName} ${orderProvider.user.lastName}"),
                      if (orderProvider.user.addresses.isNotEmpty) ...[
                        Text("${orderProvider.user.addresses[0].zipCode} ${orderProvider.user.addresses[0].city}"),
                        Text("${orderProvider.user.addresses[0].street} ${orderProvider.user.addresses[0].streetNumber}")
                      ]
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
