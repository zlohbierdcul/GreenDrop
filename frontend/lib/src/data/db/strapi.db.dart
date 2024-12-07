
import 'package:flutter_dotenv/flutter_dotenv.dart';

class StrapiAPI {
  final String baseUrl = dotenv.env["API_BASE_URL"]!;

  String getShops() {
    return "$baseUrl/shops/";
  }

  String getProductsOfShopById(String id) {
    return "$baseUrl/shops/$id?populate[shop_products][populate][product][populate]=*";
  }

  String getDrugFromId(String id) {
    return "$baseUrl/drugs/$id?populate=*";
  }

  getAuth() {
    return "Bearer ${dotenv.env["API_TOKEN"]}";
  }
}