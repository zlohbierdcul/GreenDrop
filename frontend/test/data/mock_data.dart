import 'package:greendrop/src/domain/models/drug.dart';
import 'package:greendrop/src/domain/models/product.dart';
import 'package:greendrop/src/domain/models/shop.dart';
import 'package:greendrop/src/domain/models/user.dart';
import 'package:greendrop/src/domain/models/address.dart';

class DataRepository{

  static final User _user = User(
    id: User.genericUser.id,
    userId: User.genericUser.userId,
    userDetailId: User.genericUser.userDetailId,
    firstName: User.genericUser.firstName,
    lastName: User.genericUser.lastName,
    greenDrops: 10000,
    birthdate: User.genericUser.birthdate,
    eMail: User.genericUser.eMail,
    userName: "user1",
    addresses: [Address(
        id: "1",
        zipCode: "68193",
        city: "Mannheim",
        street: "Luisenring",
        streetNumber: "1")
        ,
        Address(
        id: "2",
        zipCode: "68199",
        city: "Mannheim",
        street: "Speyerer Straße",
        streetNumber: "51",)]
  );

  static final List<Product> _products = [
    Drug(category: "Rauchbar",
    description: "Riecht gut!",
    id: "1",
    name: "Rauchbarstes 1",
    price: 11.23,
    imageUrl: "/uploads/thumbnail_Zkittlez_cbb9049380.png",
    stock: 10,
    indica: 0.3,
    sativa: 0.1,
    thc: 0.01,
    cbd:  0.91,
    effects: ["erheiternd", "stark"],
    tastes: ["süß", "vanillig"]
     ),
    Drug(category: "Essbar",
    description: "Schmeckt gut!",
    id: "2",
    name: "Essbarstes 1",
    price: 14.32,
    imageUrl: "/uploads/thumbnail_Zkittlez_cbb9049380.png",
    stock: 11,
    indica: 0.4,
    sativa: 0.2,
    thc: 0.4,
    cbd:  0.01,
    effects: ["erheiternd", "stark"],
    tastes: ["süß", "vanillig"]
     ),

     Product(category: "Zubehör",
    description: "Greift gut!",
    id: "3",
    name: "Bong 1",
    price: 24.31,
    imageUrl: "/uploads/thumbnail_Zkittlez_cbb9049380.png",
    stock: 5
     )
  ];

  static final List<Shop> _shops = [
    Shop(
      reviewCount: 100,
      rating: 4.0,
      id: "1",
      name: "420 Vibes",
      radius: 10,
      minOrder: 12.00,
      deliveryCost: 1.00,
      description: "Test Shop",
      latitude: 47,
      longitude: 8,
      address:  Address(
        id: "3",
        zipCode: "68193",
        city: "Mannheim",
        street: "Luisenring",
        streetNumber: "5",),
    ),
      Shop(
      reviewCount: 10,
      rating: 4.5,
      id: "2",
      name: "Bud Corner",
      radius: 1,
      minOrder: 12.00,
      deliveryCost: 1.00,
      description: "Test Shop 2",
      latitude: 47,
      longitude: 8,
      address:  Address(
        id: "3",
        zipCode: "68193",
        city: "Mannheim",
        street: "Luisenring",
        streetNumber: "4",
        ),
    ),

  ];

  static List<Product> get products => _products;
  static Product get product => _products.first;
  static List<Shop> get shops => _shops;
  static Shop get shop => _shops.first;
  static User get user => _user;
  
}