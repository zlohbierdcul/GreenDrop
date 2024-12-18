import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:greendrop/src/data/repositories/interfaces/authentication_repository.dart';
import 'package:greendrop/src/data/repositories/strapi/strapi_authentication_repository.dart';
import 'package:greendrop/src/domain/models/address.dart';
import 'package:greendrop/src/domain/models/user.dart';
import 'package:greendrop/src/presentation/login/pages/login_page.dart';

import '../../../../main.dart';

class AccountProvider with ChangeNotifier {
  IAuthenticationRepository authRepository = StrapiAuthenticationRepository();
  User? _user;
  bool _isEditing = false;
  bool _isLoading = true;
  bool _isPrimary = false;
  Address? _selectedAddress;

  User? get user => _user;
  bool get isEditing => _isEditing;
  bool get isLoading => _isLoading;
  bool get isPrimary => _isPrimary;
  Address? get selectedAddress => _selectedAddress;

  void loadAccountData() async {
    _user = authRepository.getUser();
    if (_user == null) return;
    _selectedAddress = _user!.addresses.firstWhere((a) => a.isPrimary == true,
        orElse: () => _user!.addresses[0]);
    _isPrimary = _selectedAddress?.isPrimary ?? false;
    _selectedAddress = _user!.addresses.firstWhere((a) => a.isPrimary == true,
        orElse: () => _user!.addresses[0]);
    _isPrimary = _selectedAddress?.isPrimary ?? false;

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

  void togglePrimary() {
    _isPrimary = !_isPrimary;
    notifyListeners();
  }

  void setPrimary(bool v) {
    _isPrimary = v;
    notifyListeners();
  }

  void signOut() async {
    // sign out user in repository;
    authRepository.signOut();
    Navigator.pushAndRemoveUntil(
        navigatorKey.currentContext!,
        MaterialPageRoute(builder: (context) => LoginPage()),
        (Route<dynamic> route) => false);
  }

  void updateGreendops(double totalCosts, int discount) {
    if (_user == null) return;
    _user!.greenDrops = (totalCosts ~/ 2) + _user!.greenDrops;
    _user!.greenDrops -= discount;
    _user!.setGreendrops(_user!.greenDrops);
    updateAccount(_user!);
    notifyListeners();
  }

  // Methode zum Abbrechen und Zurücksetzen
  void cancelEditing(BuildContext context) {
    _isEditing = false;
    loadAccountData();
    notifyListeners();
  }

  void deleteAddress(Address address) {
    authRepository.deleteAddress(address);

    loadAccountData();
    loadAccountData();
    notifyListeners();

    Navigator.of(navigatorKey.currentContext!).pop();
  }

  void handleDetailEdit(GlobalKey<FormState> formKey, String userName,
      String firstName, String lastName, String email) {
    if (formKey.currentState?.validate() ?? false) {
      User editedUser = User(
          id: _user!.id,
          userName: userName,
          firstName: firstName,
          lastName: lastName,
          birthdate: _user!.birthdate,
          greenDrops: _user!.greenDrops,
          eMail: email,
          addresses: _user!.addresses);
      authRepository.updateUser(editedUser);
      _user = editedUser;
      notifyListeners();
      Navigator.of(navigatorKey.currentContext!).pop();
    }
  }

  void handleAddressEdit(
      GlobalKey<FormState> formkey,
      String street,
      String streetNumber,
      String zipCode,
      String city,
      bool isPrimary,
      Address address) {
    if (formkey.currentState?.validate() ?? false) {
      Address editedAddress = Address(
          id: address.id,
          street: street,
          streetNumber: streetNumber,
          zipCode: zipCode,
          city: city,
          isPrimary: isPrimary);

      if (address.isPrimary != isPrimary) {
        changePrimaryAddress();
      }

      authRepository.updateUserAddress(editedAddress);
      _user!.changeAddress(editedAddress);
      _selectedAddress = _user!.addresses.firstWhere((a) => a.isPrimary == true);
      notifyListeners();
      Navigator.of(navigatorKey.currentContext!).pop();
    }
  }

  void handleAddressAdd(
    GlobalKey<FormState> formkey,
    String street,
    String streetNumber,
    String zipCode,
    String city,
  ) {
    Address address = Address(
        id: "0",
        street: street,
        streetNumber: streetNumber,
        zipCode: zipCode,
        city: city,
        isPrimary: false);

    _user!.addresses.add(address);
    authRepository.addAddress(address);
    notifyListeners();
    Navigator.of(navigatorKey.currentContext!).pop();
  }

  void changePrimaryAddress() {
    Address address = _user!.addresses.firstWhere((a) => a.isPrimary == true);
    Address editedAddress = Address(
        id: address.id,
        street: address.street,
        streetNumber: address.streetNumber,
        zipCode: address.zipCode,
        city: address.city,
        isPrimary: false);

    authRepository.updateUserAddress(editedAddress);
    _user!.changeAddress(editedAddress);
    _selectedAddress = _user!.addresses.firstWhere((a) => a.isPrimary == true,
        orElse: () => _user!.addresses[0]);
    notifyListeners();
  }

  void handleAddressChange(dynamic a) {
    _selectedAddress = a;
    _isPrimary = a.isPrimary ?? false;
    notifyListeners();
  }

  int sortAddresses(Address a, Address b) {
    final aPrimary = a.isPrimary ?? false;
    final bPrimary = b.isPrimary ?? false;
    if (bPrimary && !aPrimary) return 1;
    if (aPrimary && !bPrimary) return -1;
    return 0;
  }

  void fetchUser() {
    if (_user != null) return;
    _isLoading = true;
    FlutterSecureStorage secureStorage = const FlutterSecureStorage();
    secureStorage.read(key: "userId").then((id) {
      if (id != null) {
        StrapiAuthenticationRepository authRepo =
        StrapiAuthenticationRepository();
        authRepo
            .fetchUser(id)
            .then((_) => loadAccountData());
      }
    });
  }
}