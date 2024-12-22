import 'package:flutter/material.dart';
import 'package:greendrop/src/presentation/account/provider/user_provider.dart';
import 'package:greendrop/src/presentation/account/widgets/user_address.dart';
import 'package:greendrop/src/presentation/account/widgets/user_address_dropdown.dart';
import 'package:provider/provider.dart';

class UserAddressList extends StatelessWidget {
  const UserAddressList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, userProvider, child) =>
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Padding(
          padding: EdgeInsets.only(left: 16.0, top: 16),
          child: Text("Addressen:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: UserAddressDropdown(),
        ),
        if (userProvider.selectedAddress != null)
          UserAddress(address: userProvider.selectedAddress!)
      ]),
    );
  }
}
