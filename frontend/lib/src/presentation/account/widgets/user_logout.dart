import 'package:flutter/material.dart';
import 'package:greendrop/src/presentation/account/provider/account_data_provider.dart';
import 'package:provider/provider.dart';

class UserLogout extends StatelessWidget {
  const UserLogout({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AccountProvider>(
        builder: (context, accountProvider, child) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: ElevatedButton(
                  onPressed: () => [],
                  style: TextButton.styleFrom(
                      foregroundColor: Theme.of(context).colorScheme.error),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Ausloggen"),
                      SizedBox(width: 8),
                      Icon(Icons.logout, size: 18)
                    ],
                  )),
            ));
  }

  
}
