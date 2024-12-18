import 'package:greendrop/src/domain/models/product.dart';

class OrderItem extends Product {
  final String? orderID;
  final int totalAmount;

  OrderItem(
      {this.orderID,
      required this.totalAmount,
      required super.name,
      required super.price,
      required super.stock,
      required super.category,
      required super.imageUrl,
      required super.description});

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      orderID: json['orderID'] as String?,
      totalAmount: json['totalAmount'] as int,
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(), // Konvertiere zu double
      stock: json['stock'] as int,
      category: json['category'] as String,
      imageUrl: json['imageUrl'] as String,
      description: json['description'] as String,
    );
  }
}
