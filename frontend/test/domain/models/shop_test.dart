
import 'package:flutter_test/flutter_test.dart';
import 'package:greendrop/src/domain/models/address.dart';
import 'package:greendrop/src/domain/models/shop.dart';

void main() {
  group('Shop Model Tests', () {
    test('Should parse JSON correctly into Shop object', () async {
      final json = {
        'documentId': 'shop123',
        'name': 'GreenDrop Shop',
        'description': 'A shop for eco-friendly products',
        'address': {
          'documentId': 'address123',
          'street': 'Market Street',
          'street_no': '10',
          'zip_code': '67890',
          'city': 'Berlin',
          'isPrimary': true,
        },
        'reviews': [
          {'rating': 4.0, 'review': 'Great service'},
          {'rating': 5.0, 'review': 'Excellent products'},
          {'rating': 3.5, 'review': 'Good, but a bit expensive'},
        ],
        'minimum_order': 15.0,
        'delivery_costs': 2.5,
        'max_delivery_radius': 5.0,
        'latitude': 52.5200,
        'longitude': 13.4050,
      };

      final shop = await Shop.fromJson(json);

      expect(shop.id, 'shop123');
      expect(shop.name, 'GreenDrop Shop');
      expect(shop.description, 'A shop for eco-friendly products');
      expect(shop.address.id, 'address123');
      expect(shop.rating, 4.33);
      expect(shop.reviewCount, 3);
      expect(shop.minOrder, 15.0);
      expect(shop.deliveryCost, 2.5);
      expect(shop.radius, 5.0);
      expect(shop.latitude, 52.5200);
      expect(shop.longitude, 13.4050);
    });

    test('Should convert Shop object to JSON correctly', () {
      final address = Address(
        id: 'address123',
        street: 'Market Street',
        streetNumber: '10',
        zipCode: '67890',
        city: 'Berlin',
      );

      final shop = Shop(
        id: 'shop123',
        name: 'GreenDrop Shop',
        description: 'A shop for eco-friendly products',
        address: address,
        rating: 4.33,
        reviewCount: 3,
        minOrder: 15.0,
        deliveryCost: 2.5,
        latitude: 52.5200,
        longitude: 13.4050,
        radius: 5.0,
      );

      final json = shop.toJson();

      expect(json['id'], 'shop123');
      expect(json['name'], 'GreenDrop Shop');
      expect(json['description'], 'A shop for eco-friendly products');
      expect(json['address'], 'address123');
      expect(json['minimum_order'], 15.0);
      expect(json['delivery_costs'], 2.5);
      expect(json['max_delivery_radius'], 5.0);
      expect(json['latitude'], 52.5200);
      expect(json['longitude'], 13.4050);
    });

    test('Should parse a list of Shops from JSON string', () async {
      const jsonData = '''
      {
        "shop1": {
          "documentId": "shop123",
          "name": "GreenDrop Shop",
          "description": "A shop for eco-friendly products",
          "address": {
            "documentId": "address123",
            "street": "Market Street",
            "street_no": "10",
            "zip_code": "67890",
            "city": "Berlin",
            "isPrimary": true
          },
          "reviews": [
            {"rating": 4.0, "review": "Great service"},
            {"rating": 5.0, "review": "Excellent products"}
          ],
          "minimum_order": 15.0,
          "delivery_costs": 2.5,
          "max_delivery_radius": 5.0,
          "latitude": 52.5200,
          "longitude": 13.4050
        },
        "shop2": {
          "documentId": "shop456",
          "name": "Eco Mart",
          "description": "Sustainable and eco-friendly products",
          "address": {
            "documentId": "address456",
            "street": "Eco Street",
            "street_no": "22",
            "zip_code": "54321",
            "city": "Berlin"
          },
          "reviews": [
            {"rating": 3.5, "review": "Decent shop"},
            {"rating": 4.0, "review": "Nice eco-friendly options"}
          ],
          "minimum_order": 20.0,
          "delivery_costs": 3.0,
          "max_delivery_radius": 7.0,
          "latitude": 52.5300,
          "longitude": 13.4050
        }
      }
      ''';

      final shops = await Future.wait(Shop.parseShops(jsonData));

      expect(shops.length, 2);
      expect(shops[0].id, 'shop123');
      expect(shops[1].id, 'shop456');
      expect(shops[0].name, 'GreenDrop Shop');
      expect(shops[1].description, 'Sustainable and eco-friendly products');
      expect(shops[0].rating, 4.33);
      expect(shops[1].minOrder, 20.0);
    });

    test('Should return correct string representation', () {
      final address = Address(
        id: 'address123',
        street: 'Market Street',
        streetNumber: '10',
        zipCode: '67890',
        city: 'Berlin',
      );

      final shop = Shop(
        id: 'shop123',
        name: 'GreenDrop Shop',
        description: 'A shop for eco-friendly products',
        address: address,
        rating: 4.33,
        reviewCount: 3,
        minOrder: 15.0,
        deliveryCost: 2.5,
        latitude: 52.5200,
        longitude: 13.4050,
        radius: 5.0,
      );

      expect(
        shop.toString(),
        'Shop(id: shop123, name: GreenDrop Shop, description: A shop for eco-friendly products, address: Market Street 10 67890 Berlin, rating: 4.33, minOrder: 15.0, deliveryCost: 2.5)',
      );
    });
  });
}
