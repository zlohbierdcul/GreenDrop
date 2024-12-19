import 'package:flutter/material.dart';
import 'package:greendrop/src/presentation/account/provider/account_data_provider.dart';
import 'package:greendrop/src/presentation/common_widgets/dropdown.dart';
import 'package:provider/provider.dart';

class UserAddressDropdown extends StatelessWidget {
  const UserAddressDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AccountProvider>(
        builder: (context, provider, child) {

final sortedAddresses = [...provider.user!.addresses] // Create a copy to avoid modifying the original list
  ..sort(provider.sortAddresses);
        return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [

                CustomDropdownButton(
                    items: 
                        sortedAddresses.map((address) => (DropdownMenuItem(
                              value: address,
                              child: Row(
                                children: [
                                  if (address.isPrimary == true) ...[
                                    const Icon(Icons.home, size: 18),
                                    const SizedBox(width: 8)
                                  ],
                                  Text(
                                      "${address.street} ${address.streetNumber}, ${address.city}")
                                ],
                              ),
                            )))
                        .toList(),
                    onChanged: provider.handleAddressChange,
                    value: provider.selectedAddress,
                    isExpanded: true),
              ],
            );});
  }
}
