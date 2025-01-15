import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:greendrop/src/data/repositories/interfaces/authentication_repository.dart';
import 'package:greendrop/src/data/repositories/strapi/strapi_authentication_repository.dart';
import 'package:intl/intl.dart';

class RegistrationProvider extends ChangeNotifier {
  IAuthenticationRepository authenticationRepository =
      StrapiAuthenticationRepository();
  int _registrationPage = 1;
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final ConfettiController _confettiController =
      ConfettiController(duration: const Duration(seconds: 2));

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

  bool _isLoading = false;
  bool _registrationSuccessful = false;

  // Getter
  int get registrationPage => _registrationPage;
  bool get isPasswordVisible => _isPasswordVisible;
  bool get isConfirmPasswordVisible => _isConfirmPasswordVisible;
  String get password => _password;
  String get confirmPassword => _confirmPassword;
  String get birthdate => _birthdate;
  bool get registrationSuccessful => _registrationSuccessful;
  TextEditingController get passwordController => _passwordController;
  TextEditingController get confirmPasswordController =>
      _confirmPasswordController;
  ConfettiController get confettiController => _confettiController;
  bool get isLoading => _isLoading;

  // Seitensteuerung
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

  // Form-Validierung
  bool validatePage(GlobalKey<FormState> formKey) {
    return formKey.currentState!.validate();
  }

  // Benutzerregistrierung
  void registerUser() async {
    _isLoading = true;
    notifyListeners();

    // Benutzer registrieren
    _registrationSuccessful = await authenticationRepository.register(
      _username,
      _email,
      _password,
      _firstname,
      _lastname,
      _birthdate,
      _street,
      _streetNumber,
      _city,
      _zipCode,
    );

    nextPage();
    notifyListeners();
    _isLoading = false;

    if (_registrationSuccessful) {
      _confettiController.play();
    }
  }

  // Geburtsdatum auswählen
  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now()
          .subtract(const Duration(days: 6570)), // subtract 18 years
      firstDate: DateTime.now()
          .subtract(const Duration(days: 36500)), // subtract 100 years
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      final formattedDate = DateFormat("yyyy-MM-dd").format(picked);
      _birthdate = formattedDate;
      notifyListeners();
    }
  }

  // Felder zurücksetzen
  void handleReset() {
    _registrationPage = 1;
    _resetFields();
    notifyListeners();
  }

  void _resetFields() {
    _username = "";
    _email = "";
    _firstname = "";
    _lastname = "";
    _birthdate = "";
    _street = "";
    _streetNumber = "";
    _city = "";
    _zipCode = "";
    _password = "";
    _confirmPassword = "";
  }

  // Setter
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
