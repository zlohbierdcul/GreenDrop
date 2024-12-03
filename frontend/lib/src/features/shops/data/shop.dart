import 'dart:convert';

import 'package:greendrop/src/features/order/domain/address.dart';
import 'package:greendrop/src/features/products/domain/product.dart';

class Shop {
  final String id;
  final String name;
  final String description;
  final Address address;
  final double rating;
  final double minOrder;
  final double deliveryCost;
  final List<Product> products;

  Shop({
    required this.id,
    required this.name,
    required this.description,
    required this.address,
    required this.rating,
    required this.minOrder,
    required this.deliveryCost,
    required this.products,
  });

  // Factory constructor to create a Shop object from a JSON entry
  factory Shop.fromJson(String id, Map<String, dynamic> json) {
    return Shop(
      id: id,
      name: json['name'],
      description: json['description'],
      address: Address.fromJson(json),
      rating: (json['rating'] as num).toDouble(),
      minOrder: (json['minOrder'] as num).toDouble(),
      deliveryCost: (json['deliveryCost'] as num).toDouble(),
      products: (json['products'] as List<dynamic>)
          .map((productJson) => Product.fromJson(productJson))
          .toList(),
    );
  }

  // Static method to parse mock data and create a list of Shops
  static List<Shop> parseShops(String jsonData) {
    final Map<String, dynamic> data = json.decode(jsonData);
    return data.entries
        .map((entry) => Shop.fromJson(entry.key, entry.value))
        .toList();
  }

  @override
  String toString() {
    return 'Shop('
        'id: $id, '
        'name: $name, '
        'description: $description, '
        'address: $address, '
        'rating: $rating, '
        'minOrder: $minOrder, '
        'deliveryCost: $deliveryCost'
        ')';
  }
}
