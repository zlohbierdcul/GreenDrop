import 'dart:convert';

class Shop {
  final String id;
  final String name;
  final String description;
  final String street;
  final String streetNumber;
  final String zipCode;
  final String city;
  final double rating;
  final double minOrder;
  final double deliveryCost;

  Shop(
      {required this.description,
      required this.street,
      required this.streetNumber,
      required this.zipCode,
      required this.city,
      required this.minOrder,
      required this.deliveryCost,
      required this.name,
      required this.rating,
      required this.id});

  // Factory-Konstruktor zum Erstellen eines Shop-Objekts aus einem JSON-Eintrag
  factory Shop.fromJson(String id, Map<String, dynamic> json) {
    return Shop(
      id: id,
      name: json['name'],
      description: json['description'],
      street: json['street'],
      streetNumber: json['streetNumber'],
      zipCode: json['zipCode'],
      city: json['city'],
      rating: (json['rating'] as num).toDouble(),
      minOrder: (json['minOrder'] as num).toDouble(),
      deliveryCost: (json['deliveryCost'] as num).toDouble(),
    );
  }

  // Statische Methode zum Parsen von Mockdaten und Erstellen einer Liste von Shops
  static List<Shop> parseShops(String jsonData) {
    final Map<String, dynamic> data = json.decode(jsonData);
    return data.entries
        .map((entry) => Shop.fromJson(entry.key, entry.value))
        .toList();
  }

  @override
  String toString() {
    return 'Shop(id: $id, name: $name, city: $city, rating: $rating, minOrder: $minOrder, deliveryCost: $deliveryCost)';
  }
}
