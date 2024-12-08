import 'package:flutter/material.dart';
import 'package:greendrop/src/presentation/shops/provider/shop_data_provider.dart';
import 'package:provider/provider.dart';

class ShopSearchBar extends StatefulWidget {
  const ShopSearchBar({super.key});

  @override
  SearchBarState createState() => SearchBarState();
}

class SearchBarState extends State<ShopSearchBar> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<ShopDataProvider>(
      builder: (context, shopDataProvider, child) => TextField(
          controller: _searchController,
          onChanged: (value) {
            shopDataProvider.filterDataBySearchTerm(value);
          },
          autofocus: false,
          decoration: const InputDecoration(
              filled: true,
              hintText: "Suchen",
              prefixIcon: Icon(Icons.search),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.green),
                  borderRadius: BorderRadius.all(Radius.circular(20))))),
    );
  }
}
