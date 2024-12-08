
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginProvider extends ChangeNotifier {
  bool _isPasswordVisible = false;
  bool get isPasswordVisible => _isPasswordVisible;

  bool _rememberMeTicked = false;
  bool get rememberMeTicked => _rememberMeTicked;

  void setIsPasswordVisible(bool b) {
    _isPasswordVisible = b;
    notifyListeners();
  }

  void setRememberMeTicked(bool b) {
    _rememberMeTicked = b;
    notifyListeners();
  }

  void setIsLoggedIn() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool("isLoggedIn", _rememberMeTicked);
  }
}