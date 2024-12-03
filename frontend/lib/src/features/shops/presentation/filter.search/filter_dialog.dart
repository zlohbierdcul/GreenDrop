import 'package:flutter/material.dart';
import 'package:greendrop/src/features/shops/domain/filter_provider.dart';
import 'package:greendrop/src/features/shops/domain/shop_data_provider.dart';
import 'package:greendrop/src/features/shops/domain/sorting_provider.dart';
import 'package:greendrop/src/features/shops/presentation/filter.search/filter_options.dart';
import 'package:greendrop/src/features/shops/presentation/filter.search/sort_options.dart';
import 'package:provider/provider.dart';

class FilterDialog {
  static Future<void> dialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Filtern und Sortieren'),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Filtern nach",
                style: TextStyle(fontSize: 18),
              ),
              Divider(),
              FilterOptions(),
              Text(
                "Sortieren nach",
                style: TextStyle(fontSize: 18),
              ),
              Divider(),
              SortingRadioList()
            ],
          ),
          actions: <Widget>[
            Consumer2<FilterProvider, SortingProvider>(
              builder: (context, filterProvider, sortingProvider, child) =>
                  TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.error,
                  foregroundColor: Theme.of(context).colorScheme.onError,
                  textStyle: Theme.of(context).textTheme.labelLarge,
                ),
                child: const Text('Zurücksetzen'),
                onPressed: () {
                  filterProvider.resetFilter();
                  sortingProvider.resetSorting();
                },
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  style: TextButton.styleFrom(
                    textStyle: Theme.of(context).textTheme.labelLarge,
                  ),
                  child: const Text('Abbrechen'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                Consumer3<FilterProvider, SortingProvider, ShopDataProvider>(
                  builder: (context, filterProvider, sortingProvider,
                          shopDataProvider, child) =>
                      TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      foregroundColor: Theme.of(context).colorScheme.onPrimary,
                      textStyle: Theme.of(context).textTheme.labelLarge,
                    ),
                    child: const Text('Anwenden'),
                    onPressed: () {
                      shopDataProvider.filterData(
                          filterProvider.minCost, filterProvider.deliveryCost);
                      shopDataProvider.sortShopsBySingleCriterion(
                          criterion: sortingProvider.sorting);
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ],
            )
          ],
        );
      },
    );
  }
}
