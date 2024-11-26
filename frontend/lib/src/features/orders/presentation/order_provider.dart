import 'package:flutter/material.dart';

// Bestellung Modell
class Order {
  final String shopName;
  final String date;
  final int itemCount;
  final double totalAmount;

  Order({
    required this.shopName,
    required this.date,
    required this.itemCount,
    required this.totalAmount,
  });
}

class OrderProvider with ChangeNotifier {
  //TODO: mit provider verbinden
  final List<Order> _orders = []; 

  List<Order> get orders => _orders;


  void addOrder(Order order) {
    _orders.add(order);
    notifyListeners(); 
  }

  void setOrders(List<Order> newOrders) {
    _orders.clear();
    _orders.addAll(newOrders);
    notifyListeners(); 
  }
}
