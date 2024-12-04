import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../common_widgets/app_drawer.dart';
import '../../../common_widgets/dropdown.dart';
import '../../../theme/theme_provider.dart';
import '../domain/account.dart';
import '../domain/account_data_provider.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  List<DropdownMenuItem<String>> get dropdownMenuItems {
    return [
      const DropdownMenuItem<String>(
          key: Key("theme_1"), value: "dark", child: Text("Dark")),
      const DropdownMenuItem<String>(
          key: Key("theme_2"), value: "light", child: Text("Light")),
      const DropdownMenuItem<String>(
          key: Key("theme_3"), value: "system", child: Text("System")),
    ];
  }

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
    Account? account = accountProvider.account;
    if (account != null) {
      _userNameController.text = account.userName;
      _firstNameController.text = account.firstName;
      _lastNameController.text = account.lastName;
      _emailController.text = account.email;
      _streetController.text = account.street;
      _houseNumberController.text = account.houseNumber.toInt().toString();
      _plzController.text = account.plz.toInt().toString();
      _cityController.text = account.city;
      _numberController.text = account.number;
    }
  }

  Account _createAccountFromControllers(String id) {
    return Account(
      id: id,
      userName: _userNameController.text,
      firstName: _firstNameController.text,
      email: _emailController.text,
      lastName: _lastNameController.text,
      street: _streetController.text,
      houseNumber: int.tryParse(_houseNumberController.text) ?? 0,
      plz: int.tryParse(_plzController.text) ?? 0,
      city: _cityController.text,
      number: _numberController.text,
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
                await changePassword(newPasswordController.text);
                Navigator.of(context).pop();
              },
              child: const Text("Passwort sicher ändern"),
            ),
          ],
        );
      },
    );
  }

  // Funktion, um das neue Passwort per SQL-Befehl zu speichern
  changePassword(String password) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppDrawer.buildGreendropsAppBar(context),
        body: Consumer<AccountProvider>(
          builder: (context, accountProvider, child) {
            if (accountProvider.account == null) {
              accountProvider.loadAccountData(context).then((_) {
                _initializeControllers(accountProvider);
              });
              return const Center(child: CircularProgressIndicator());
            }

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
                              'Willkommen zurück, ${accountProvider.account?.userName ?? ''}',
                              style: const TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: _buildColorSchemeDropdown(),
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
                          _buildEditableTile("Telefonnummer:",
                              _numberController, accountProvider.isEditing),
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
                                    await accountProvider
                                        .cancelEditing(context);
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
                                      await accountProvider
                                          .saveAccountData(context);
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
                  ],
                ),
              ),
            );
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

  // Helper-Methode für das Farbschema-Dropdown
  Widget _buildColorSchemeDropdown() {
    return Row(
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 32.0), // Abstand nach links
          child: SizedBox(
            width: 150, // Feste Breite für das Label
            child: Text(
              "Farbschema:",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Consumer<AppTheme>(
              builder: (context, appTheme, child) {
                return CustomDropdownButton(
                  items: dropdownMenuItems,
                  value: appTheme.themeMode.name,
                  onChanged: (s) {
                    switch (s) {
                      case "dark":
                        appTheme.themeMode = ThemeMode.dark;
                        break;
                      case "light":
                        appTheme.themeMode = ThemeMode.light;
                        break;
                      case "system":
                        appTheme.themeMode = ThemeMode.system;
                        break;
                    }
                  },
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
