class Address {
  final String id;
  final String street;
  final String streetNumber;
  final String zipCode;
  final String city;
  final bool isPrimary;

  Address(
      {required this.id,
        required this.street,
      required this.streetNumber,
      required this.zipCode,
      required this.city,
      required this.isPrimary});

  // Factory constructor to create an Address object from a JSON entry
  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      id: json['id'].toString(),
      street: json['street'],
      streetNumber: json['street_no'],
      zipCode: json['zip_code'],
      city: "Mannheim", // TODO: ! Backend needs to change Shop Entity
      isPrimary: false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'street': street,
      'street_no': streetNumber,
      'zip_code': zipCode,
      'city': city,
      'is_primary': isPrimary,
    };
  }

  @override
  String toString() {
    return '$street $streetNumber $zipCode $city';
  }
}
