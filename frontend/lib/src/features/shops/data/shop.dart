import 'dart:convert';
import 'dart:math';

import 'package:geocoding/geocoding.dart';
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
  final double latitude;
  final double longitude;
  final List<Product> products;

  Shop({
    required this.id,
    required this.name,
    required this.description,
    required this.address,
    required this.rating,
    required this.minOrder,
    required this.deliveryCost,
    required this.latitude,
    required this.longitude,
    required this.products,
  });

  // Factory constructor to create a Shop object from a JSON entry
  static Future<Shop> fromJson(String id, Map<String, dynamic> json) async {
    final address = Address.fromJson(json);
    final latitude = await getLatitude(address.toString());
    final longitude = await getLongitude(address.toString());

    return Shop(
      id: id,
      name: json['name'],
      description: json['description'],
      address: address,
      rating: (json['rating'] as num).toDouble(),
      minOrder: (json['minOrder'] as num).toDouble(),
      deliveryCost: (json['deliveryCost'] as num).toDouble(),
      latitude: latitude,
      longitude: longitude,
      products: (json['products'] as List<dynamic>)
          .map((productJson) => Product.fromJson(productJson))
          .toList(),
    );
  }

  // Static method to parse mock data and create a list of Shops
  static List<Future<Shop>> parseShops(String jsonData) {
    final Map<String, dynamic> data = json.decode(jsonData);
    return data.entries
        .map((entry) async => await Shop.fromJson(entry.key, entry.value))
        .toList();
  }

  double calculateDistance(double lat2, double lon2) {
    const double radius = 6371;
    double dLat = _degreesToRadians(lat2 - latitude);
    double dLon = _degreesToRadians(lon2 - longitude);

    double a = sin(dLat / 2) * sin(dLat / 2) +
        cos(_degreesToRadians(latitude)) *
            cos(_degreesToRadians(lat2)) *
            sin(dLon / 2) *
            sin(dLon / 2);

    double c = 2 * atan2(sqrt(a), sqrt(1 - a));

    return radius * c;
  }

  static double _degreesToRadians(double degree) {
    return degree * pi / 180;
  }

  static Future<double> getLongitude(String address) async {
    try {
      final locations = await locationFromAddress(address);
      if (locations.isNotEmpty) {
        final location = locations.first;
        return location.longitude;
      }
    } catch (e) {
      print('Geocoding-Fehler für $address: $e');
    }
    return 0;
  }

  static Future<double> getLatitude(String address) async {
    try {
      final locations = await locationFromAddress(address);
      if (locations.isNotEmpty) {
        final location = locations.first;
        return location.latitude;
      }
    } catch (e) {
      print('Geocoding-Fehler für $address: $e');
    }
    return 0;
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
