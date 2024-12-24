import 'package:flutter_test/flutter_test.dart';
import 'package:greendrop/src/domain/models/order_item.dart';

void main() {
  group('OrderItem Tests', () {
    test('Should create OrderItem from JSON', () {
      final json = {
        'quantity': 2,
        'product': {
          'price': 800.0,
          'stock': 10,
          'documentId': 'https://example.com/phone.jpg',
          'product': {
            'name': 'Smartphone',
            'category': 'Electronics',
            'description': 'A high-end smartphone',
          }
        },
      };

      final orderItem = OrderItem.fromJson(json, orderID: '54321');

      expect(orderItem.orderID, '54321');
      expect(orderItem.quantity, 2);
      expect(orderItem.totalAmount, 800 * 2); // = 1600
      expect(orderItem.name, 'Smartphone');
      expect(orderItem.price, 800.0);
      expect(orderItem.stock, 10);
      expect(orderItem.category, 'Electronics');
      expect(orderItem.imageUrl, 'https://example.com/phone.jpg');
      expect(orderItem.description, 'A high-end smartphone');
    });

    test('Should copy OrderItem with updated totalAmount', () {
      final orderItem = OrderItem(
        orderID: '11111',
        totalAmount: 2,
        quantity: 1,
        name: 'Smartwatch',
        price: 199.99,
        stock: 25,
        category: 'Wearables',
        imageUrl: 'https://example.com/smartwatch.jpg',
        description: 'A smartwatch with multiple features',
      );

      final updatedOrderItem = orderItem.copyWith(count: 5);

      // Achtung: copyWith setzt kein orderID-Feld,
      // deshalb bleibt es null.
      expect(updatedOrderItem.orderID, null);
      expect(updatedOrderItem.totalAmount, 5);
      expect(updatedOrderItem.quantity, 1); // wurde nicht verändert
      expect(updatedOrderItem.name, 'Smartwatch');
      expect(updatedOrderItem.price, 199.99);
      expect(updatedOrderItem.stock, 25);
      expect(updatedOrderItem.category, 'Wearables');
      expect(updatedOrderItem.imageUrl, 'https://example.com/smartwatch.jpg');
      expect(updatedOrderItem.description, 'A smartwatch with multiple features');
    });
  });
}
