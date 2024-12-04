import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../domain/models/account.dart';

class AccountProvider with ChangeNotifier {
  Account? _account;
  bool _isEditing = false;

  Account? get account => _account;

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
    print("Account ID: $accountId");

    if (accountId != null) {
      String jsonData =
          await rootBundle.loadString('assets/data/mock_account.json');
      //print("JSON Data: $jsonData");
      Map<String, dynamic> data = jsonDecode(jsonData);

      if (data.containsKey(accountId)) {
        _account = Account.fromJson(accountId, data[accountId]);
        notifyListeners();
      } else {
        print("Account ID not found in JSON data");
      }
    } else {
      //print("No Account ID in SharedPreferences");
    }
  }

  // Methode zum Bearbeiten der Account-Daten
  void updateAccount(Account newAccount) {
    _account = newAccount;
    notifyListeners();
  }

  // Methode zum Umschalten des Bearbeitungsmodus
  void toggleEditing() {
    _isEditing = !_isEditing;
    notifyListeners();
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

    if (_account != null) {
      data[accountId] = _account!.toJson();

      String updatedJsonData = jsonEncode(data);
      // Hier soll ein SQL Befehl ausgeführt werden, der die neuen Daten absspeichert.
      // Danach sollen die neuen Daten geladen und im Account angezeigt werden.

      //print("Updated JSON Data: $updatedJsonData");
    }
  }
}
