import 'package:flutter_test/flutter_test.dart';
import 'package:greendrop/src/domain/models/cart_item.dart';
import 'package:greendrop/src/domain/models/product.dart';

void main() {
  group('CartItem Tests', () {
    test('Should update quantity correctly', () {
      final product = Product(
        name: 'Apple',
        price: 1.99,
        stock: 100,
        category: 'Fruits',
        imageUrl: 'https://example.com/apple.jpg',
        description: 'A fresh apple',
        id: '1234',
      );

      final cartItem = CartItem(product: product, quantity: 3);

      cartItem.quantity = 5;
      expect(cartItem.quantity, 5);

      cartItem.quantity = -1; // Test for negative values
      expect(cartItem.quantity, 0); // Quantity should be reset to 0
    });

    test('Should create a copy with modified quantity using copyWith', () {
      final product = Product(
        name: 'Apple',
        price: 1.99,
        stock: 100,
        category: 'Fruits',
        imageUrl: 'https://example.com/apple.jpg',
        description: 'A fresh apple',
        id: '1234',
      );

      final cartItem = CartItem(product: product, quantity: 3);

      final updatedCartItem = cartItem.copyWith(quantity: 10);

      expect(updatedCartItem.quantity, 10);
      expect(updatedCartItem.product.name, 'Apple');
      expect(cartItem.quantity, 3); // Original object remains unchanged
    });

    test('Should create an identical copy when copyWith has no arguments', () {
      final product = Product(
        name: 'Apple',
        price: 1.99,
        stock: 100,
        category: 'Fruits',
        imageUrl: 'https://example.com/apple.jpg',
        description: 'A fresh apple',
        id: '1234'
      );

      final cartItem = CartItem(product: product, quantity: 3);

      final identicalCartItem = cartItem.copyWith();

      expect(identicalCartItem.quantity, cartItem.quantity);
      expect(identicalCartItem.product, cartItem.product);
    });
  });
}
