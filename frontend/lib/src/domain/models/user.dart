import 'dart:convert';

import 'package:greendrop/src/domain/models/address.dart';

class User {
  final String id;
  final String userName;
  final String firstName;
  final String lastName;
  final String birthdate;
  final int greenDrops;
  final String eMail;
  final List<Address> addresses;

  User(
      {required this.id,
      required this.userName,
      required this.firstName,
      required this.lastName,
      required this.birthdate,
      required this.greenDrops,
      required this.eMail,
      required this.addresses});

  // Factory constructor to create a User object from a JSON entry
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'].toString(),
        userName: json['username'],
        firstName: json['first_name'],
        lastName: json['last_name'],
        birthdate: json['birthdate'],
        greenDrops: json['green_drops'],
        eMail: json['email'],
        addresses: (json['addresses'] as List<dynamic>)
            .map((addressJson) => Address.fromJson(addressJson))
            .toList());
  }

  // Static method to parse mock data and create a list of Users
  static List<User> parseUsers(String jsonData) {
    final Map<String, dynamic> data = json.decode(jsonData);
    return data.entries
        .map((entry) => User.fromJson(entry.value))
        .toList();
  }

  @override
  String toString() {
    return 'User('
        'id: $id, '
        'userName: $userName, '
        'birthdate: $birthdate, '
        'greenDrops: $greenDrops, '
        'eMail: $eMail'
        ')';
  }
}
