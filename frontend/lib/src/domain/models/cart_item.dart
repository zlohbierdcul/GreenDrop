import './product.dart';

class CartItem {
  final Product product;
  int _quantity;

  CartItem({
    required this.product,
    required int quantity,
  }) : _quantity = quantity;

  CartItem copyWith({int? quantity}) {
    return CartItem(
      product: product,
      quantity: quantity ?? _quantity,
    );
  }
  
  int get quantity => _quantity;

  set quantity(int value){
    if(value >= 0){
        _quantity = value;
    }else {
      _quantity = 0;
    }
  }
 
}
