import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:greendrop/src/features/shops/data/shop.dart';

class ShopDataProvider extends ChangeNotifier {
  ShopDataProvider() {
    _getInitialData();
  }

  Map<String, Shop> _shopList = {};
  Map<String, Shop> _originalShopList = {};

  Map<String, Shop> get shopList => _shopList;

  Future<void> _getInitialData() async {
    // Temporary implementation
    String response =
        await rootBundle.loadString("assets/data/mock-shops.json");
    List<Shop> shops = Shop.parseShops(response);
    _shopList =
        Map.fromIterable(shops, key: (shop) => shop.id, value: (shop) => shop);
    _originalShopList = _shopList;
    notifyListeners();
  }

  void filterDataBySearchTerm(String searchTerm) {
    final filteredShopList = _originalShopList.entries
        .where((entry) =>
            entry.value.name.toLowerCase().contains(searchTerm.toLowerCase()))
        .map((entry) => MapEntry(entry.key, entry.value));

    final Map<String, Shop> filteredShopData =
        Map.fromEntries(filteredShopList);

    _shopList = filteredShopData;
    notifyListeners();
  }
}
