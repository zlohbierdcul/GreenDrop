import 'package:flutter_test/flutter_test.dart';
import 'package:greendrop/src/domain/models/product.dart';
import 'package:greendrop/src/domain/models/cart_item.dart';
import 'package:greendrop/src/domain/models/order_item.dart';

void main() {
  group('OrderItem Tests', () {
    test('Should create OrderItem from Product', () {
      final product = Product(
        name: 'Phone',
        price: 699.99,
        stock: 20,
        category: 'Electronics',
        imageUrl: 'https://example.com/phone.jpg',
        description: 'A flagship smartphone',
      );

      final orderItem = OrderItem.fromProduct(
        product,
        5, // totalAmount
        '54321', // orderID
      );

      expect(orderItem.orderID, '54321');
      expect(orderItem.totalAmount, 5);
      expect(orderItem.name, 'Phone');
      expect(orderItem.price, 699.99);
      expect(orderItem.stock, 20);
      expect(orderItem.category, 'Electronics');
      expect(orderItem.imageUrl, 'https://example.com/phone.jpg');
      expect(orderItem.description, 'A flagship smartphone');
    });

    test('Should create OrderItem from CartItem', () {
      final product = Product(
        name: 'Tablet',
        price: 499.99,
        stock: 15,
        category: 'Electronics',
        imageUrl: 'https://example.com/tablet.jpg',
        description: 'A high-resolution tablet',
      );

      final cartItem = CartItem(
        product: product,
        quantity: 2,
      );

      final orderItem = OrderItem.fromCartItem(cartItem, '67890');

      expect(orderItem.orderID, '67890');
      expect(orderItem.totalAmount, 2);
      expect(orderItem.name, 'Tablet');
      expect(orderItem.price, 499.99);
      expect(orderItem.stock, 15);
      expect(orderItem.category, 'Electronics');
      expect(orderItem.imageUrl, 'https://example.com/tablet.jpg');
      expect(orderItem.description, 'A high-resolution tablet');
    });

    test('Should copy OrderItem with updated totalAmount', () {
      final orderItem = OrderItem(
        orderID: '11111',
        totalAmount: 2,
        name: 'Smartwatch',
        price: 199.99,
        stock: 25,
        category: 'Wearables',
        imageUrl: 'https://example.com/smartwatch.jpg',
        description: 'A smartwatch with multiple features',
      );

      final updatedOrderItem = orderItem.copyWith(count: 5);

      expect(updatedOrderItem.orderID, null); // CopyWith does not update orderID
      expect(updatedOrderItem.totalAmount, 5);
      expect(updatedOrderItem.name, 'Smartwatch');
      expect(updatedOrderItem.price, 199.99);
      expect(updatedOrderItem.stock, 25);
      expect(updatedOrderItem.category, 'Wearables');
      expect(updatedOrderItem.imageUrl, 'https://example.com/smartwatch.jpg');
      expect(updatedOrderItem.description, 'A smartwatch with multiple features');
    });
  });
}
