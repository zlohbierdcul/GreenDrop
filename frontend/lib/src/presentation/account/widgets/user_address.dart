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
                      "Hauptadresse: ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(address.isPrimary == true ? "Ja" : "Nein"),
                  ],
                ),
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
          Align(
            alignment: Alignment.topRight,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (address.isPrimary != true)
                  (IconButton(
                      onPressed: () => _showDeletePopup(context, address),
                      icon: Icon(
                        Icons.delete,
                        color: Theme.of(context).colorScheme.error,
                      ))),
                IconButton(
                    onPressed: () => _showEditPopup(context, address),
                    icon: const Icon(Icons.edit)),
              ],
            ),
          )
        ],
      ),
    );
  }

  static void _showDeletePopup(BuildContext context, Address address) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Consumer<AccountProvider>(
              builder: (context, accountProvider, child) => AlertDialog(
                    title: const Text("Addresse löschen?"),
                    content: const Text("Sind Sie sich sicher?"),
                    actions: [
                      TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text("Abbrechen")),
                      FilledButton(
                          onPressed: () =>
                              accountProvider.deleteAddress(address),
                          child: const Text("Löschen")),
                    ],
                  ));
        });
  }

  static void _showEditPopup(BuildContext context, Address address) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Consumer<AccountProvider>(
            builder: (context, accountProvider, child) {
          TextEditingController streetController =
              TextEditingController(text: address.street);
          TextEditingController streetNumberController =
              TextEditingController(text: address.streetNumber);
          TextEditingController zipController =
              TextEditingController(text: address.zipCode);
          TextEditingController cityController =
              TextEditingController(text: address.city);
          return AlertDialog(
            title: const Text('Persönliche Daten bearbeiten'),
            content: Form(
              key: formKey,
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                address.isPrimary ?? false
                    ? const Row()
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Hauptadresse?"),
                          Switch(
                              value: accountProvider.isPrimary,
                              onChanged: (_) => accountProvider.togglePrimary())
                        ],
                      ),
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
                      onPressed: () => accountProvider.handleAddressEdit(
                          formKey,
                          streetController.text,
                          streetNumberController.text,
                          zipController.text,
                          cityController.text,
                          accountProvider.isPrimary,
                          address),
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
