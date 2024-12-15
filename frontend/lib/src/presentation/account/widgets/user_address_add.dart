import 'package:flutter/material.dart';

class UserAddressAdd extends StatelessWidget {
  const UserAddressAdd({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
            onPressed: () => {},
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Adresse hinzufügen"),
                Icon(Icons.add)
              ],
            ))
      ],
    );
  }
}
