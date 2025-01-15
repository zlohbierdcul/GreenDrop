import 'package:flutter_test/flutter_test.dart';
import 'package:greendrop/src/domain/models/address.dart';
import 'package:greendrop/src/domain/models/order.dart';
import 'package:greendrop/src/domain/models/order_item.dart';
import 'package:greendrop/src/domain/models/shop.dart';
import 'package:greendrop/src/domain/models/user.dart';

void main() {
  group('Order Tests', () {
    test('Should serialize Order to JSON', () {
      final shop = Shop(
        id: 'shop001',
        name: 'Electronics Store',
        description: 'Your one-stop electronics shop',
        address: Address(
          id: 'address001',
          street: 'Main Street',
          streetNumber: '123',
          zipCode: '12345',
          city: 'Sample City',
        ),
        rating: 4.5,
        reviewCount: 200,
        minOrder: 15.0,
        deliveryCost: 5.0,
        latitude: 37.7749,
        longitude: -122.4194,
        radius: 10.0,
      );

      final address = Address(
        id: 'address001',
        street: 'Main Street',
        streetNumber: '123',
        zipCode: '12345',
        city: 'Sample City',
        isPrimary: true,
      );

      final user = User(
          id: "000",
          userId: "000",
          userDetailId: "000",
          userName: "MaMu",
          firstName: "Max",
          lastName: "Mustermann",
          birthdate: "12-12-2024",
          greenDrops: 1337,
          eMail: "max.musterman@example.com",
          addresses: [
            Address(
                id: "007",
                street: "Beispielstraße",
                streetNumber: "42",
                zipCode: "68163",
                city: "Mannheim",
                isPrimary: true)
          ]);

      final order = Order(
        id: 'order001',
        status: 'Processing',
        user: user,
        shop: shop,
        address: address,
        paymentMethod: 'Credit Card',
        orderItems: [
          OrderItem(
            orderID: 'order001',
            totalAmount: 2,
            quantity: 2,
            id: '1234',
            name: 'Laptop',
            price: 1000.0,
            stock: 5,
            category: 'Electronics',
            imageUrl: 'https://example.com/laptop.jpg',
            description: 'A high-end laptop',
          ),
        ],
      );

      final json = order.toJson();

      expect(json['id'], 'order001');
      expect(json['state'], 'Processing');
      expect(json['user'], user.id);
      expect(json['shop'], shop.id);
      expect(json['user_address'], address.id);
      expect(json['payment_method'], 'Credit Card');
      expect(json['total_price'], 2); // totalAmount of orderItems
      expect(json['items']?.length, 1);
      expect(json['items']?.first['name'], 'Laptop');
    });

    test('Should deserialize Order from JSON', () async {
      final json = {
        'documentId': 'order002',
        'state': 'Completed',
        'createdAt': '2024-01-15T10:30:00Z',
        'shop': {
          'documentId': 'shop002',
          'name': 'Tech Shop',
          'description': 'Your one-stop electronics shop',
          'street': 'Main Street',
          'street_no': '123',
          'zip_code': '12345',
          'city': 'Sample City',
          'is_primary': false,
          'rating': 4.5,
          'reviewCount': 200,
          'minimum_order': 15.0,
          'delivery_costs': 5.0,
          'max_delivery_radius': 10.0,
          'latitude': 37.7749,
          'longitude': -122.4194,
        },
        'user_address': {
          'id': 'address002',
          'street': 'High Street',
          'street_no': '456',
          'zip_code': '67890',
          'city': 'Another City',
          'is_primary': true,
        },
        'payment_method': 'PayPal',
        'items': [
          {
            'quantity': 2,
            'product': {
              'documentId': 'https://example.com/phone.jpg',
              'price': 800.0,
              'stock': 10,
              'product': {
                'name': 'Smartphone',
                'category': 'Electronics',
                'description': 'A high-end smartphone',
              },
            },
          }
        ]
      };

      final order = Order.fromJson(json);

      expect(order.id, 'order002');
      expect(order.status, 'Completed');
      expect(order.date, equals(DateTime.parse("2024-01-15T10:30:00.000Z")));
      expect(order.shop.name, 'Tech Shop');
      expect(order.address.city, 'Another City');
      expect(order.paymentMethod, 'PayPal');

      final item = order.orderItems?.first;
      expect(item?.quantity, 2);
      expect(item?.name, 'Smartphone');
      expect(item?.imageUrl, 'https://example.com/phone.jpg');
    });

    test('Should parse a list of Orders from JSON string', () async {
      const jsonData = '''
        {
          "order1": {
            "documentId": "order003",
            "state": "Pending",
            "createdAt": "2024-01-15T10:30:00Z",
            "shop": {
              "documentId": "shop003",
              "name": "Gadget Store",
              "description": "Your one-stop electronics shop",
              "street": "Main Street",
              "street_no": "123",
              "zip_code": "12345",
              "city": "Sample City",
              "is_primary": false,
              "rating": 4.5,
              "reviewCount": 200,
              "minimum_order": 15.0,
              "delivery_costs": 5.0,
              "max_delivery_radius": 10.0,
              "latitude": 37.7749,
              "longitude": -122.4194
            },
            "user_address": {
              "id": "address003",
              "street": "Elm Street",
              "street_no": "789",
              "zip_code": "13579",
              "city": "Tech City",
              "is_primary": true
            },
            "payment_method": "Cash on Delivery",
            "items": [
              {
                "quantity": 2,
                "product": {
                  "documentId": "https://example.com/phone.jpg",
                  "price": 800.0,
                  "stock": 10,
                  "product": {
                    "name": "Smartphone",
                    "category": "Electronics",
                    "description": "A high-end smartphone"
                  }
                }
              }
            ]
          }
        }
      ''';

      final orders = Order.parseOrders(jsonData);

      expect(orders.length, 1);
      final order = await orders.first;
      expect(order.id, 'order003');
      expect(order.status, 'Pending');
      expect(order.date, equals(DateTime.parse("2024-01-15T10:30:00.000Z")));
      expect(order.shop.name, 'Gadget Store');
      expect(order.address.street, 'Elm Street');
      expect(order.paymentMethod, 'Cash on Delivery');

      final item = order.orderItems?.first;
      expect(item?.quantity, 2);
      expect(item?.name, 'Smartphone');
      expect(item?.imageUrl, 'https://example.com/phone.jpg');
    });

    test('Should return correct string representation with toString', () {
      final shop = Shop(
        id: 'shop001',
        name: 'Electronics Store',
        description: 'Your one-stop electronics shop',
        address: Address(
          id: 'address001',
          street: 'Main Street',
          streetNumber: '123',
          zipCode: '12345',
          city: 'Sample City',
        ),
        rating: 4.5,
        reviewCount: 200,
        minOrder: 15.0,
        deliveryCost: 5.0,
        latitude: 37.7749,
        longitude: -122.4194,
        radius: 10.0,
      );

      final address = Address(
        id: 'address001',
        street: 'Main Street',
        streetNumber: '123',
        zipCode: '12345',
        city: 'Sample City',
        isPrimary: true,
      );

      final user = User(
          id: "000",
          userId: "000",
          userDetailId: "000",
          userName: "MaMu",
          firstName: "Max",
          lastName: "Mustermann",
          birthdate: "12-12-2024",
          greenDrops: 1337,
          eMail: "max.musterman@example.com",
          addresses: [
            Address(
                id: "007",
                street: "Beispielstraße",
                streetNumber: "42",
                zipCode: "68163",
                city: "Mannheim",
                isPrimary: true)
          ]);

      final order = Order(
        id: 'order001',
        status: 'Processing',
        user: user,
        shop: shop,
        address: address,
        paymentMethod: 'Credit Card',
        orderItems: [
          OrderItem(
            orderID: 'order001',
            totalAmount: 2,
            quantity: 2,
            id: '1234',
            name: 'Laptop',
            price: 1000.0,
            stock: 5,
            category: 'Electronics',
            imageUrl: 'https://example.com/laptop.jpg',
            description: 'A high-end laptop',
          ),
        ],
      );

      final result = order.toString();

      expect(
        result,
        'Order(id: order001, status: Processing, user: ${user.toString()}, shop: ${shop.toString()}, address: ${address.toString()}, paymentMethod: Credit Card)',
      );
    });
  });
}
