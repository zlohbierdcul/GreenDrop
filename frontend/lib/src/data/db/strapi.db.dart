
import 'package:flutter_dotenv/flutter_dotenv.dart';

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

  getAuth() {
    return "Bearer ${dotenv.env["API_TOKEN"]}";
  }
}