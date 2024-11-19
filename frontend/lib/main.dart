import 'package:flutter/material.dart';
import 'package:greendrop/src/features/hamburger_menu/presentation/hamburger_menu.dart';
import 'package:greendrop/src/features/login/login.dart';
import 'package:greendrop/src/theme/theme_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const GreenDropApp());
}

class GreenDropApp extends StatelessWidget {
  const GreenDropApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AppTheme>(
      create: (_) => AppTheme(),
      builder: (context, _) => MaterialApp(
        title: 'GreenDrop',
        theme: ThemeData.from(colorScheme: AppTheme.lightTheme),
        darkTheme: ThemeData.from(colorScheme: AppTheme.darkTheme),
        themeMode: context.watch<AppTheme>().themeMode,
        debugShowCheckedModeBanner: false,
        home: const Login(),
        routes: {
          '/home': (context) => HamburgerMenu(),
        },
      ),
    );
  }
}
