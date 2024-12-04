import 'package:flutter/material.dart';
import 'package:greendrop/src/domain/models/account.dart';

class OrderUserInfo extends StatelessWidget {
  final Account? account;

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
                Text(
                  "Bestellddetails:",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("${account?.firstName} ${account?.lastName}"),
                    Text("${account?.plz} ${account?.city}"),
                    Text("${account?.street} ${account?.houseNumber}")
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
