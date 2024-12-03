import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  static PreferredSizeWidget buildGreendropsAppBar() {
    return AppBar(
      title: Row(
        children: [
          const Text('Greendrops'),
          const SizedBox(width: 8),
          TextButton(
            onPressed: () {
              print('2233 Greendrops');
            },
            child: const Text(
              '#2233',
            ),
          ),
        ],
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 32.0),
          child: Image.asset(
            'assets/images/logo.png',
            width: 40,
            height: 40,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          ListTile(
            title: Row(children: [
              Image.asset(
                alignment: AlignmentDirectional.topStart,
                "assets/images/logo.png",
                width: 60,
                height: 60,
              ),
              const SizedBox(width: 12),
              const Text(
                "Greendrobs",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              )
            ]),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Startseite'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/home');
            },
          ),
          ListTile(
            leading: const Icon(Icons.shopping_bag),
            title: const Text('Bestllungen'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/order history');
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.account_box),
            title: const Text('Account'),
            onTap: () {
              Navigator.pushNamed(context, '/account');
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.question_answer),
            title: const Text('Impressum'),
            onTap: () {
              Navigator.pushNamed(context, '/impressum');
            },
          ),
        ],
      ),
    );
  }
}
