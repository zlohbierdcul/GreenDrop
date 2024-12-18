import 'dart:convert';

import 'package:greendrop/src/domain/models/address.dart';

class User {
  final String id;
  final String userName;
  final String firstName;
  final String lastName;
  final String birthdate;
  int greenDrops;
  final String eMail;
  final List<Address> addresses;

  static final genericUser = User(
      id: "000",
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

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': userName,
      'first_name': firstName,
      'last_name': lastName,
      'birthdate': birthdate,
      'green_drops': greenDrops,
      'email': eMail,
      'addresses': addresses.map((address) => address.toJson()).toList(),
    };
  }

  // Static method to parse mock data and create a list of Users
  static List<User> parseUsers(String jsonData) {
    final Map<String, dynamic> data = json.decode(jsonData);
    return data.entries.map((entry) => User.fromJson(entry.value)).toList();
  }

  void setGreendrops(int newGreendropValue) {
    greenDrops = newGreendropValue;
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
