import 'package:flutter/material.dart';
import 'package:greendrop/src/features/orders/data/address.dart';
import 'package:greendrop/src/features/orders/data/user.dart';

class OrderUserInfo extends StatelessWidget {
  final User user;
  final Address address;

  const OrderUserInfo({super.key, required this.user, required this.address});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          Text(this.user.name),
          Text("${address.zipCode} ${address.city}"),
          Text("${address.street} ${address.streetNumber}")
        ],
      ),
    );
  }
}
