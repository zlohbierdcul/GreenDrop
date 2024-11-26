import 'package:flutter/material.dart';
import 'package:greendrop/src/features/settings/presentation/settings.dart';

import '../../account/presentation/account_page.dart';
import '../../orders/presentation/orders.dart';
import '../../settings/presentation/info_page.dart';
import '../../shops/presentation/landing_page.dart';

class HamburgerMenu extends StatefulWidget {
  const HamburgerMenu({super.key});

  @override
  State<HamburgerMenu> createState() => _HamburgerMenuState();
}

class _HamburgerMenuState extends State<HamburgerMenu> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String activePage = "Startseite";

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final bool isLargeScreen = width > 800;

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      onVerticalDragUpdate: (_) =>
          FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          titleSpacing: 0,
          leading: isLargeScreen
              ? null
              : IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () => _scaffoldKey.currentState?.openDrawer(),
                ),
          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                  "GreenDrop",
                  style: TextStyle(
                      color: Colors.green, fontWeight: FontWeight.bold),
                ),
                if (isLargeScreen) Expanded(child: _navBarItems())
              ],
            ),
          ),
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: 16.0),
              child: CircleAvatar(child: Icon(Icons.logo_dev)),
            )
          ],
        ),
        drawer: isLargeScreen ? null : _drawer(),
        body: SizedBox(
          width: 1000,
          child: ScrollConfiguration(
              behavior:
                  ScrollConfiguration.of(context).copyWith(scrollbars: false),
              child: activeScreen()),
        ),
      ),
    );
  }

  Widget _drawer() => Drawer(
        child: ListView(
          children: _menuItems
              .map((item) => ListTile(
                    onTap: () {
                      setState(() {
                        activePage =
                            item; // Update activePage with selected item
                      });
                      _scaffoldKey.currentState?.openEndDrawer();
                    },
                    title: Text(item),
                  ))
              .toList(),
        ),
      );

  Widget _navBarItems() => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: _menuItems
            .map((item) => InkWell(
                  onTap: () {
                    setState(() {
                      activePage = item;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 24.0, horizontal: 16),
                    child: Text(
                      item,
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                ))
            .toList(),
      );

  final List<String> _menuItems = <String>[
    'Startseite',
    'Bestellungen',
    'Account',
    'Einstellungen',
    'Impressum',
  ];

  Widget activeScreen() {
    switch (activePage) {
      case 'Startseite':
        return LandingPage();
      case 'Bestellungen':
        return Orders();
      case 'Account':
        return AccountPage();
      case 'Einstellungen':
        return Settings();
      case 'Impressum':
        return InfoPage();
      default:
        return const Text("Unknown Page");
    }
  }
}
