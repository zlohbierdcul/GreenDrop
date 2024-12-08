import 'dart:convert';

import 'package:greendrop/src/domain/models/address.dart';
import 'package:greendrop/src/domain/models/order_item.dart';
import 'package:greendrop/src/domain/models/shop.dart';
import 'package:greendrop/src/domain/models/user.dart';

class Order {
  final String? id;
  final String status;
  final User user;
  final Shop shop;
  final Address address;
  final String paymentMethod;
  final List<OrderItem>? orderItems;

  Order({
    this.id,
    required this.status,
    required this.user,
    required this.shop,
    required this.address,
    required this.paymentMethod,
    this.orderItems
  });

  // Factory constructor to create an Order object from a JSON entry
  static Future<Order> fromJson(String id, Map<String, dynamic> json) async {
    return Order(
      id: id,
      status: json['status'],
      user: json['user']['id'],
      shop: json['shop']['id'],
      address: json['address']['id'],
      paymentMethod: json['paymentMethod'],
    );
  }

  Map<String, dynamic> toJson() {
    final totalPrice = orderItems?.map((o) => o.totalAmount).toList().reduce((a, b) => a + b);

  return {
    'id': id,
    'state': status,
    'user': user.id,
    'shop': shop.id,
    'user_address': address.id,
    'payment_method': paymentMethod,
    'total_price': totalPrice,
    'items': orderItems?.map((item) => item.toJson()).toList(),
  };
}

  // Static method to parse mock data and create a list of Orders
  static List<Future<Order>> parseOrders(String jsonData) {
    final Map<String, dynamic> data = json.decode(jsonData);
    return data.entries
        .map((entry) async => await Order.fromJson(entry.key, entry.value))
        .toList();
  }

  @override
  String toString() {
    return 'Order('
        'id: $id, '
        'status: $status, '
        'user: $user, '
        'shop: $shop, '
        'address: $address, '
        'paymentMethod: $paymentMethod'
        ')';
  }
}
