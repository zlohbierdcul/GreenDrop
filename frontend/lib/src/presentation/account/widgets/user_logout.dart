import 'package:flutter/material.dart';
import 'package:greendrop/src/presentation/account/provider/user_provider.dart';
import 'package:provider/provider.dart';

class UserLogout extends StatelessWidget {
  const UserLogout({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
        builder: (context, userProvider, child) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: ElevatedButton(
                  onPressed: () => {
                        userProvider.signOut(),

                      },
                  style: TextButton.styleFrom(
                      foregroundColor: Theme.of(context).colorScheme.error),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Ausloggen"),
                        SizedBox(width: 8),
                        Icon(Icons.logout, size: 18)
                      ],
                    ),
                  )),
            ));
  }
}
