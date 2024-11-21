import 'package:flutter/material.dart';

import '../../account/presentation/account.dart';
import '../../orders/presentation/orders.dart';
import '../../settings/presentation/info_page.dart';
import '../../shops/presentation/pages/home.dart';

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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 950),
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
                ),
              ],
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: CircleAvatar(
                  child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Image.asset("assets/images/logo.png"),
              )),
            )
          ],
        ),
        drawer: isLargeScreen ? null : _drawer(),
        body: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: Container(
                width: double.infinity,
                constraints: const BoxConstraints(maxWidth: 1000),
                child: ScrollConfiguration(
                    behavior: ScrollConfiguration.of(context)
                        .copyWith(scrollbars: false),
                    child: activeScreen()),
              ),
            ),
          ],
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

  TextStyle getNavItemStyle(String item) {
    if (item == activePage) {
      return TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
          color: Theme.of(context).colorScheme.primary);
    } else {
      return TextStyle(
        fontSize: 18,
        color: Theme.of(context).colorScheme.secondary,
      );
    }
  }

  Widget _navBarItems() => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: _menuItems
            .map((item) => InkWell(
                  customBorder: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40)),
                  onTap: () {
                    setState(() {
                      activePage = item;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          item,
                          style: getNavItemStyle(item),
                        ),
                      ],
                    ),
                  ),
                ))
            .toList(),
      );

  final List<String> _menuItems = <String>[
    'Startseite',
    'Bestellungen',
    'Account',
    'Impressum',
  ];

  Widget activeScreen() {
    switch (activePage) {
      case 'Startseite':
        return const HomePage();
      case 'Bestellungen':
        return const Orders();
      case 'Account':
        return const Account();
      case 'Impressum':
        return const InfoPage();
      default:
        return const Text("Unknown Page");
    }
  }
}
