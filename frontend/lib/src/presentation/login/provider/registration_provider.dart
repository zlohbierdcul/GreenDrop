import 'package:flutter/foundation.dart';

class RegistrationProvider extends ChangeNotifier {
  int _registrationPage = 1;
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  int get registrationPage => _registrationPage;
  bool get isPasswordVisible => _isPasswordVisible;
  bool get isConfirmPasswordVisible => _isConfirmPasswordVisible;

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
}
