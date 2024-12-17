import 'package:flutter/material.dart';
import 'package:greendrop/src/presentation/account/provider/account_data_provider.dart';
import 'package:provider/provider.dart';

class UserAddressAdd extends StatelessWidget {
  const UserAddressAdd({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: [
          ElevatedButton(
              onPressed: () => _showAddPopup(context),
              child: const Padding(
                padding: EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text("Adresse hinzufügen"), Icon(Icons.add)],
                ),
              ))
        ],
      ),
    );
  }

static void _showAddPopup(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Consumer<AccountProvider>(
            builder: (context, accountProvider, child) {
          TextEditingController streetController =
              TextEditingController();
          TextEditingController streetNumberController =
              TextEditingController();
          TextEditingController zipController =
              TextEditingController();
          TextEditingController cityController =
              TextEditingController();
          return AlertDialog(
            title: const Text('Adresse hinzufügen'),
            content: Form(
              key: formKey,
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                const SizedBox(height: 16),
                TextFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text("Straße"),
                    ),
                    controller: streetController,
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
                      label: Text("Hausnummer"),
                    ),
                    controller: streetNumberController,
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
                      label: Text("Postleitzahl"),
                    ),
                    controller: zipController,
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
                      label: Text("Stadt"),
                    ),
                    controller: cityController,
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
                      onPressed: () => accountProvider.handleAddressAdd(
                          formKey,
                          streetController.text,
                          streetNumberController.text,
                          zipController.text,
                          cityController.text),
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
