import 'package:flutter/material.dart';
import 'package:greendrop/src/domain/models/address.dart';
import 'package:greendrop/src/presentation/account/provider/account_data_provider.dart';
import 'package:provider/provider.dart';

class UserAddress extends StatelessWidget {
  final Address address;

  const UserAddress({super.key, required this.address});

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text(
                        "Straße: ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        address.street,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Text(
                        "Hausnummer: ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        address.streetNumber,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Text(
                        "Postleitzahl: ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        address.zipCode,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Text(
                        "Stadt: ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        address.city,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            IconButton(
                onPressed: () => _showPopup(context),
                icon: const Icon(Icons.edit))
          ],
        ),
      );
  }

  static void _showPopup(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Consumer<AccountProvider>(
            builder: (context, accountProvider, child) {
          TextEditingController userNameController =
              TextEditingController(text: accountProvider.user.userName);
          TextEditingController firstNameController =
              TextEditingController(text: accountProvider.user.firstName);
          TextEditingController lastNameController =
              TextEditingController(text: accountProvider.user.lastName);
          TextEditingController emailController =
              TextEditingController(text: accountProvider.user.eMail);
          return AlertDialog(
            title: const Text('Persönliche Daten bearbeiten'),
            content: Form(
              key: formKey,
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                TextFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text("Bentzername"),
                    ),
                    controller: userNameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Textfeld ist leer!';
                      }
                      return null;
                    }),
                const SizedBox(height: 15),
                TextFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text("Vorname"),
                    ),
                    controller: firstNameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Textfeld ist leer!';
                      }
                      return null;
                    }),
                const SizedBox(height: 15),
                TextFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text("Nachname"),
                    ),
                    controller: lastNameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Textfeld ist leer!';
                      }
                      return null;
                    }),
                const SizedBox(height: 15),
                TextFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text("Email"),
                    ),
                    controller: emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Textfeld ist leer!';
                      }
                      return null;
                    }),
              ]),
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    child: const Text('Abbrechen'),
                    onPressed: () {
                      Navigator.of(context).pop(); // Schließt das Popup
                    },
                  ),
                  FilledButton(
                      onPressed: () => accountProvider.handleDetailEdit(
                          formKey,
                          userNameController.text,
                          firstNameController.text,
                          lastNameController.text,
                          emailController.text),
                      child: const Text("Speichern")),
                ],
              )
            ],
          );
        });
      },
    );
  }
}
