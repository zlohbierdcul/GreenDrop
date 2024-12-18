import 'package:flutter/material.dart';
import 'package:greendrop/src/presentation/account/provider/account_data_provider.dart';
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
            child: accountProvider.user != null ? Stack(
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
                                style: TextStyle(fontWeight: FontWeight.bold),
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
                                style: TextStyle(fontWeight: FontWeight.bold),
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
                                style: TextStyle(fontWeight: FontWeight.bold),
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
                                style: TextStyle(fontWeight: FontWeight.bold),
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
                                style: TextStyle(fontWeight: FontWeight.bold),
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
            ) : const CircularProgressIndicator(),
          ),
        ),
      ],
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
              TextEditingController(text: accountProvider.user!.userName);
          TextEditingController firstNameController =
              TextEditingController(text: accountProvider.user!.firstName);
          TextEditingController lastNameController =
              TextEditingController(text: accountProvider.user!.lastName);
          TextEditingController emailController =
              TextEditingController(text: accountProvider.user!.eMail);
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
