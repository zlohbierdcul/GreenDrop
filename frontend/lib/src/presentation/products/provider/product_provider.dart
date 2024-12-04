import "package:collection/collection.dart";
import 'package:flutter/cupertino.dart';
import 'package:greendrop/src/domain/models/product.dart';

class ProductProvider extends ChangeNotifier {
  Map<String, List<Product>>? _productMap;

  Map<String, List<Product>> get productMap => _productMap!;

  void setShopProducts(List<Product> products) {
    _productMap = groupBy(products, (p) => p.type);
    notifyListeners();
  }
}
