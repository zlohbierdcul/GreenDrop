import 'package:flutter/material.dart';
import 'package:greendrop/main.dart';
import 'package:greendrop/src/data/repositories/interfaces/authentication_repository.dart';
import 'package:greendrop/src/data/repositories/strapi/strapi_authentication_repository.dart';
import 'package:logging/logging.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginProvider extends ChangeNotifier {
  Logger log = Logger("LoginProvider");
  bool _isPasswordVisible = false;
  bool get isPasswordVisible => _isPasswordVisible;

  bool _rememberMeTicked = false;
  bool get rememberMeTicked => _rememberMeTicked;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _loginFailed = false;
  bool get loginFailed => _loginFailed;

  

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

  void loginHandler(formKey, email, password) async {
    _loginFailed = false;
    _isLoading = true;
    notifyListeners();

    if (formKey.currentState?.validate() ?? false) {
      IAuthenticationRepository authenticationRepository =
          StrapiAuthenticationRepository();
      
      bool success = false;
      try {
        success = await authenticationRepository.signIn(email, password);
      } catch (e) {
        _loginFailed = true;
        log.info("Login failed.");
      }

      if (success) {
        setIsLoggedIn();
        Navigator.of(navigatorKey.currentContext!)
            .pushReplacementNamed("/home");
      } else {
      }
    }
    _isLoading = false;
    notifyListeners();
  }
}
