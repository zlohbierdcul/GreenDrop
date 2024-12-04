import 'dart:convert';

import 'package:greendrop/src/features/order/domain/address.dart';

class User {
  final String id;
  final String name;
  final String birthdate;
  final int greenDrops;
  final String eMail;
  final List<Address> addresses;

  User(
      {required this.id,
      required this.name,
      required this.birthdate,
      required this.greenDrops,
      required this.eMail,
      required this.addresses});

  // Factory constructor to create a User object from a JSON entry
  factory User.fromJson(String id, Map<String, dynamic> json) {
    return User(
        id: id,
        name: json['name'],
        birthdate: json['birthdate'],
        greenDrops: json['greenDrops'],
        eMail: json['eMail'],
        addresses: (json['addresses'] as List<dynamic>)
            .map((addressJson) => Address.fromJson(addressJson))
            .toList());
  }

  // Static method to parse mock data and create a list of Users
  static List<User> parseUsers(String jsonData) {
    final Map<String, dynamic> data = json.decode(jsonData);
    return data.entries
        .map((entry) => User.fromJson(entry.key, entry.value))
        .toList();
  }

  @override
  String toString() {
    return 'User('
        'id: $id, '
        'name: $name, '
        'birthdate: $birthdate, '
        'greenDrops: $greenDrops, '
        'eMail: $eMail'
        ')';
  }
}
