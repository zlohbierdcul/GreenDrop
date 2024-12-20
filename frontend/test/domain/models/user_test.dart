import 'package:flutter_test/flutter_test.dart';
import 'package:greendrop/src/domain/models/user.dart';
import 'package:greendrop/src/domain/models/address.dart';

void main() {
  group('User Model Tests', () {
    test('Should parse JSON correctly into User object', () {
      final json = {
        'id': 'user123',
        'username': 'john_doe',
        'first_name': 'John',
        'last_name': 'Doe',
        'birthdate': '01-01-1990',
        'green_drops': 100,
        'email': 'john.doe@example.com',
        'addresses': [
          {
            'documentId': 'address123',
            'street': 'Main Street',
            'street_no': '42',
            'zip_code': '12345',
            'city': 'Berlin',
            'is_primary': true,
          },
        ],
      };

      final user = User.fromJson(json);

      expect(user.id, 'user123');
      expect(user.userName, 'john_doe');
      expect(user.firstName, 'John');
      expect(user.lastName, 'Doe');
      expect(user.birthdate, '01-01-1990');
      expect(user.greenDrops, 100);
      expect(user.eMail, 'john.doe@example.com');
      expect(user.addresses.length, 1);
      expect(user.addresses.first.street, 'Main Street');
    });

    test('Should convert User object to JSON correctly', () {
      final address = Address(
        id: 'address123',
        street: 'Main Street',
        streetNumber: '42',
        zipCode: '12345',
        city: 'Berlin',
        isPrimary: true,
      );

      final user = User(
        id: 'user123',
        userName: 'john_doe',
        firstName: 'John',
        lastName: 'Doe',
        birthdate: '01-01-1990',
        greenDrops: 100,
        eMail: 'john.doe@example.com',
        addresses: [address],
      );

      final json = user.toJson();

      expect(json['id'], 'user123');
      expect(json['username'], 'john_doe');
      expect(json['first_name'], 'John');
      expect(json['last_name'], 'Doe');
      expect(json['birthdate'], '01-01-1990');
      expect(json['green_drops'], 100);
      expect(json['email'], 'john.doe@example.com');
      expect((json['addresses'] as List).length, 1);
      expect((json['addresses'] as List).first['street'], 'Main Street');
    });

    test('Should parse a list of Users from JSON string', () {
      const jsonData = '''
      {
        "user1": {
          "id": "user123",
          "username": "john_doe",
          "first_name": "John",
          "last_name": "Doe",
          "birthdate": "01-01-1990",
          "green_drops": 100,
          "email": "john.doe@example.com",
          "addresses": [
            {
              "documentId": "address123",
              "street": "Main Street",
              "street_no": "42",
              "zip_code": "12345",
              "city": "Berlin",
              "is_primary": true
            }
          ]
        },
        "user2": {
          "id": "user456",
          "username": "jane_doe",
          "first_name": "Jane",
          "last_name": "Doe",
          "birthdate": "02-02-1992",
          "green_drops": 200,
          "email": "jane.doe@example.com",
          "addresses": [
            {
              "documentId": "address456",
              "street": "Second Street",
              "street_no": "24",
              "zip_code": "54321",
              "city": "Hamburg",
              "is_primary": false
            }
          ]
        }
      }
      ''';

      final users = User.parseUsers(jsonData);

      expect(users.length, 2);
      expect(users[0].id, 'user123');
      expect(users[1].id, 'user456');
      expect(users[0].userName, 'john_doe');
      expect(users[1].firstName, 'Jane');
      expect(users[1].addresses.first.city, 'Hamburg');
    });

    test('Should change address correctly', () {
      final address1 = Address(
        id: 'address123',
        street: 'Main Street',
        streetNumber: '42',
        zipCode: '12345',
        city: 'Berlin',
        isPrimary: true,
      );

      final address2 = Address(
        id: 'address123',
        street: 'Updated Street',
        streetNumber: '99',
        zipCode: '12345',
        city: 'Berlin',
        isPrimary: false,
      );

      final user = User(
        id: 'user123',
        userName: 'john_doe',
        firstName: 'John',
        lastName: 'Doe',
        birthdate: '01-01-1990',
        greenDrops: 100,
        eMail: 'john.doe@example.com',
        addresses: [address1],
      );

      user.changeAddress(address2);

      expect(user.addresses.first.street, 'Updated Street');
      expect(user.addresses.first.streetNumber, '99');
      expect(user.addresses.first.isPrimary, false);
    });

    test('Should set greenDrops correctly', () {
      final user = User(
        id: 'user123',
        userName: 'john_doe',
        firstName: 'John',
        lastName: 'Doe',
        birthdate: '01-01-1990',
        greenDrops: 100,
        eMail: 'john.doe@example.com',
        addresses: [],
      );

      user.setGreendrops(200);

      expect(user.greenDrops, 200);
    });

    test('Should return correct string representation', () {
      final user = User(
        id: 'user123',
        userName: 'john_doe',
        firstName: 'John',
        lastName: 'Doe',
        birthdate: '01-01-1990',
        greenDrops: 100,
        eMail: 'john.doe@example.com',
        addresses: [],
      );

      expect(
        user.toString(),
        'User(id: user123, userName: john_doe, birthdate: 01-01-1990, greenDrops: 100, eMail: john.doe@example.com)',
      );
    });
  });
}
