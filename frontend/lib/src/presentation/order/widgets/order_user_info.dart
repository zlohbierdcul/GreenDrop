import 'package:flutter/material.dart';
import 'package:greendrop/src/domain/models/user.dart';

class OrderUserInfo extends StatelessWidget {
  final User? account;

  const OrderUserInfo({super.key, required this.account});

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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("${account?.firstName} ${account?.lastName}"),
                    if (account!.addresses.isNotEmpty) ...[
                      Text("${account?.addresses[0].zipCode} ${account?.addresses[0].city}"),
                      Text("${account?.addresses[0].street}} ${account?.addresses[0].streetNumber}")
                    ]
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
