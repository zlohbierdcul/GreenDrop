import 'package:flutter/cupertino.dart';
import 'package:greendrop/src/data/repositories/interfaces/authentication_repository.dart';
import 'package:greendrop/src/data/repositories/strapi/strapi_authentication_repository.dart';
import 'package:greendrop/src/domain/models/user.dart';

class AccountProvider with ChangeNotifier {
  IAuthenticationRepository authRepository = StrapiAuthenticationRepository();
  late User _user;
  bool _isEditing = false;
  bool _isLoading = true;


  User get user => _user;
  bool get isEditing => _isEditing;
  bool get isLoading => _isLoading;

  void loadAccountData() async {
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

  void updateGreendops(double totalCosts, int discount) {
    _user.greenDrops = (totalCosts ~/ 2) + _user.greenDrops;
    _user.greenDrops -= discount;
    _user.setGreendrops(_user.greenDrops);
    updateAccount(_user);
    notifyListeners();
  }

  // Methode zum Abbrechen und Zurücksetzen
  void cancelEditing(BuildContext context) {
    _isEditing = false;
    loadAccountData();
    notifyListeners();
  }

  Future<User> fetchUser(id) {
    return authRepository.fetchUser(id);
  }
}