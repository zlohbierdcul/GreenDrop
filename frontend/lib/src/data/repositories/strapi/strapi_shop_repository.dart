import 'package:dio/dio.dart';
import 'package:greendrop/src/data/db/strapi.db.dart';
import 'package:greendrop/src/data/repositories/interfaces/shop_repository.dart';
import 'package:greendrop/src/domain/models/drug.dart';
import 'package:greendrop/src/domain/models/product.dart';
import 'package:greendrop/src/domain/models/shop.dart';

class StrapiShopRepository extends IShopRepository{
  Dio dio = Dio();
  StrapiAPI api = StrapiAPI();

  // Add authorization token to every request
  StrapiShopRepository() {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          options.headers["Authorization"] = api.getAuth();
          return handler.next(options);
        },
      )
    );
  }

  @override
  Future<List<Shop>> getAllShops() async  {
    Response result = await dio.get(api.getShops());
    List<dynamic> shopData = result.data["data"];
    List<Shop> shops = <Shop>[];

    for (dynamic shop in shopData) {
      Shop parsedShop = await Shop.fromJson(shop);
      shops.add(parsedShop);
    }

    return shops;
  }

  @override
  Future<List<Product>> getAllShopProducts(String id) async {
    Response result = await dio.get(api.getProductsOfShopById(id));
    Map<String, dynamic> data = result.data["data"];
    List<Product> products = [];
    for (dynamic shopProduct in data["shop_products"]) {
      dynamic product = shopProduct['product'];
      dynamic drug = product['drug'];


      bool isDrug = drug != null;
      if (isDrug) {
        Response drugResult = await dio.get(api.getDrugFromId(drug['documentId']));
        drug = drugResult.data["data"];

        List<dynamic> tastes = drug['tastes'].map((taste) => taste['name']).toList();
        List<dynamic> effects = drug['effects'].map((effect) => effect['name']).toList();

        products.add(Drug.fromJson({
          "name": product['name'],
          "price": shopProduct['price'],
          "stock": shopProduct['stock'],
          "description": product['description'] ?? "-",
          "category": product['category'],
          "image_url": product['image']['url'],
          "indica": drug['indica'],
          "sativa": drug['sativa'],
          "thc": drug['thc'],
          "cbd": drug['cbd'],
          "tastes": tastes,
          "effects": effects
        }));
      } else {
        products.add(Product.fromJson({
          "name": product['name'],
          "price": shopProduct['price'],
          "stock": shopProduct['stock'],
          "description": product['description'] ?? "-",
          "category": product['category'],
          "image_url": product['image']['url'],
        }));
      }
    }
    return products;
  }
}