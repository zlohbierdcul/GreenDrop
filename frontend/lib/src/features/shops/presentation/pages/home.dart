import 'package:flutter/material.dart';
import 'package:greendrop/src/features/shops/presentation/filter.search/filter_dialog.dart';
import 'package:greendrop/src/features/shops/presentation/filter.search/search_bar.dart';
import 'package:greendrop/src/features/shops/presentation/shops/shop_list.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
    );
  }
}