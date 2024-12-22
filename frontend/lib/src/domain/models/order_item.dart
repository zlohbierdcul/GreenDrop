import 'package:greendrop/src/domain/models/product.dart';
import 'package:greendrop/src/domain/models/cart_item.dart';

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

  factory OrderItem.fromJson(Map<String, dynamic> json, {String? orderID}) {
    final productJson = json['product']['product'];
    return OrderItem(
      orderID: orderID,
      totalAmount: (json['price'] as num).toInt() * (json['quantity'] as int),
      name: productJson['name'] as String,
      price: (productJson['price'] as num).toDouble(),
      stock: (productJson['stock'] as num).toInt(),
      category: productJson['category'] as String,
      imageUrl:
          productJson['documentId'] as String, // Assuming this as imageUrl
      description: productJson['description'] as String,
    );
  }

  OrderItem.fromCartItem(CartItem cartItem, orderID)
      : this.fromProduct(cartItem.product, cartItem.quantity, orderID);

  OrderItem.fromProduct(Product product, this.totalAmount, this.orderID)
      : super(
            name: product.name,
            price: product.price,
            stock: product.stock,
            category: product.category,
            imageUrl: product.imageUrl,
            description: product.description);

  OrderItem copyWith({int? count}) {
    return OrderItem(
      totalAmount: count ?? totalAmount,
      name: name,
      price: price,
      stock: stock,
      category: category,
      imageUrl: imageUrl,
      description: description,
    );
  }
}
