import 'package:flutter_test/flutter_test.dart';
import 'package:greendrop/src/domain/models/address.dart';

void main() {
  group('Address Model Tests', () {
    test('Should parse JSON correctly', () {
      final json = {
        'documentId': '123',
        'street': 'Main Street',
        'street_no': '42',
        'zip_code': '12345',
        'city': 'Berlin',
        'is_primary': true
      };

      final address = Address.fromJson(json);

      expect(address.id, '123');
      expect(address.street, 'Main Street');
      expect(address.streetNumber, '42');
      expect(address.zipCode, '12345');
      expect(address.city, 'Berlin');
      expect(address.isPrimary, true);
    });

    test('Should handle missing city field in JSON', () {
      final json = {
        'documentId': '456',
        'street': 'Elm Street',
        'street_no': '13',
        'zip_code': '67890',
        'is_primary': false
      };

      final address = Address.fromJson(json);

      expect(address.city, 'Mannheim'); // Default value
    });

    test('Should convert to JSON correctly', () {
      final address = Address(
        id: '789',
        street: 'Broadway',
        streetNumber: '100',
        zipCode: '54321',
        city: 'New York',
        isPrimary: false,
      );

      final json = address.toJson();

      expect(json['street'], 'Broadway');
      expect(json['street_no'], '100');
      expect(json['zip_code'], '54321');
      expect(json['city'], 'New York');
      expect(json['is_primary'], false);
    });

    test('Should compare two Address objects correctly', () {
      final address1 = Address(
        id: '123',
        street: 'Main Street',
        streetNumber: '42',
        zipCode: '12345',
        city: 'Berlin',
      );

      final address2 = Address(
        id: '123',
        street: 'Another Street',
        streetNumber: '99',
        zipCode: '67890',
        city: 'Hamburg',
      );

      expect(address1, address2); // Same id means equal
    });

    test('Should have correct hashCode', () {
      final address = Address(
        id: '123',
        street: 'Main Street',
        streetNumber: '42',
        zipCode: '12345',
        city: 'Berlin',
      );

      expect(address.hashCode, '123'.hashCode);
    });

    test('Should return correct string representation', () {
      final address = Address(
        id: '123',
        street: 'Main Street',
        streetNumber: '42',
        zipCode: '12345',
        city: 'Berlin',
      );

      expect(address.toString(), 'Main Street 42 12345 Berlin');
    });
  });
}
