// test/presentation/shops/provider/sorting_provider_test.dart

import 'package:flutter_test/flutter_test.dart';
import 'package:greendrop/src/domain/enums/sorting_model.dart';
import 'package:greendrop/src/presentation/shops/provider/sorting_provider.dart';

void main() {
  group('SortingProvider Tests', () {
    late SortingProvider sortingProvider;

    setUp(() {
      sortingProvider = SortingProvider();
    });

    test('Initialzustand: _currentSorting ist defaultState', () {
      expect(sortingProvider.sorting, SortingModel.defaultState);
    });

    test('setCurrentSorting ändert Zustand und ruft notifyListeners auf', () {
      sortingProvider.setCurrentSorting(SortingModel.rating);

      expect(sortingProvider.sorting, SortingModel.rating);
    });

    test('resetSorting setzt Zustand auf defaultState', () {
      //ARRANGE
      sortingProvider.setCurrentSorting(SortingModel.rating);
      //ACT
      sortingProvider.resetSorting();
      //ASSERT
      expect(sortingProvider.sorting, SortingModel.defaultState);
    });
  });
}
