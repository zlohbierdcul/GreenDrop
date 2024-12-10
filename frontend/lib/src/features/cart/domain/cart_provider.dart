import 'package:flutter/material.dart';
import 'cart_item.dart';
import '../data/cart_repository.dart';


class CartProvider extends ChangeNotifier {

  final CartRepository _cartRepository = CartRepository();
  List<CartItem> _items = [];
  bool _isLoading = false;

  
  CartProvider(){

    fetchCartItems();
  }



  List<CartItem> get items => List.unmodifiable(_items);

  double get subtotal =>
      _items.fold(0, (total, item) => total + (item.price * item.quantity));

  double get deliveryCost => 5.0; // Example delivery cost

  double get total => subtotal + deliveryCost;

  int get greenDrops => (total/2).toInt();
  
  bool get isLoading => _isLoading;
  

  Future<void> fetchCartItems() async{
    _isLoading = true;
    notifyListeners();

    try {

      _items = await _cartRepository.fetchCartItems();
      print("Parsed Items: ${_items.length}");

    } catch (e){
      debugPrint("Error fetching cart items: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void addItem(CartItem item) {
    _items.add(item);
    notifyListeners();
  }

  void removeItem(String id) {
    _items.removeWhere((item) => item.id == id);
    notifyListeners();
  }

  void updateQuantity(String id, int quantity) {
    final itemIndex = _items.indexWhere((item) => item.id == id);
    if (itemIndex != -1) {
      _items[itemIndex] = _items[itemIndex].copyWith(quantity: quantity);
      notifyListeners();
    }
  }

  void clearCart(){
    _items.clear();
    notifyListeners();
  }
}
