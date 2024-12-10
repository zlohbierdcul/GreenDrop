import 'package:flutter/material.dart';
import 'package:greendrop/src/presentation/shops/provider/filter_provider.dart';
import 'package:greendrop/src/presentation/shops/provider/shop_data_provider.dart';
import 'package:greendrop/src/presentation/shops/provider/sorting_provider.dart';
import 'package:greendrop/src/presentation/shops/widgets/filter_options.dart';
import 'package:greendrop/src/presentation/shops/widgets/sort_options.dart';
import 'package:provider/provider.dart';

class FilterDialog {
  static Future<void> dialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              const Text('Filtern und Sortieren'),
              CloseButton(
                style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(8),
                    elevation: 5),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          ),
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
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
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
                Consumer3<FilterProvider, SortingProvider, ShopDataProvider>(
                  builder: (context, filterProvider, sortingProvider,
                          shopDataProvider, child) =>
                      TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      foregroundColor: Theme.of(context).colorScheme.onPrimary,
                      textStyle: Theme.of(context).textTheme.labelLarge,
                    ),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text('Anwenden'),
                    ),
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
