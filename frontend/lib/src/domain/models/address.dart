class Address {
  final String id;
  final String street;
  final String streetNumber;
  final String zipCode;
  final String city;
  final bool? isPrimary;

  Address(
      {required this.id,
        required this.street,
      required this.streetNumber,
      required this.zipCode,
      required this.city,
      this.isPrimary});

  // Factory constructor to create an Address object from a JSON entry
  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      id: json['id'].toString(),
      street: json['street'],
      streetNumber: json['street_no'],
      zipCode: json['zip_code'],
      city: json['city'] ?? "Mannheim", // TODO: change when all shops have city in database 
      isPrimary: json['is_primary'],
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
