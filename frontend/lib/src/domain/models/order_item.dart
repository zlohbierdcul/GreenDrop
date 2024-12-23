import 'package:greendrop/src/domain/models/product.dart';

class OrderItem extends Product {
  final String? orderID;
  final int totalAmount;
  final int quantity;

  OrderItem(
      {this.orderID,
      required this.totalAmount,
      required this.quantity,
      required super.name,
      required super.price,
      required super.stock,
      required super.category,
      required super.imageUrl,
      required super.description});

  factory OrderItem.fromJson(Map<String, dynamic> json, {String? orderID}) {
    final productJson = json['product'];
    return OrderItem(
      orderID: orderID,
      totalAmount: (productJson['price'] as num).toInt() * (json['quantity'] as int),
      name: productJson["product"]['name'] as String,
      price: (productJson['price'] as num).toDouble(),
      stock: (productJson['stock'] as num).toInt(),
      category: productJson["product"]['category'] as String,
      imageUrl:
          productJson['documentId'] as String, // Assuming this as imageUrl
      description: productJson["product"]['description'] as String,
      quantity: json["quantity"] as int
    );
  }

  OrderItem copyWith({int? count}) {
    return OrderItem(
      totalAmount: count ?? totalAmount,
      name: name,
      price: price,
      stock: stock,
      quantity: quantity,
      category: category,
      imageUrl: imageUrl,
      description: description,
    );
  }
}
