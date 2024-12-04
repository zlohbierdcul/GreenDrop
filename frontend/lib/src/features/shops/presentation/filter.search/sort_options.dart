import 'package:flutter/material.dart';
import 'package:greendrop/src/features/shops/data/sorting_model.dart';
import 'package:greendrop/src/features/shops/presentation/provider/sorting_provider.dart';
import 'package:provider/provider.dart';

class SortingRadioList extends StatelessWidget {
  const SortingRadioList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SortingProvider>(
      builder: (context, sortingProvider, child) => Column(
        children: SortingModel.values.map((sortingItem) {
          return RadioListTile<SortingModel>(
            value: sortingItem,
            groupValue: sortingProvider.sorting,
            title: Text(sortingItem.label),
            onChanged: (_) => sortingProvider.setCurrentSorting(sortingItem),
            selected: sortingProvider.sorting == sortingItem,
            mouseCursor: SystemMouseCursors.click,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          );
        }).toList(),
      ),
    );
  }
}
