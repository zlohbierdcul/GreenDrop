import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:greendrop/src/features/shops/data/shop.dart';
import 'package:greendrop/src/features/shops/data/sorting_model.dart';

class ShopDataProvider extends ChangeNotifier {
  ShopDataProvider() {
    _getInitialData();
  }

  Map<String, Shop> _shopList = {};
  Map<String, Shop> _filteredShopList = {};
  Map<String, Shop> _originalShopList = {};

  Map<String, Shop> get shopList => _shopList;

  Future<void> _getInitialData() async {
    // Temporary implementation
    String response =
        await rootBundle.loadString("assets/data/mock-shops.json");
    List<Future<Shop>> shops = Shop.parseShops(response);

    for (Future<Shop> shop in shops) {
      Shop shopData = await shop;
      _shopList.putIfAbsent(shopData.id, () => shopData);
    }

    _originalShopList = _shopList;
    sortShopsBySingleCriterion(criterion: SortingModel.defaultState);
    notifyListeners();
  }

  void filterDataBySearchTerm(String searchTerm) {
    final filteredShopList = _filteredShopList.entries
        .where((entry) =>
            entry.value.name.toLowerCase().contains(searchTerm.toLowerCase()))
        .map((entry) => MapEntry(entry.key, entry.value));

    final Map<String, Shop> filteredShopData =
        Map.fromEntries(filteredShopList);

    _shopList = filteredShopData;
    notifyListeners();
  }

  void filterData(double minCost, double deliveryCost) {
    final filteredShopList = _originalShopList.entries
        .where((entry) => entry.value.minOrder <= minCost)
        .where((entry) => entry.value.deliveryCost <= deliveryCost)
        .map((entry) => MapEntry(entry.key, entry.value));

    final Map<String, Shop> filteredShopData =
        Map.fromEntries(filteredShopList);

    _shopList = filteredShopData;
    notifyListeners();
  }

  void sortShopsBySingleCriterion({
    required SortingModel criterion,
    bool ascending = true,
  }) {
    final entries = _shopList.entries.toList();

    entries.sort((a, b) {
      final shopA = a.value;
      final shopB = b.value;

      int comparison = 0;
      switch (criterion) {
        case SortingModel.rating:
          comparison = shopA.rating.compareTo(shopB.rating);
          ascending = false;
          break;
        case SortingModel.minCost:
          comparison = shopA.minOrder.compareTo(shopB.minOrder);
          break;
        case SortingModel.deliveryCost:
          comparison = shopA.deliveryCost.compareTo(shopB.deliveryCost);
          break;
        case SortingModel.defaultState:
          comparison = shopA.name.compareTo(shopB.name);
      }

      // Reverse comparison for descending order
      return ascending ? comparison : -comparison;
    });

    _shopList = Map.fromEntries(entries);
    _filteredShopList = _shopList;
    notifyListeners();
  }
}
