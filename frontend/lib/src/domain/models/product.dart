import 'dart:convert';

class Product {
  final String id;
  final String name;
  final double price;
  final int stock;
  final String category;
  final String imageUrl;
  final String description;

  Product(
      {required this.name,
      required this.price,
      required this.stock,
      required this.category,
      required this.imageUrl,
      required this.description,
      required this.id});

  // Factory constructor to create a Product object from a JSON entry
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        id: json['id'],
        name: json['name'],
        price: (json['price'] as num).toDouble(),
        stock: json['stock'],
        category: json['category'],
        imageUrl: json['image_url'],
        description: json['description']);
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
        'stock: $stock, '
        'type: $category'
        ')';
  }

  // Convert a Product object to a Map for serialization
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'price': price,
      'stock': stock,
      'type': category,
      'imageUrl': imageUrl,
      'description': description
    };
  }
}
