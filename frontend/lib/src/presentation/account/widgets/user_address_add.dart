import 'package:flutter/material.dart';
import 'package:greendrop/src/presentation/account/provider/account_data_provider.dart';
import 'package:greendrop/src/presentation/common_widgets/text_form_field.dart';
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
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Consumer<AccountProvider>(
            builder: (context, accountProvider, child) {
          TextEditingController streetController = TextEditingController();
          TextEditingController streetNumberController =
              TextEditingController();
          TextEditingController zipController = TextEditingController();
          TextEditingController cityController = TextEditingController();
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
                    const Text("Adresse hinzufügen",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                    const SizedBox(height: 18),
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
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Textfeld ist leer!';
                                }
                                return null;
                              }),
                        )
                      ],
                    ),
                    const SizedBox(height: 16),
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
                  ]),
            ),
          );
        });
      },
    );
  }
}
