import 'package:flutter/cupertino.dart';
import 'package:greendrop/src/domain/enums/sorting_model.dart';

class SortingProvider extends ChangeNotifier {
  SortingModel _currentSorting = SortingModel.defaultState;

  SortingModel get sorting => _currentSorting;

  void setCurrentSorting(SortingModel currentSorting) {
    _currentSorting = currentSorting;
    notifyListeners();
  }

  void resetSorting() {
    _currentSorting = SortingModel.defaultState;
    notifyListeners();
  }
}
