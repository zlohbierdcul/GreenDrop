import 'package:flutter/material.dart';
import 'package:greendrop/src/domain/models/order_item.dart';
import 'package:greendrop/src/domain/models/product.dart';

class CartProvider extends ChangeNotifier {
  Map<Product, int> _cart = {};

  Map<Product, int> get cart => _cart;

  List<OrderItem> get orderItems {
    List<OrderItem> orderItems = [];

    for (MapEntry<Product, int> entry in _cart.entries) {
      Product product = entry.key;
      int count = entry.value;
      orderItems.add(OrderItem(
          totalAmount: count,
          name: product.name,
          price: product.price,
          stock: product.stock,
          category: product.category,
          imageUrl: product.imageUrl,
          description: product.description));
    }

    return orderItems;
  }

  void addProductToCart(Product product) {
    _cart.update(product, (amount) => amount + 1, ifAbsent: () => 1);
    notifyListeners();
  }

  int getProductCount() {
    return _cart.values.reduce((a, b) => a + b);
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

  double getTotalCosts() {
    return _cart.entries
        .map((entry) => entry.value * entry.key.price)
        .reduce((a, b) => a + b);
  }

  void resetCart() {
    _cart = {};
    notifyListeners();
  }
}
