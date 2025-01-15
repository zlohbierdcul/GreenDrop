import 'package:flutter_test/flutter_test.dart';
import 'package:greendrop/src/domain/models/drug.dart';

void main() {
  group('Drug Model Tests', () {
    test('Should parse JSON correctly into Drug object', () {
      final json = {
        'id': '1234',
        'name': 'Blue Dream',
        'price': 12.5,
        'stock': 20,
        'category': 'Hybrid',
        'image_url': 'https://example.com/image.jpg',
        'description': 'A popular hybrid cannabis strain.',
        'indica': 40.0,
        'sativa': 60.0,
        'thc': 18.0,
        'cbd': 1.0,
        'effects': ['Relaxed', 'Happy', 'Euphoric'],
        'tastes': ['Berry', 'Sweet', 'Earthy']
      };

      final drug = Drug.fromJson(json);

      expect(drug.id, '1234');
      expect(drug.name, 'Blue Dream');
      expect(drug.price, 12.5);
      expect(drug.stock, 20);
      expect(drug.category, 'Hybrid');
      expect(drug.imageUrl, 'https://example.com/image.jpg');
      expect(drug.description, 'A popular hybrid cannabis strain.');
      expect(drug.indica, 40.0);
      expect(drug.sativa, 60.0);
      expect(drug.thc, 18.0);
      expect(drug.cbd, 1.0);
      expect(drug.effects, ['Relaxed', 'Happy', 'Euphoric']);
      expect(drug.tastes, ['Berry', 'Sweet', 'Earthy']);
    });

    test('Should convert Drug object to JSON correctly', () {
      final drug = Drug(
        id: '1234',
        name: 'Blue Dream',
        price: 12.5,
        stock: 20,
        category: 'Hybrid',
        imageUrl: 'https://example.com/image.jpg',
        description: 'A popular hybrid cannabis strain.',
        indica: 40.0,
        sativa: 60.0,
        thc: 18.0,
        cbd: 1.0,
        effects: ['Relaxed', 'Happy', 'Euphoric'],
        tastes: ['Berry', 'Sweet', 'Earthy'],
      );

      final json = drug.toJson();

      expect(json['id'], '1234');
      expect(json['name'], 'Blue Dream');
      expect(json['price'], 12.5);
      expect(json['stock'], 20);
      expect(json['category'], 'Hybrid');
      expect(json['imageUrl'], 'https://example.com/image.jpg');
      expect(json['description'], 'A popular hybrid cannabis strain.');
      expect(json['indica'], 40.0);
      expect(json['sativa'], 60.0);
      expect(json['thc'], 18.0);
      expect(json['cbd'], 1.0);
      expect(json['effects'], ['Relaxed', 'Happy', 'Euphoric']);
      expect(json['tastes'], ['Berry', 'Sweet', 'Earthy']);
    });

    test('Should parse a list of Drugs from JSON string', () {
      const jsonData = '''
        [
          {
            "id": "1234",
            "name": "Blue Dream",
            "price": 12.5,
            "stock": 20,
            "category": "Hybrid",
            "image_url": "https://example.com/image1.jpg",
            "description": "A popular hybrid cannabis strain.",
            "indica": 40.0,
            "sativa": 60.0,
            "thc": 18.0,
            "cbd": 1.0,
            "effects": ["Relaxed", "Happy", "Euphoric"],
            "tastes": ["Berry", "Sweet", "Earthy"]
          },
          {
            "id": "2345",
            "name": "Sour Diesel",
            "price": 15.0,
            "stock": 10,
            "category": "Sativa",
            "image_url": "https://example.com/image2.jpg",
            "description": "A sativa strain known for its energizing effects.",
            "indica": 20.0,
            "sativa": 80.0,
            "thc": 22.0,
            "cbd": 0.5,
            "effects": ["Energetic", "Creative"],
            "tastes": ["Citrus", "Diesel"]
          }
        ]
      ''';

      final drugs = Drug.parseDrugs(jsonData);


      expect(drugs.length, 2);
      expect(drugs[1].id, '2345');
      expect(drugs[1].name, 'Sour Diesel');
      expect(drugs[1].price, 15.0);
      expect(drugs[1].stock, 10);
      expect(drugs[1].category, "Sativa");
      expect(drugs[1].imageUrl, "https://example.com/image2.jpg");
      expect(drugs[1].description, "A sativa strain known for its energizing effects.");
      expect(drugs[1].indica, 20.0);
      expect(drugs[1].sativa, 80.0);
      expect(drugs[1].thc, 22.0);
      expect(drugs[1].cbd, 0.5);
      expect(drugs[1].effects, ['Energetic', 'Creative']);
      expect(drugs[1].tastes, ['Citrus', 'Diesel']);

      expect(drugs[0].id, '1234');
      expect(drugs[0].name, 'Blue Dream');
      expect(drugs[0].price, 12.5);
      expect(drugs[0].stock, 20);
      expect(drugs[0].category, 'Hybrid');
      expect(drugs[0].imageUrl, 'https://example.com/image1.jpg');
      expect(drugs[0].description,'A popular hybrid cannabis strain.');
      expect(drugs[0].indica, 40.0);
      expect(drugs[0].sativa, 60.0);
      expect(drugs[0].thc, 18.0);
      expect(drugs[0].cbd, 1.0);
      expect(drugs[0].effects,['Relaxed', 'Happy', 'Euphoric']);
      expect(drugs[0].tastes,['Berry', 'Sweet', 'Earthy']);
    });

    test('Should return correct string representation', () {
      final drug = Drug(
        id: '1234',
        name: 'Blue Dream',
        price: 12.5,
        stock: 20,
        category: 'Hybrid',
        imageUrl: 'https://example.com/image.jpg',
        description: 'A popular hybrid cannabis strain.',
        indica: 40.0,
        sativa: 60.0,
        thc: 18.0,
        cbd: 1.0,
        effects: ['Relaxed', 'Happy', 'Euphoric'],
        tastes: ['Berry', 'Sweet', 'Earthy'],
      );

      expect(
        drug.toString(),
        'Drug(id: 1234, name: Blue Dream, price: 12.5, stock: 20, category: Hybrid, indica: 40.0, sativa: 60.0, thc: 18.0, cbd: 1.0, effects: [Relaxed, Happy, Euphoric], tastes: [Berry, Sweet, Earthy])',
      );
    });
  });
}
