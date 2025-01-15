import 'package:flutter_test/flutter_test.dart';
import 'package:greendrop/src/domain/models/product.dart';

void main() {
  group('Product Tests', () {
    test('Should parse JSON into Product object correctly', () {
      final json = {
        'name': 'Banana',
        'price': 0.99,
        'stock': 100,
        'category': 'Fruits',
        'image_url': 'https://example.com/banana.jpg',
        'description': 'A ripe yellow banana',
        'id': '1234'
      };

      final product = Product.fromJson(json);

      expect(product.name, 'Banana');
      expect(product.price, 0.99);
      expect(product.stock, 100);
      expect(product.category, 'Fruits');
      expect(product.imageUrl, 'https://example.com/banana.jpg');
      expect(product.description, 'A ripe yellow banana');
      expect(product.id, '1234');
    });

    test('Should serialize Product object to JSON correctly', () {
      final product = Product(
        name: 'Orange',
        price: 1.50,
        stock: 30,
        category: 'Fruits',
        imageUrl: 'https://example.com/orange.jpg',
        description: 'A sweet and tangy orange',
        id: '1234'
      );

      final json = product.toJson();

      expect(json['name'], 'Orange');
      expect(json['price'], 1.50);
      expect(json['stock'], 30);
      expect(json['type'], 'Fruits');
      expect(json['imageUrl'], 'https://example.com/orange.jpg');
      expect(json['description'], 'A sweet and tangy orange');
    });

    test('Should parse list of Products from JSON string', () {
      const jsonData = '''
      [
        {
          "id": "1234",
          "name": "Apple",
          "price": 1.99,
          "stock": 50,
          "category": "Fruits",
          "image_url": "https://example.com/apple.jpg",
          "description": "A fresh and juicy apple"
        },
        {
          "id": "2345",
          "name": "Banana",
          "price": 0.99,
          "stock": 100,
          "category": "Fruits",
          "image_url": "https://example.com/banana.jpg",
          "description": "A ripe yellow banana"
        }
      ]
      ''';

      final products = Product.parseProducts(jsonData);

      expect(products.length, 2);

      expect(products[0].name, 'Apple');
      expect(products[0].price, 1.99);
      expect(products[0].stock, 50);

      expect(products[1].name, 'Banana');
      expect(products[1].price, 0.99);
      expect(products[1].stock, 100);
    });

    test('Should return correct string representation of Product', () {
      final product = Product(
        name: 'Mango',
        price: 2.99,
        stock: 20,
        category: 'Fruits',
        imageUrl: 'https://example.com/mango.jpg',
        description: 'A delicious tropical mango',
        id: '1234',
      );

      expect(
        product.toString(),
        'Product(name: Mango, price: 2.99, stock: 20, type: Fruits)',
      );
    });
  });
}
