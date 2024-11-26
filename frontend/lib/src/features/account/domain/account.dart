class Account {
  final String id;
  final String userName;
  final String firstName;
  final String lastName;
  final String street;
  final int houseNumber;
  final int plz;
  final String city;
  final String number;

  Account({
    required this.id,
    required this.userName,
    required this.firstName,
    required this.lastName,
    required this.street,
    required this.houseNumber,
    required this.plz,
    required this.city,
    required this.number,
  });

  // Methode, um JSON-Daten in ein Account-Objekt zu konvertieren
  factory Account.fromJson(String id, Map<String, dynamic> json) {
    return Account(
      id: id,
      userName: json['userName'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      street: json['street'],
      houseNumber: json['houseNumber'],
      plz: json['plz'],
      city: json['city'],
      number: json['number'],
    );
  }

  // Methode, um ein Account-Objekt in JSON-Daten zu konvertieren
  Map<String, dynamic> toJson() {
    return {
      'userName': userName,
      'firstName': firstName,
      'lastName': lastName,
      'street': street,
      'houseNumber': houseNumber,
      'plz': plz,
      'city': city,
      'number': number,
    };
  }
}
