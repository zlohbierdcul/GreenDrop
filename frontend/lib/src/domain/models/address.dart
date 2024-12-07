class Address {
  final String street;
  final String streetNumber;
  final String zipCode;
  final String city;
  final bool isPrimary;

  Address(
      {required this.street,
      required this.streetNumber,
      required this.zipCode,
      required this.city,
      required this.isPrimary});

  // Factory constructor to create an Address object from a JSON entry
  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      street: json['street'],
      streetNumber: json['streetNumber'],
      zipCode: json['zipCode'],
      city: json['city'],
      isPrimary: false,
    );
  }

  @override
  String toString() {
    return '$street $streetNumber $zipCode $city';
  }
}
