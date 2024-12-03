import 'dart:convert';

class Product {
  final String name;
  final double price;
  final String origin;
  final String type;

  Product({
    required this.name,
    required this.price,
    required this.origin,
    required this.type,
  });

  // Factory constructor to create a Product object from a JSON entry
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      name: json['name'],
      price: (json['price'] as num).toDouble(),
      origin: json['origin'],
      type: json['type'],
    );
  }

  // Static method to parse mock data and create a list of Products
  static List<Product> parseProducts(String jsonData) {
    final List<dynamic> data = json.decode(jsonData);
    return data.map((item) => Product.fromJson(item)).toList();
  }

  @override
  String toString() {
    return 'Product('
        'name: $name, '
        'price: $price, '
        'origin: $origin, '
        'type: $type'
        ')';
  }

  // Convert a Product object to a Map for serialization
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'price': price,
      'origin': origin,
      'type': type,
    };
  }
}
