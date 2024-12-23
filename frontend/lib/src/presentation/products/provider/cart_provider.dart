import 'package:flutter/material.dart';
import 'package:greendrop/src/domain/models/cart_item.dart';
import 'package:greendrop/src/domain/models/order_item.dart';
import 'package:greendrop/src/domain/models/product.dart';
import 'package:greendrop/src/domain/models/shop.dart';
import 'package:greendrop/src/presentation/cart/provider/ordertype_toggle_provider.dart';

class CartProvider extends ChangeNotifier {
  final Map<Product, int> _cart = {};
  final List<OrderItem> _orderItems = [];
  Map<Product, int> get cart => _cart;
  late Shop _shop;
  late OrderTypeToggleProvider _ordertype;

  set orderTypeToggle (OrderTypeToggleProvider orderTypeToggle){
    _ordertype = orderTypeToggle;
  }
  OrderTypeToggleProvider get orderTypeToggle => _ordertype;

  double get subtotal => getTotalCosts();

  double get totalCosts => subtotal + deliveryCosts;

  double get deliveryCosts => _shop.deliveryCost;

  bool get isMinOrderMet => getTotalCosts() >= _shop.minOrder;

  int get greenDrops => totalCosts.floor() ~/ 2;

  Shop get shop => _shop;

  double get minOrder => _shop.minOrder;

  set shop(Shop shop){
    _shop = shop;
  }

  List<OrderItem> get orderItems {

    for (MapEntry<Product, int> entry in _cart.entries) {
      Product product = entry.key;
      int count = entry.value;
      _orderItems.add(OrderItem(
          totalAmount: count,
          name: product.name,
          quantity: getProductCountByProduct(product),
          price: product.price,
          stock: product.stock,
          category: product.category,
          imageUrl: product.imageUrl,
          description: product.description));
    }

    return _orderItems;
  }

  void addProductToCart(Product product) {
    _cart.update(product, (amount) => amount + 1, ifAbsent: () => 1);
    notifyListeners();
  }

  int getProductCount() {
    return _cart.isEmpty? 0 :  _cart.values.reduce((a, b) => a + b);
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

  double calculateOrderCosts(Shop shop){
    return totalCosts+shop.deliveryCost;
  }
  double getTotalCosts() {
    return _cart.isEmpty ? 0 :  _cart.entries
        .map((entry) => entry.value * entry.key.price)
        .reduce((a, b) => a + b);
  }

  List<CartItem> toCartItemList (){
   return _cart.entries.map((entry) => CartItem(product: entry.key, quantity: entry.value)).toList();
  }

  void resetCart() {
    _cart.clear();
    notifyListeners();
  }
}
