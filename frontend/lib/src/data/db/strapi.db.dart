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
    return "$baseUrl/api/users/$id?populate[user_detail][populate][addresses]=*";
  }

  String updateUser(User user) {
    return "$baseUrl/api/user-details/${user.userDetailId}";
  }

  String updateAddress(Address address) {
    return "$baseUrl/api/addresses/${address.id}";
  }

  String addAddress() {
    return "$baseUrl/api/addresses/";
  }

  String deleteAddress(Address address) {
    return "$baseUrl/api/addresses/${address.id}";
  }

  String connectAddressToUser(String userId) {
    return "$baseUrl/api/user-details/$userId";
  }

  String createOrder() {
    return "$baseUrl/api/order";
  }

  String getUserOrdersBase(userId) {
    return baseUrl +
        r"/api/orders?populate[0]=shop&populate[1]=user_address&filters[users_permissions_user][id][$eq]=" +
        userId;
  }

  String getUserOrdersItems(userId) {
    return baseUrl +
        r"/api/orders?populate[items][populate][product][populate][1]=product&filters[users_permissions_user][id][$eq]=" +
        userId;
  }

  String getShopById(id) {
    return "$baseUrl/api/shops/$id?populate=reviews";
  }

  String getAddressById(id) {
    return "$baseUrl/api/addresses/$id";
  }

  String getUserOrders(userId) {
    return baseUrl +
        r"/api/orders?populate[0]=user_permissions_user&populate[items][populate][product][populate][1]=product&populate[3]=shop&filters[users_permissions_user][id][$eq]=" +
        userId;
  }

  String getAuth() {
    return "Bearer ${dotenv.env["API_TOKEN"]}";
  }

  String getRegister() {
    return "$baseUrl/api/auth/local/register";
  }
}
