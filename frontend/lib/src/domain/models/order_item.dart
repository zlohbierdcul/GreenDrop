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
}
