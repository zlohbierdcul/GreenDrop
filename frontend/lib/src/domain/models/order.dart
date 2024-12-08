import 'dart:convert';

import 'package:greendrop/src/domain/models/address.dart';
import 'package:greendrop/src/domain/models/shop.dart';
import 'package:greendrop/src/domain/models/user.dart';

class Order {
  final String id;
  final String status;
  final User user;
  final Shop shop;
  final Address address;
  final String paymentMethod;

  Order({
    required this.id,
    required this.status,
    required this.user,
    required this.shop,
    required this.address,
    required this.paymentMethod,
  });

  // Factory constructor to create an Order object from a JSON entry
  static Future<Order> fromJson(String id, Map<String, dynamic> json) async {
    return Order(
      id: id,
      status: json['status'],
      user: User.fromJson(json['user']),
      // Adjusted for nested user parsing
      shop: await Shop.fromJson(json['shop']),
      // Adjusted for nested shop parsing
      address: Address.fromJson(json),
      paymentMethod: json['paymentMethod'],
    );
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
