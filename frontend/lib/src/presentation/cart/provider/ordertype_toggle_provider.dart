import 'package:flutter/material.dart';

class OrderTypeToggleProvider with ChangeNotifier {
  bool _isToggled = false;

  bool get isToggled => _isToggled;

  IconData get currentIcon => _isToggled ? Icons.delivery_dining : Icons.restaurant;

  void toggle() {
    _isToggled = !_isToggled;
    notifyListeners();
  }

  void setToggle(bool value) {
    _isToggled = value;
    notifyListeners();
  }
}