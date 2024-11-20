import 'package:flutter/cupertino.dart';

class FilterProvider extends ChangeNotifier {
  double _deliveryCost = 9.5;
  double _minCost = 15;

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
}
