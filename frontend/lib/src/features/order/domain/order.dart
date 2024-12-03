import 'dart:convert';

import 'package:greendrop/src/features/order/domain/address.dart';
import 'package:greendrop/src/features/order/domain/user.dart';
import 'package:greendrop/src/features/shops/data/shop.dart';

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
  factory Order.fromJson(String id, Map<String, dynamic> json) {
    return Order(
      id: id,
      status: json['status'],
      user: User.fromJson(json['user']['id'], json['user']),
      // Adjusted for nested user parsing
      shop: Shop.fromJson(json['shop']['id'], json['shop']),
      // Adjusted for nested shop parsing
      address: Address.fromJson(json),
      paymentMethod: json['paymentMethod'],
    );
  }

  // Static method to parse mock data and create a list of Orders
  static List<Order> parseOrders(String jsonData) {
    final Map<String, dynamic> data = json.decode(jsonData);
    return data.entries
        .map((entry) => Order.fromJson(entry.key, entry.value))
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
