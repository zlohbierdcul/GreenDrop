import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:greendrop/src/data/repositories/strapi/strapi_authentication_repository.dart';
import 'package:greendrop/src/presentation/account/pages/account_page.dart';
import 'package:greendrop/src/presentation/account/provider/account_data_provider.dart';
import 'package:greendrop/src/presentation/impressum/pages/impressum_page.dart';
import 'package:greendrop/src/presentation/login/pages/login_page.dart';
import 'package:greendrop/src/presentation/login/pages/register_page.dart';
import 'package:greendrop/src/presentation/login/provider/login_provider.dart';
import 'package:greendrop/src/presentation/map/provider/shop_map_provider.dart';
import 'package:greendrop/src/presentation/order/provider/order_provider.dart';
import 'package:greendrop/src/presentation/order_history/pages/order_history_page.dart';
import 'package:greendrop/src/presentation/products/provider/cart_provider.dart';
import 'package:greendrop/src/presentation/products/provider/product_provider.dart';
import 'package:greendrop/src/presentation/shops/pages/home_page.dart';
import 'package:greendrop/src/presentation/shops/provider/filter_provider.dart';
import 'package:greendrop/src/presentation/shops/provider/shop_data_provider.dart';
import 'package:greendrop/src/presentation/shops/provider/sorting_provider.dart';
import 'package:greendrop/src/presentation/theme/theme_provider.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future main() async {
  Logger.root.level = Level.ALL; // defaults to Level.INFO
  Logger.root.onRecord.listen((record) {
  });

  await dotenv.load();

  // check if user is already logged in
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isLoggedIn = prefs.getBool("isLoggedIn") ?? false;

  FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  String? userId = await secureStorage.read(key: "userId");

  if (userId != null) {
    StrapiAuthenticationRepository authRepo = StrapiAuthenticationRepository();
    authRepo.fetchUser(userId);
  }


  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => LoginProvider()),
      ChangeNotifierProvider(create: (_) => ShopDataProvider()),
      ChangeNotifierProvider(create: (_) => SortingProvider()),
      ChangeNotifierProvider(create: (_) => FilterProvider()),
      ChangeNotifierProvider(create: (_) => AccountProvider()),
      ChangeNotifierProvider(create: (_) => ProductProvider()),
      ChangeNotifierProvider(create: (_) => OrderProvider()),
      ChangeNotifierProvider(create: (_) => CartProvider()),
      ChangeNotifierProvider(create: (_) => ShopMapProvider())
    ],
    child: GreenDropApp(isLoggedIn: isLoggedIn),
  ));
}

class GreenDropApp extends StatelessWidget {
  final bool isLoggedIn;
  const GreenDropApp({super.key, required this.isLoggedIn});

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
        home: isLoggedIn ? const HomePage() : LoginPage(),
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
