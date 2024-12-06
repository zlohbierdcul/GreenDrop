import 'package:flutter/material.dart';
import 'package:greendrop/src/presentation/account/pages/account_page.dart';
import 'package:greendrop/src/presentation/account/provider/account_data_provider.dart';
import 'package:greendrop/src/presentation/impressum/pages/impressum_page.dart';
import 'package:greendrop/src/presentation/login/pages/login_page.dart';
import 'package:greendrop/src/presentation/login/pages/register_page.dart';
import 'package:greendrop/src/presentation/order/pages/order_page.dart';
import 'package:greendrop/src/presentation/order/provider/order_provider.dart';
import 'package:greendrop/src/presentation/order_history/pages/order_history_page.dart';
import 'package:greendrop/src/presentation/products/provider/cart_provider.dart';
import 'package:greendrop/src/presentation/products/provider/product_provider.dart';
import 'package:greendrop/src/presentation/shops/pages/home_page.dart';
import 'package:greendrop/src/presentation/shops/provider/filter_provider.dart';
import 'package:greendrop/src/presentation/shops/provider/shop_data_provider.dart';
import 'package:greendrop/src/presentation/shops/provider/sorting_provider.dart';
import 'package:greendrop/src/presentation/theme/theme_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => ShopDataProvider()),
      ChangeNotifierProvider(create: (_) => SortingProvider()),
      ChangeNotifierProvider(create: (_) => FilterProvider()),
      ChangeNotifierProvider(create: (_) => AccountProvider()),
      ChangeNotifierProvider(create: (_) => ProductProvider()),
      ChangeNotifierProvider(create: (_) => OrderProvider()),
      ChangeNotifierProvider(create: (_) => CartProvider())
    ],
    child: const GreenDropApp(),
  ));
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
        home: const LoginPage(),
        routes: {
          '/home': (context) => const HomePage(),
          '/register': (context) => const Registration(),
          '/account': (context) => const AccountPage(),
          '/order_history': (context) => const OrderHistoryPage(),
          '/impressum': (context) => const ImpressumPage(),
        },
      ),
    );
  }
}
