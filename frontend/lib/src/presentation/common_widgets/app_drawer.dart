import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  static PreferredSizeWidget buildGreendropsAppBar(BuildContext context, {bool automaticallyImplayLeading = true}) {
    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('GreenDrop'),
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: OutlinedButton(
              onPressed: () => _showPopup(context),
              child: Center(child: Row(
                children: [
                  Image.asset(
                    'assets/images/logo.png',
                    width: 22,
                    height: 22,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    '2233',
                    style: TextStyle(fontSize: 16, color: Theme.of(context).colorScheme.onSecondaryContainer),
                  ),
                ],
              )),
            ),
          ),
        ],
      ),
      automaticallyImplyLeading: automaticallyImplayLeading,
    );
  }

  static void _showPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('GreenDrops Information'),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Die Zahl oben zeigt deinen aktuellen GreenDrop-Punktestand!',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 8,),
              Text("GreenDrops können für Rabatte auf deinen Einkauf eingelöst werden.", style: TextStyle(fontSize: 16)),
              SizedBox(height: 8,),
              Text("Für alle 2 Euro die du ausgibst erhältst du einen GreenDrop von uns!", style: TextStyle(fontSize: 16)),

            ]
          ),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(); // Schließt das Popup
              },
            ),
          ],
        );
      },
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
                "assets/images/logo_old.png",
                width: 60,
                height: 60,
              ),
              const SizedBox(width: 12),
              const Text(
                "GreenDrop",
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
              Navigator.pushNamed(context, '/home');
            },
          ),
          ListTile(
            leading: const Icon(Icons.shopping_bag),
            title: const Text('Bestellungen'),
            onTap: () {
              Navigator.pushNamed(context, '/order_history');
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
