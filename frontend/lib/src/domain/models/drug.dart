import 'dart:convert';
import 'package:greendrop/src/domain/models/product.dart';

class Drug extends Product {
  final double indica;
  final double sativa;
  final double thc;
  final double cbd;
  final List<String> effects;
  final List<String> tastes;

  Drug({
    required super.name,
    required super.price,
    required super.stock,
    required super.category,
    required super.imageUrl,
    required super.description,
    required this.indica,
    required this.sativa,
    required this.thc,
    required this.cbd,
    required this.effects,
    required this.tastes,
  });

  // Factory constructor to create a Drug object from a JSON entry
  factory Drug.fromJson(Map<String, dynamic> json) {
    return Drug(
      name: json['name'],
      price: (json['price'] as num).toDouble(),
      stock: json['stock'],
      category: json['category'],
      imageUrl: json['image_url'],
      description: json['description'],
      indica: (json['indica'] as num).toDouble(),
      sativa: (json['sativa'] as num).toDouble(),
      thc: (json['thc'] as num).toDouble(),
      cbd: (json['cbd'] as num).toDouble(),
      effects: List<String>.from(json['effects']),
      tastes: List<String>.from(json['tastes']),
    );
  }

  // Static method to parse mock data and create a list of Drugs
  static List<Drug> parseDrugs(String jsonData) {
    final List<dynamic> data = json.decode(jsonData);
    return data.map((item) => Drug.fromJson(item)).toList();
  }

  @override
  String toString() {
    return 'Drug('
        'name: $name, '
        'price: $price, '
        'stock: $stock, '
        'category: $category, '
        'indica: $indica, '
        'sativa: $sativa, '
        'thc: $thc, '
        'cbd: $cbd, '
        'effects: $effects, '
        'tastes: $tastes'
        ')';
  }

  // Convert a Drug object to a Map for serialization
  @override
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'price': price,
      'stock': stock,
      'category': category,
      'imageUrl': imageUrl,
      'description': description,
      'indica': indica,
      'sativa': sativa,
      'thc': thc,
      'cbd': cbd,
      'effects': effects,
      'tastes': tastes,
    };
  }
}
