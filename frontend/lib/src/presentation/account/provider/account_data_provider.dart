import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:greendrop/main.dart';
import 'package:greendrop/src/data/repositories/interfaces/authentication_repository.dart';
import 'package:greendrop/src/data/repositories/strapi/strapi_authentication_repository.dart';
import 'package:greendrop/src/domain/models/user.dart';

class AccountProvider with ChangeNotifier {
  IAuthenticationRepository authRepository = StrapiAuthenticationRepository();
  User _user = User.genericUser;
  bool _isEditing = false;
  bool _isLoading = false;

  User get user => _user;
  bool get isEditing => _isEditing;
  bool get isLoading => _isLoading;

  void loadAccountData() {
    _isLoading = true;
    notifyListeners();

    _user = authRepository.getUser()!;

    _isLoading = false;
    notifyListeners();
  }

  // Methode zum Bearbeiten der Account-Daten
  void updateAccount(User newUser) {
    _user = newUser;
    authRepository.updateUser(newUser);
    notifyListeners();
  }

  // Methode zum Umschalten des Bearbeitungsmodus
  void toggleEditing() {
    _isEditing = !_isEditing;
    notifyListeners();
  }

  void signOut() async {
    // sign out user in repository;
    authRepository.signOut();
  }

  // Methode zum Abbrechen und Zurücksetzen
  void cancelEditing(BuildContext context) {
    _isEditing = false;
    loadAccountData(); // Lädt die ursprünglichen Daten erneut
    notifyListeners();
  }

  void handleDetailEdit(GlobalKey<FormState> formKey, String userName,
      String firstName, String lastName, String email) {
    if (formKey.currentState?.validate() ?? false) {
      User editedUser = User(
          id: _user.id,
          userName: userName,
          firstName: firstName,
          lastName: lastName,
          birthdate: _user.birthdate,
          greenDrops: _user.greenDrops,
          eMail: email,
          addresses: _user.addresses);
      authRepository.updateUser(editedUser);
      _user = editedUser;
      notifyListeners();
      Navigator.of(navigatorKey.currentContext!).pop();
    }
  }
}
