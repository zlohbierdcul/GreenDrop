import 'package:flutter/material.dart';
import 'package:greendrop/src/domain/models/shop.dart';
import 'package:greendrop/src/presentation/order/provider/order_provider.dart';
import 'package:greendrop/src/presentation/order/widgets/address_selector.dart';
import 'package:provider/provider.dart';

class OrderUserInfo extends StatelessWidget {
  final Shop shop;
  const OrderUserInfo({super.key, required this.shop});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
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
                      Text(
                          "${orderProvider.user.firstName} ${orderProvider.user.lastName}"),
                      Text(orderProvider.user.eMail),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  "Lieferadresse:",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const SizedBox(height: 8),
                AddressSelector(shop: shop)
              ],
            ),
          ),
        ),
      ],
    );
  }
}
