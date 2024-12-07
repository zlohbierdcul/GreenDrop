import 'package:greendrop/src/domain/models/product.dart';
import 'package:greendrop/src/domain/models/shop.dart';

abstract class IShopRepository {
  Future<List<Shop>> getAllShops();
  Future<List<Product>> getAllShopProducts(String id);
}
