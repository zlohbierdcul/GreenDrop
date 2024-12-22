import 'package:flutter/material.dart';
import 'package:greendrop/src/data/repositories/interfaces/authentication_repository.dart';
import 'package:greendrop/src/data/repositories/strapi/strapi_authentication_repository.dart';

class RegistrationProvider extends ChangeNotifier {
  IAuthenticationRepository authenticationRepository =
      StrapiAuthenticationRepository();
  int _registrationPage = 1;
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  String _username = "";
  String _email = "";
  String _firstname = "";
  String _lastname = "";
  String _birthdate = "";
  String _street = "";
  String _streetNumber = "";
  String _city = "";
  String _zipCode = "";
  String _password = "";
  String _confirmPassword = "";

  int get registrationPage => _registrationPage;
  bool get isPasswordVisible => _isPasswordVisible;
  bool get isConfirmPasswordVisible => _isConfirmPasswordVisible;
  String get password => _password;
  String get confirmPassword => _confirmPassword;

  void nextPage() {
    _registrationPage++;
    notifyListeners();
  }

  void previousPage() {
    _registrationPage--;
    notifyListeners();
  }

  void togglePasswordVisible() {
    _isPasswordVisible = !_isPasswordVisible;
    notifyListeners();
  }

  void toggleConfirmPasswordVisible() {
    _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
    notifyListeners();
  }

  bool validatePage(GlobalKey<FormState> formKey) {
    return formKey.currentState!.validate();
  }

  void registerUser() {
    authenticationRepository.register(_username, _email, _password, _firstname,
        _lastname, _birthdate, _street, _streetNumber, _city, _zipCode);
  }

  void setUsername(String username) => _username = username;
  void setFirstname(String firstname) => _firstname = firstname;
  void setLastname(String lastname) => _lastname = lastname;
  void setEmail(String email) => _email = email;
  void setBirthdate(String birthdate) => _birthdate = birthdate;
  void setStreet(String street) => _street = street;
  void setStreetNumber(String streetNumber) => _streetNumber = streetNumber;
  void setCity(String city) => _city = city;
  void setZipCode(String zipCode) => _zipCode = zipCode;
  void setPassword(String password) => _password = password;
  void setConfirmPassword(String confirmPassword) =>
      _confirmPassword = confirmPassword;
}
