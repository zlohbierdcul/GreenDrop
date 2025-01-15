import 'package:flutter/material.dart';
import 'package:greendrop/src/presentation/account/provider/user_provider.dart';
import 'package:greendrop/src/presentation/common_widgets/dropdown.dart';
import 'package:greendrop/src/utils/utils.dart';
import 'package:provider/provider.dart';

class UserAddressDropdown extends StatelessWidget {
  const UserAddressDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(builder: (context, provider, child) {
      final sortedAddresses = [
        ...provider.user!.addresses
      ] // Create a copy to avoid modifying the original list
        ..sort(sortAddresses);
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CustomDropdownButton(
              items: sortedAddresses
                  .map((address) => (DropdownMenuItem(
                        value: address,
                        child: Row(
                          children: [
                            if (address.isPrimary == true) ...[
                              const Icon(Icons.home, size: 18),
                              const SizedBox(width: 8)
                            ],
                            Flexible(
                              child: Text(
                                  "${address.street} ${address.streetNumber}, ${address.city}",
                                  overflow: TextOverflow.ellipsis),
                            )
                          ],
                        ),
                      )))
                  .toList(),
              onChanged: provider.handleAddressChange,
              value: provider.selectedAddress,
              isExpanded: true),
        ],
      );
    });
  }
}
