import 'package:flutter/material.dart';
import 'package:greendrop/src/features/shops/domain/filter_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class FilterOptions extends StatelessWidget {
  const FilterOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<FilterProvider>(
      builder: (context, filterProvider, child) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 8),
          const Text("Lieferkosten:"),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Slider(
                min: 0,
                max: 10,
                divisions: 20,
                value: filterProvider.deliveryCost,
                onChanged: filterProvider.setDeliveryCost,
              ),
              Card(
                  child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Text(
                    NumberFormat("00.00€").format(filterProvider.deliveryCost)),
              )),
            ],
          ),
          const SizedBox(height: 8),
          const Text("Mindestbestellung:"),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Slider(
                min: 0,
                max: 50,
                divisions: 100,
                value: filterProvider.minCost,
                onChanged: filterProvider.setMinCost,
              ),
              Card(
                  child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child:
                    Text(NumberFormat("00.00€").format(filterProvider.minCost)),
              )),
            ],
          ),
          const SizedBox(height: 8)
        ],
      ),
    );
  }
}
