import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:greendrop/src/features/cart/domain/cart_provider.dart';
import 'package:greendrop/src/features/cart/presentation/cart_screen.dart';
import 'package:greendrop/src/theme/theme_provider.dart';
import 'package:greendrop/src/features/cart/domain/ordertype_toggle_provide.dart';
void main() {
  runApp(const GreenDropApp());
}

class GreenDropApp extends StatelessWidget {
  const GreenDropApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AppTheme>(create: (_) => AppTheme()),
        ChangeNotifierProvider<CartProvider>(create: (_) => CartProvider()),
        ChangeNotifierProvider<OrderTypeToggleProvider>(create: (_) => OrderTypeToggleProvider()) // Add CartProvider
      ],
      builder: (context, _) => MaterialApp(
        title: 'GreenDrop',
        theme: ThemeData.from(colorScheme: AppTheme.lightTheme),
        darkTheme: ThemeData.from(colorScheme: AppTheme.darkTheme),
        themeMode: context.watch<AppTheme>().themeMode,
        debugShowCheckedModeBanner: false,
        home:  CartScreen(), // Replace Login with CartScreen
        routes: {
          '/cart': (context) =>  CartScreen(), // Define route for the CartScreen
          '/home': (context) =>  CartScreen(), // Or replace '/home' with another feature
        },
      ),
    );
  }
}
