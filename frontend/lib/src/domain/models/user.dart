import 'dart:convert';

import 'package:greendrop/src/domain/models/address.dart';

class User {
  final String id;
  final String userId;
  final String userName;
  final String firstName;
  final String lastName;
  final String birthdate;
  final String userDetailId;
  int greenDrops;
  final String eMail;
  final List<Address> addresses;

  User(
      {required this.id,
      required this.userId,
      required this.userDetailId,
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
        id: json['documentId'].toString(),
        userId: json['id'].toString(),
        userDetailId: json['user_detail']['documentId'],
        userName: json['user_detail']['username'],
        firstName: json['user_detail']['first_name'],
        lastName: json['user_detail']['last_name'],
        birthdate: json['user_detail']['birthdate'],
        greenDrops: json['user_detail']['green_drops'],
        eMail: json['user_detail']['email'],
        addresses: (json['user_detail']['addresses'] as List<dynamic>)
            .map((addressJson) => Address.fromJson(addressJson))
            .toSet()
            .toList());
  }

  Map<String, dynamic> toJson() {
    return {
      'username': userName,
      'first_name': firstName,
      'last_name': lastName,
      'birthdate': birthdate,
      'green_drops': greenDrops,
      'email': eMail,
      'addresses': addresses.map((address) => address.id).toList(),
    };
  }

  static List<User> parseUsers(String jsonData) {
    final Map<String, dynamic> data = json.decode(jsonData);
    return data.entries.map((entry) => User.fromJson(entry.value)).toList();
  }

  void changeAddress(Address address) {
    int index =
        addresses.indexOf(addresses.firstWhere((a) => a.id == address.id));
    addresses[index] = address;
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
