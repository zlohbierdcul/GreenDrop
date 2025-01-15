import 'dart:convert';

import 'package:greendrop/src/domain/models/address.dart';
import 'package:greendrop/src/domain/models/order_item.dart';
import 'package:greendrop/src/domain/models/shop.dart';
import 'package:greendrop/src/domain/models/user.dart';

class Order {
  final String? id;
  final String status;
  final User? user;
  final Shop shop;
  final DateTime? date;
  final Address address;
  final String paymentMethod;
  final List<OrderItem>? orderItems;

  Order(
      {this.id,
      required this.status,
      this.user,
      required this.shop,
      this.date,
      required this.address,
      required this.paymentMethod,
      this.orderItems});

  Order copyWith(
      {String? id,
      String? status,
      User? user,
      Shop? shop,
      Address? address,
      String? paymentMethod,
      List<OrderItem>? orderItems}) {
    return Order(
        id: id ?? this.id,
        status: status ?? this.status,
        user: user ?? this.user,
        shop: shop ?? this.shop,
        address: address ?? this.address,
        paymentMethod: paymentMethod ?? this.paymentMethod,
        orderItems: orderItems ?? this.orderItems);
  }

  // Factory constructor to create an Order object from a JSON entry
  static Order fromJson(Map<String, dynamic> json) {
    return Order(
        id: json['documentId'].toString(),
        status: json['state'],
        date: DateTime.parse(json["createdAt"]),
        shop: Shop.fromJson(json['shop']),
        address: Address.fromJson(json['user_address']),
        paymentMethod: json['payment_method'].toString(),
        orderItems: (json['items'] as List<dynamic>)
            .map((item) => OrderItem.fromJson(item))
            .toList());
  }

  Map<String, dynamic> toJson() {
    final totalPrice =
        orderItems?.map((o) => o.totalAmount).toList().reduce((a, b) => a + b);

    return {
      'id': id,
      'state': status,
      'user': user?.id,
      'shop': shop.id,
      'user_address': address.id,
      'payment_method': paymentMethod,
      'total_price': totalPrice,
      'items': orderItems?.map((item) => item.toJson()).toList(),
    };
  }

  // Special toJson function for Strapi because strapi is weird
  Map<String, dynamic> toStrapiJson(List<String> itemIds) {
    Map<String, dynamic> orderJson = toJson();
    orderJson["users_permissions_user"] = orderJson["user"];
    orderJson.remove('user');
    orderJson.remove('id');
    orderJson['items'] = {'connect': itemIds};
    return orderJson;
  }

  // Static method to parse mock data and create a list of Orders
  static List<Future<Order>> parseOrders(String jsonData) {
    final Map<String, dynamic> data = json.decode(jsonData);
    return data.entries
        .map((entry) async => Order.fromJson(entry.value))
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
