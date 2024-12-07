import "package:collection/collection.dart";
import 'package:flutter/cupertino.dart';
import 'package:greendrop/src/data/repositories/interfaces/shop_repository.dart';
import 'package:greendrop/src/data/repositories/strapi/strapi_shop_repository.dart';
import 'package:greendrop/src/domain/models/product.dart';
import 'package:greendrop/src/domain/models/shop.dart';

class ProductProvider extends ChangeNotifier {
  IShopRepository repository = StrapiShopRepository();
  
  Map<String, List<Product>> _productMap = {};

  Map<String, List<Product>> get productMap => _productMap;

  void clearProducts() {
    _productMap = {};
    notifyListeners();
  }

  void setShopProducts(List<Product> products) {
    _productMap = groupBy(products, (p) => p.category);
    notifyListeners();
  }

  void loadShopProducts(Shop shop) async {
    List<Product> products = await repository.getAllShopProducts(shop.id);
    _productMap = groupBy(products, (p) => p.category);
    notifyListeners();
  }
}
