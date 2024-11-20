import 'package:flutter/material.dart';
import 'package:greendrop/src/features/shops/presentation/filter_options.dart';
import 'package:greendrop/src/features/shops/presentation/sort_options.dart';

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
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.error,
                foregroundColor: Theme.of(context).colorScheme.onError,
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Zurücksetzen'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
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
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Theme.of(context).colorScheme.onPrimary,
                    textStyle: Theme.of(context).textTheme.labelLarge,
                  ),
                  child: const Text('Anwenden'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            )
          ],
        );
      },
    );
  }
}
