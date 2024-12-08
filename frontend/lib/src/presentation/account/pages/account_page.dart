import 'package:flutter/material.dart';
import 'package:greendrop/src/domain/models/address.dart';
import 'package:greendrop/src/domain/models/user.dart';
import 'package:greendrop/src/presentation/account/widgets/color_scheme_dropdown.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../common_widgets/app_drawer.dart';
import '../provider/account_data_provider.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  static final TextEditingController _userNameController =
      TextEditingController();
  static final TextEditingController _firstNameController =
      TextEditingController();
  static final TextEditingController _lastNameController =
      TextEditingController();
  static final TextEditingController _emailController = TextEditingController();
  static final TextEditingController _streetController =
      TextEditingController();
  static final TextEditingController _houseNumberController =
      TextEditingController();
  static final TextEditingController _plzController = TextEditingController();
  static final TextEditingController _cityController = TextEditingController();
  static final TextEditingController _numberController =
      TextEditingController();

  void _initializeControllers(AccountProvider accountProvider) {
    User user = accountProvider.user;
    _userNameController.text = user.userName;
    _firstNameController.text = user.firstName;
    _lastNameController.text = user.lastName;
    _emailController.text = user.eMail;
    _streetController.text =
        user.addresses.isNotEmpty ? user.addresses[0].street : "-";
    _houseNumberController.text =
        user.addresses.isNotEmpty ? user.addresses[0].streetNumber : "-";
    _plzController.text =
        user.addresses.isNotEmpty ? user.addresses[0].zipCode : "-";
    _cityController.text =
        user.addresses.isNotEmpty ? user.addresses[0].city : "-";
  }

  User _createAccountFromControllers(String id) {
    return User(
      id: id,
      userName: _userNameController.text,
      firstName: _firstNameController.text,
      eMail: _emailController.text,
      lastName: _lastNameController.text,
      greenDrops: 0,
      birthdate: "12-12-2024",
      addresses: [
        Address(
            street: _streetController.text,
            streetNumber: _houseNumberController.text,
            zipCode: _cityController.text,
            city: _numberController.text,
            isPrimary: true)
      ],
    );
  }

  void _showChangePasswordDialog(BuildContext context) {
    final TextEditingController newPasswordController = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Passwort ändern"),
          content: TextField(
            controller: newPasswordController,
            decoration: const InputDecoration(hintText: "Neues Passwort"),
            obscureText: true,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Abbrechen"),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
              },
              child: const Text("Passwort sicher ändern"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<AccountProvider>(context, listen: false);
      provider.loadAccountData();
      _initializeControllers(provider);
    });
    return Scaffold(
        appBar: AppDrawer.buildGreendropsAppBar(context),
        body: Consumer<AccountProvider>(
          builder: (context, accountProvider, child) {
            if (accountProvider.isLoading) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(bottom: 8.0),
                        child: SizedBox(
                          width: double.infinity,
                          height: 60,
                          child: Card(
                            child: Center(
                              child: Text(
                                "Account",
                                style: TextStyle(fontSize: 24),
                              ),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 4.0),

                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Willkommen zurück, ${accountProvider.user.userName}',
                                style: const TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        child: ColorSchemeDropdown(),
                      ),

                      // ListView für die Accountdaten
                      Expanded(
                        child: ListView(
                          children: [
                            _buildEditableTile("Username:", _userNameController,
                                accountProvider.isEditing),
                            _buildEditableTile("Vorname:", _firstNameController,
                                accountProvider.isEditing),
                            _buildEditableTile("Nachname:", _lastNameController,
                                accountProvider.isEditing),
                            _buildEditableTile("E-Mail:", _emailController,
                                accountProvider.isEditing),
                            _buildEditableTile("Straße:", _streetController,
                                accountProvider.isEditing),
                            _buildEditableTile(
                                "Hausnummer:",
                                _houseNumberController,
                                accountProvider.isEditing),
                            _buildEditableTile("PLZ:", _plzController,
                                accountProvider.isEditing),
                            _buildEditableTile("Stadt:", _cityController,
                                accountProvider.isEditing),
                          ],
                        ),
                      ),
                      // Button für Passwortänderung
                      if (accountProvider.isEditing)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 12.0),
                          child: Center(
                            child: FilledButton(
                              onPressed: () {
                                _showChangePasswordDialog(context);
                              },
                              child: const Text("Passwort ändern"),
                            ),
                          ),
                        ),

                      // Speichern und Abbrechen Button
                      if (accountProvider.isEditing)
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 12.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  FilledButton(
                                    onPressed: () async {
                                      accountProvider.cancelEditing(context);
                                      _initializeControllers(accountProvider);
                                    },
                                    child: const Text("Abbrechen"),
                                  ),
                                  const SizedBox(width: 10),
                                  FilledButton(
                                    onPressed: () async {
                                      SharedPreferences prefs =
                                          await SharedPreferences.getInstance();
                                      String? accountId =
                                          prefs.getString('accountId');
                                      if (accountId != null) {
                                        accountProvider.updateAccount(
                                            _createAccountFromControllers(
                                                accountId));
                                        accountProvider.toggleEditing();
                                      }
                                    },
                                    child: const Text("Speichern"),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                      // Button zum Bearbeiten der Accountdaten
                      if (!accountProvider.isEditing)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          child: Center(
                            child: FilledButton(
                              onPressed: () {
                                accountProvider.toggleEditing();
                              },
                              child: const Text("Accountdaten bearbeiten"),
                            ),
                          ),
                        ),

                      FilledButton(
                          onPressed: () {
                            accountProvider.signOut();
                          },
                          child: const Row(
                            children: [Text("Ausloggen"), Icon(Icons.logout)],
                          ))
                    ],
                  ),
                ),
              );
            }
          },
        ));
  }

  // Helper-Methode zum Erstellen eines editierbaren Textfeldes in einem ListTile
  Widget _buildEditableTile(
      String label, TextEditingController controller, bool isEditing) {
    return ListTile(
      title: Row(
        children: [
          // Label für das Textfeld mit fester Breite
          Padding(
            padding: const EdgeInsets.only(left: 16.0), // Optional: für Abstand
            child: SizedBox(
              width: 150, // Feste Breite für das Label
              child: Text(
                label,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          // TextField, das den verbleibenden Platz einnimmt
          Expanded(
            child: TextField(
              controller: controller,
              readOnly: !isEditing, // Nur im Bearbeitungsmodus editierbar
              decoration: InputDecoration(
                hintText: controller.text,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
