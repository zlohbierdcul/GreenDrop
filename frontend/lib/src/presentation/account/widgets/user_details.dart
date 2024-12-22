import 'package:flutter/material.dart';
import 'package:greendrop/src/presentation/account/provider/account_data_provider.dart';
import 'package:greendrop/src/presentation/common_widgets/text_form_field.dart';
import 'package:provider/provider.dart';

class UserDetails extends StatelessWidget {
  const UserDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 16.0, top: 16),
          child: Text("Persönliche Daten:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
        Consumer<AccountProvider>(
          builder: (context, accountProvider, child) => Card(
            child: accountProvider.user != null
                ? Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const Text(
                                      "Benutzername: ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      accountProvider.user!.userName,
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Text(
                                      "Vorname: ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      accountProvider.user!.firstName,
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Text(
                                      "Nachname: ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      accountProvider.user!.lastName,
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Text(
                                      "Email: ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      accountProvider.user!.eMail,
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Text(
                                      "Geburtsdatum: ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      accountProvider.user!.birthdate,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                          onPressed: () => _showPopup(context),
                          icon: const Icon(Icons.edit))
                    ],
                  )
                : const CircularProgressIndicator(),
          ),
        ),
      ],
    );
  }

  static void _showPopup(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Consumer<AccountProvider>(
            builder: (context, accountProvider, child) {
          TextEditingController userNameController =
              TextEditingController(text: accountProvider.user!.userName);
          TextEditingController firstNameController =
              TextEditingController(text: accountProvider.user!.firstName);
          TextEditingController lastNameController =
              TextEditingController(text: accountProvider.user!.lastName);
          TextEditingController emailController =
              TextEditingController(text: accountProvider.user!.eMail);
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
                    const SizedBox(height: 16),
                    CustomTextFormField(
                        icon: const Icon(Icons.person_outline),
                        hintText: "Benutzername",
                        controller: userNameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Textfeld ist leer!';
                          }
                          return null;
                        }),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Flexible(
                          flex: 4,
                          child: CustomTextFormField(
                              icon: const Icon(Icons.badge_outlined),
                              hintText: "Vorname",
                              controller: firstNameController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Textfeld ist leer!';
                                }
                                return null;
                              }),
                        ),
                        const SizedBox(width: 16),
                        Flexible(
                          flex: 5,
                          child: CustomTextFormField(
                              hintText: "Nachname",
                              controller: lastNameController,
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
                    CustomTextFormField(
                        icon: const Icon(Icons.email_outlined),
                        hintText: "E-Mail",
                        controller: emailController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Textfeld ist leer!';
                          }
                          return null;
                        }),
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
                            onPressed: () => accountProvider.handleDetailEdit(
                                formKey,
                                userNameController.text,
                                firstNameController.text,
                                lastNameController.text,
                                emailController.text),
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
