import 'package:flutter/material.dart';
import 'package:greendrop/src/features/account/domain/account_data_provider.dart';
import 'package:greendrop/src/features/login/login.dart';
import 'package:greendrop/src/features/login/register_page.dart';
import 'package:greendrop/src/features/shops/presentation/provider/filter_provider.dart';
import 'package:greendrop/src/features/shops/presentation/provider/shop_data_provider.dart';
import 'package:greendrop/src/features/shops/presentation/provider/sorting_provider.dart';
import 'package:greendrop/src/theme/theme_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => ShopDataProvider()),
      ChangeNotifierProvider(create: (_) => SortingProvider()),
      ChangeNotifierProvider(create: (_) => FilterProvider()),
      ChangeNotifierProvider(create: (_) => AccountProvider())
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
        home: const Login(),
        routes: {
          '/register': (context) => Registration(),
        },
      ),
    );
  }
}
