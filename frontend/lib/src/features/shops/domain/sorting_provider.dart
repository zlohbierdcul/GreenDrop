import 'package:flutter/cupertino.dart';
import 'package:greendrop/src/features/shops/data/sorting_model.dart';

class SortingProvider extends ChangeNotifier {
  SortingModel _currentSorting = SortingModel.defaultState;

  SortingModel get sorting => _currentSorting;

  void setCurrentSorting(SortingModel currentSorting) {
    _currentSorting = currentSorting;
    notifyListeners();
  }
}
