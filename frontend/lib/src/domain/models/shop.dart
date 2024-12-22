import 'dart:convert';
import 'package:greendrop/src/domain/models/address.dart';

class Shop {
  final String id;
  final String name;
  final String description;
  final Address address;
  final double rating;
  final int reviewCount;
  final double minOrder;
  final double deliveryCost;
  double latitude;
  double longitude;
  final double radius;

  Shop(
      {required this.id,
      required this.name,
      required this.description,
      required this.address,
      required this.rating,
      required this.reviewCount,
      required this.minOrder,
      required this.deliveryCost,
      required this.latitude,
      required this.longitude,
      required this.radius});
    
  // Factory constructor to create a Shop object from a JSON entry
  static Shop fromJson(Map<String, dynamic> json) {
    
    final address = Address.fromJson(json);
    final List<dynamic> reviews = json['reviews'] ?? [];

    final int reviewCount = reviews.length;
    double rating = 0.0;

    // calculate rating from reviews
    if (reviewCount > 0) {
      rating =
          reviews.map((r) => r["rating"]).reduce((a, b) => a + b) / reviewCount;
    }

    return Shop(
      id: json['documentId'].toString(),
      name: json['name'],
      description: json['description'],
      address: address,
      rating: rating,
      reviewCount: reviewCount,
      minOrder: (json['minimum_order'] as num).toDouble(),
      deliveryCost: (json['delivery_costs'] as num).toDouble(),
      radius: (json['max_delivery_radius'] as num).toDouble(),
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }

  Map<String, dynamic> toJson() {
  return {
    'id': id,
    'name': name,
    'description': description,
    'address': address.id,
    'minimum_order': minOrder,
    'delivery_costs': deliveryCost,
    'max_delivery_radius': radius,
    'latitude': latitude,
    'longitude': longitude,
  };
}


  // Static method to parse mock data and create a list of Shops
  static List<Future<Shop>> parseShops(String jsonData) {
    final Map<String, dynamic> data = json.decode(jsonData);
    return data.entries
        .map((entry) async => await Shop.fromJson(entry.value))
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
