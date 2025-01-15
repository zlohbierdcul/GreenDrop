import 'package:greendrop/src/domain/models/product.dart';
import 'package:greendrop/src/domain/models/shop.dart';
import 'package:greendrop/src/presentation/products/provider/cart_provider.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import '../../../data/mock_data.dart';

class MockCartProvider extends Mock implements CartProvider{

  Map<Product, int> _cart = {for (Product product in DataRepository.products) product:1};
  Shop _shop = DataRepository.shop;
  
  @override
  get cart => _cart;

  double get subtotal => getTotalCosts();

  double get totalCosts => subtotal + deliveryCosts;

  double get deliveryCosts => _shop.deliveryCost;

  bool get isMinOrderMet => getTotalCosts() >= _shop.minOrder;

  int get greenDrops => totalCosts.floor() ~/ 2;

  Shop get shop => _shop;

  double get minOrder => _shop.minOrder;

  set cart (Map<Product, int> cart){
    _cart = cart;
  }
    @override
  void addProductToCart(Product product) {
    super.noSuchMethod(Invocation.method(#addProductToCart, [product])); // Simulate behavior // Ensures notifyListeners is called
  }

  @override
  void removeProductFromCart(Product product) {
    super.noSuchMethod(Invocation.method(#removeProductFromCart, [product])); // Ensures notifyListeners is called
  }

  @override
    double calculateOrderCosts(Shop shop){
    return totalCosts+shop.deliveryCost;
  }

  @override
  double getTotalCosts() {
    return _cart.isEmpty ? 0 :  _cart.entries
        .map((entry) => entry.value * entry.key.price)
        .reduce((a, b) => a + b);
  }


}
