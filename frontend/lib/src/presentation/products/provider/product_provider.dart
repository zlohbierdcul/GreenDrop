import 'dart:collection'; // Für LinkedHashMap
import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:greendrop/src/data/repositories/interfaces/shop_repository.dart';
import 'package:greendrop/src/data/repositories/strapi/strapi_shop_repository.dart';
import 'package:greendrop/src/domain/models/product.dart';
import 'package:greendrop/src/domain/models/shop.dart';

class ProductProvider extends ChangeNotifier {
  IShopRepository repository = StrapiShopRepository();


  LinkedHashMap<String, List<Product>> _productMap = LinkedHashMap();

  LinkedHashMap<String, List<Product>> get productMap => _productMap;

  void clearProducts() {
    _productMap.clear();
    notifyListeners();
  }

  void setShopProducts(List<Product> products) {
    _productMap = LinkedHashMap.from(
      groupBy(products, (p) => p.category),
    );
    notifyListeners();
  }

  void loadShopProducts(Shop shop) async {
    List<Product> products = await repository.getAllShopProducts(shop.id);
    var groupedProducts = groupBy(products, (p) => p.category);
    const categoryOrder = ['Rauchbar', 'Essbar', 'Zubehör'];
    _productMap = LinkedHashMap.fromEntries(
      categoryOrder
          .where((category) => groupedProducts.containsKey(category)) // Nur vorhandene Kategorien
          .map((category) => MapEntry(category, groupedProducts[category]!)),
    );
    notifyListeners();
  }
}
