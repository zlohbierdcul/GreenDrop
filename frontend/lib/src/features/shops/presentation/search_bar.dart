import 'package:flutter/material.dart';

class ShopSearchBar extends StatefulWidget {
  const ShopSearchBar({super.key});

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<ShopSearchBar> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: _searchController,
        onChanged: (value) {
          // Perform search logic based on the input value
          // You can call a function or update the search results here
          print('Search query: $value');
        },
        autofocus: false,
        decoration: const InputDecoration(
            filled: true,
            hintText: "Suchen",
            prefixIcon: Icon(Icons.search),
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(20))),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.green),
                borderRadius: BorderRadius.all(Radius.circular(20)))));
  }
}
