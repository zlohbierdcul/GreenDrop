import 'dart:convert';
import 'dart:math';
import 'package:geocode/geocode.dart' hide Address;
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
  final double latitude;
  final double longitude;

  Shop({
    required this.id,
    required this.name,
    required this.description,
    required this.address,
    required this.rating,
    required this.reviewCount,
    required this.minOrder,
    required this.deliveryCost,
    required this.latitude,
    required this.longitude,
  });

  // Factory constructor to create a Shop object from a JSON entry
  static Future<Shop> fromJson(Map<String, dynamic> json) async {
    final address = Address.fromJson(json);
    Coordinates coordinates = await getCoordinatesOfAddress(address.toString());
    final List<dynamic> reviews = json['reviews'];

    final int reviewCount = reviews.length;
    double rating = 0.0;

    // calculate rating from reviews
    if (reviewCount > 0) {
      rating = reviews.map((r) => r["rating"]).reduce((a, b) => a + b) / reviewCount;
    }

    return Shop(
      id: json['documentId'].toString(),
      name: json['name'],
      description: json['description'],
      address: address,
      rating: rating, // TODO: get rating from reviews
      reviewCount: reviewCount,
      minOrder: (json['minimum_order'] as num).toDouble(),
      deliveryCost: (json['delivery_costs'] as num).toDouble(),
      latitude: coordinates.latitude ?? 0,
      longitude: coordinates.longitude ?? 0,
    );
  }

  // Static method to parse mock data and create a list of Shops
  static List<Future<Shop>> parseShops(String jsonData) {
    final Map<String, dynamic> data = json.decode(jsonData);
    return data.entries
        .map((entry) async => await Shop.fromJson(entry.value))
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

  static Future<Coordinates> getCoordinatesOfAddress(String address) async {
    GeoCode geoCode = GeoCode();
    try {
      Coordinates coordinates = await geoCode.forwardGeocoding(address: address);
      return coordinates;
    } catch (e) {
      print('Longitude - Geocoding-Fehler für $address: $e');
    }
    return Coordinates(latitude: 0, longitude: 0);
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
