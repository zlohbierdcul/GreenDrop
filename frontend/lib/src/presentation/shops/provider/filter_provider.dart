import 'package:flutter/cupertino.dart';

class FilterProvider extends ChangeNotifier {
  double _deliveryCost = 10;
  double _minCost = 50;

  double get deliveryCost => _deliveryCost;
  double get minCost => _minCost;

  void setDeliveryCost(double cost) {
    _deliveryCost = cost;
    notifyListeners();
  }

  void setMinCost(double cost) {
    _minCost = cost;
    notifyListeners();
  }

  void resetFilter() {
    _deliveryCost = 10;
    _minCost = 50;
    notifyListeners();
  }
}
