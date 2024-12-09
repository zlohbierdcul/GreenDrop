import 'package:flutter/material.dart';
import 'package:greendrop/src/domain/models/address.dart';
import 'package:greendrop/src/presentation/account/provider/account_data_provider.dart';
import 'package:greendrop/src/presentation/account/widgets/user_address.dart';
import 'package:provider/provider.dart';

class UserAddressList extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Consumer<AccountProvider>(
      builder: (context, accountProvider, child) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 16.0, top: 16),
            child: Text("Hauptadresse:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
          UserAddress(
              address: accountProvider.user.addresses
                  .firstWhere((address) => address.isPrimary == true)),
          const Padding(
            padding: EdgeInsets.only(left: 16.0, top: 16),
            child: Text("Weitere Adressen:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
          ...createAddresses(accountProvider.user.addresses)
        ]
      ),
    );
  }

  List<Widget> createAddresses(List<Address> addresses) {
    List<Address> nonPrimaryAddresses = addresses.where((a) => !a.isPrimary!).toList();
    if (nonPrimaryAddresses.isEmpty) {
      return [Padding(
        padding: const EdgeInsets.all(8.0),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Keine weiteren Addressen hinterlegt.")
          ],
        ),
      )];
    } else {
      return nonPrimaryAddresses.map((a) => UserAddress(address: a)).toList();
    }
  }
}
