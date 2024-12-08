import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:greendrop/src/data/repositories/interfaces/authentication_repository.dart';
import 'package:greendrop/src/data/repositories/strapi/strapi_authentication_repository.dart';
import 'package:greendrop/src/domain/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountProvider with ChangeNotifier {
  IAuthenticationRepository authRepository = StrapiAuthenticationRepository();

  User? _account;
  bool _isEditing = false;

  User? get account => _account;

  bool get isEditing => _isEditing;

  AccountProvider() {
    // Speichere die Test-Account-ID, wenn der Provider initialisiert wird
    saveTestAccountId();
    loadAccountData();
  }

  //Test Account für Shared Preferences später automatisch über login
  Future<void> saveTestAccountId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('accountId', '1'); // Speichere die accountId '1'
    //print("Test accountId '1' gespeichert");
  }

  // Account-Daten aus SharedPreferences oder einer Mock-Datei laden
  Future<void> loadAccountData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accountId = prefs.getString('accountId');

    if (accountId != null) {
      String jsonData =
          await rootBundle.loadString('assets/data/mock_account.json');
      //print("JSON Data: $jsonData");
      Map<String, dynamic> data = jsonDecode(jsonData);

      if (data.containsKey(accountId)) {
        _account = User.fromJson(data[accountId]);
        notifyListeners();
      } else {
        print("Account ID not found in JSON data");
      }
    } else {
      //print("No Account ID in SharedPreferences");
    }
  }

  // Methode zum Bearbeiten der Account-Daten
  void updateAccount(User newAccount) {
    _account = newAccount;
    notifyListeners();
  }

  // Methode zum Umschalten des Bearbeitungsmodus
  void toggleEditing() {
    _isEditing = !_isEditing;
    notifyListeners();
  }

  void logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("isLoggedIn");

  }

  // Methode zum Abbrechen und Zurücksetzen
  Future<void> cancelEditing(BuildContext context) async {
    _isEditing = false;
    await loadAccountData(); // Lädt die ursprünglichen Daten erneut
    notifyListeners();
  }

  // Methode zum Speichern der Daten in die JSON-Datei
  Future<void> saveAccountData(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accountId = prefs.getString('accountId');
    if (accountId == null) return;

    String jsonData =
        await rootBundle.loadString('assets/data/mock_account.json');
    Map<String, dynamic> data = jsonDecode(jsonData);

  }
}