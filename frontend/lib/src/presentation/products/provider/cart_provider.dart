import 'package:flutter/material.dart';
import 'package:greendrop/src/domain/models/cart_item.dart';
import 'package:greendrop/src/domain/models/order_item.dart';
import 'package:greendrop/src/domain/models/product.dart';
import 'package:greendrop/src/domain/models/shop.dart';
import 'package:greendrop/src/presentation/cart/provider/ordertype_toggle_provider.dart';

class CartProvider extends ChangeNotifier {
  late Shop shop;
  late OrderTypeToggleProvider orderTypeToggle;

  final Map<Product, int> _cart = {};
  final List<OrderItem> _orderItems = [];

  Map<Product, int> get cart => _cart;

  double get subtotal => getTotalCosts();
  double get totalCosts => subtotal + deliveryCosts;
  double get deliveryCosts => shop.deliveryCost;
  bool get isMinOrderMet => getTotalCosts() >= shop.minOrder;
  int get greenDrops => totalCosts.floor() ~/ 2;
  double get minOrder => shop.minOrder;

  List<OrderItem> get orderItems {
    for (MapEntry<Product, int> entry in _cart.entries) {
      Product product = entry.key;
      int count = entry.value;
      double totalAmount = count * product.price;
      _orderItems.add(OrderItem.fromProduct(product, totalAmount, count, null));
    }

    return _orderItems;
  }

  void addProductToCart(Product product) {
    _cart.update(product, (amount) => amount + 1, ifAbsent: () => 1);
    notifyListeners();
  }

  int getProductCount() {
    return _cart.isEmpty ? 0 : _cart.values.reduce((a, b) => a + b);
  }

  int getProductCountByProduct(Product product) {
    return _cart[product] ?? 0;
  }

  void removeProductFromCart(Product product) {
    if (_cart.containsKey(product)) {
      if (_cart[product] == 1) {
        _cart.remove(product);
      } else {
        _cart.update(product, (v) => v - 1);
      }
    }
    notifyListeners();
  }

  double calculateOrderCosts(Shop shop) {
    return totalCosts + shop.deliveryCost;
  }

  double getTotalCosts() {
    return _cart.isEmpty
        ? 0
        : _cart.entries
            .map((entry) => entry.value * entry.key.price)
            .reduce((a, b) => a + b);
  }

  List<CartItem> toCartItemList() {
    return _cart.entries
        .map((entry) => CartItem(product: entry.key, quantity: entry.value))
        .toList();
  }

  void resetCart() {
    _cart.clear();
    notifyListeners();
  }
}
