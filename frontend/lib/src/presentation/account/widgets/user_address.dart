import 'package:flutter/material.dart';
import 'package:greendrop/src/domain/models/address.dart';
import 'package:greendrop/src/presentation/account/provider/user_provider.dart';
import 'package:greendrop/src/presentation/common_widgets/text_form_field.dart';
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
          return Consumer<UserProvider>(
              builder: (context, userProvider, child) => AlertDialog(
                    title: const Text("Addresse löschen?"),
                    content: const Text("Sind Sie sich sicher?"),
                    actions: [
                      TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text("Abbrechen")),
                      FilledButton(
                          onPressed: () =>
                              userProvider.deleteAddress(address),
                          child: const Text("Löschen")),
                    ],
                  ));
        });
  }

  static void _showEditPopup(BuildContext context, Address address) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Consumer<UserProvider>(
            builder: (context, userProvider, child) {
          TextEditingController streetController =
              TextEditingController(text: address.street);
          TextEditingController streetNumberController =
              TextEditingController(text: address.streetNumber);
          TextEditingController zipController =
              TextEditingController(text: address.zipCode);
          TextEditingController cityController =
              TextEditingController(text: address.city);
          return Form(
            key: formKey,
            child: Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom + 16,
                  left: 16,
                  right: 16,
                  top: 16),
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Adresse bearbeiten",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                    address.isPrimary ?? false
                        ? const Row()
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Hauptadresse?"),
                              Switch(
                                  value: userProvider.isPrimary,
                                  onChanged: (_) =>
                                      userProvider.togglePrimary())
                            ],
                          ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Flexible(
                          flex: 4,
                          child: CustomTextFormField(
                              icon: const Icon(Icons.signpost_outlined),
                              hintText: "Straße",
                              controller: streetController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Textfeld ist leer!';
                                }
                                return null;
                              }),
                        ),
                        const SizedBox(width: 16),
                        Flexible(
                          flex: 1,
                          child: CustomTextFormField(
                              hintText: "Nr",
                              controller: streetNumberController,
                              keyboardType: const TextInputType.numberWithOptions(),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Textfeld ist leer!';
                                }
                                return null;
                              }),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Flexible(
                          flex: 5,
                          child: CustomTextFormField(
                              icon: const Icon(Icons.location_city_outlined),
                              hintText: "Stadt",
                              controller: cityController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Textfeld ist leer!';
                                }
                                return null;
                              }),
                        ),
                        const SizedBox(width: 16),
                        Flexible(
                          flex: 2,
                          child: CustomTextFormField(
                              hintText: "PLZ",
                              controller: zipController,
                              keyboardType: const TextInputType.numberWithOptions(),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Textfeld ist leer!';
                                }
                                return null;
                              }),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
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
                            onPressed: () => userProvider.handleAddressEdit(
                                formKey,
                                streetController.text,
                                streetNumberController.text,
                                zipController.text,
                                cityController.text,
                                userProvider.isPrimary,
                                address),
                            child: const Text("Speichern")),
                      ],
                    )
                  ]),
            ),
          );
        });
      },
    );
  }
}
