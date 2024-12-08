import 'package:flutter/material.dart';
import 'package:greendrop/src/presentation/theme/color_scheme.dart';

class AppTheme with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  set themeMode(ThemeMode themeMode) {
    _themeMode = themeMode;
    notifyListeners();
  }

  static final lightTheme = MaterialTheme.lightScheme();
  static final darkTheme = MaterialTheme.darkScheme();
}
