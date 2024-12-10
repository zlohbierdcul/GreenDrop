
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:greendrop/src/domain/models/address.dart';
import 'package:greendrop/src/domain/models/user.dart';

class StrapiAPI {
  final String baseUrl = dotenv.env["API_BASE_URL"]!;

  String getShops() {
    return "$baseUrl/api/shops?populate=reviews";
  }

  String getProductsOfShopById(String id) {
    return "$baseUrl/api/shops/$id?populate[shop_products][populate][product][populate]=*";
  }

  String getDrugFromId(String id) {
    return "$baseUrl/api/drugs/$id?populate=*";
  }

  String getSignIn() {
    return "$baseUrl/api/auth/local?populate=*";
  }

  String getUser(String id) {
    return "$baseUrl/api/users/$id?populate=*";
  }

  String updateUser(User user) {
    return "$baseUrl/api/users/${user.id}";
  }

  String updateAddress(Address address) {
    return "$baseUrl/api/addresses/${address.id}";
  }

  String deleteAddress(Address address) {
    return "$baseUrl/api/addresses/${address.id}";
  }

  String createOrder() {
    return "$baseUrl/api/order";
  }

  String getAuth() {
    return "Bearer ${dotenv.env["API_TOKEN"]}";
  }
}