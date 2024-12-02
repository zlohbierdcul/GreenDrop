import 'package:flutter/material.dart';
import 'package:greendrop/src/features/shops/presentation/filter.search/filter_dialog.dart';
import 'package:greendrop/src/features/shops/presentation/filter.search/search_bar.dart';
import 'package:greendrop/src/features/shops/presentation/shops/shop_list.dart';
import '../../../hamburger_menu/presentation/hamburger_menu.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
        ]
      ),
      drawer: const AppDrawer(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  const Expanded(child: ShopSearchBar()),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: () => FilterDialog.dialogBuilder(context),
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 12.0),
                      child: Icon(Icons.tune_rounded),
                    ),
                  )
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 16.0),
              child: Text(
                "Coffeeshops in der Nähe",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const ShopList(),
          ],
        ),
      ),
    );
  }
}