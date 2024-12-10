import 'dart:convert';

class CartItem {
  final String id;
  final String name;
  final double price;
  final int quantity;

  CartItem({
    required this.id,
    required this.name,
    required this.price,
    required this.quantity,
  });

  CartItem copyWith({int? quantity}) {
    return CartItem(
      id: id,
      name: name,
      price: price,
      quantity: quantity ?? this.quantity,
    );
  }

  factory CartItem.fromJson(Map<String, dynamic> value){
    return CartItem(
      id: value["id"],
      name: value["name"],
      price: (value["price"] as num).toDouble(),
      quantity: value["quantity"] as int
    );
  }

  static List<CartItem> parseCartItems(String jsonData){
    final List<dynamic> data = json.decode(jsonData);
    return data.map((item) => CartItem.fromJson(item))
        .toList();
  }
 
}
