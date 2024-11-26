import 'package:flutter/material.dart';

import '../features/orders/presentation/order_provider.dart';

class OrderDetailsPage extends StatelessWidget {
  final Order order;

  const OrderDetailsPage({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Details zu ${order.shopName}"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Shop: ${order.shopName}", style: Theme.of(context).textTheme.titleMedium),
            Text("Bestelldatum: ${order.date}", style: Theme.of(context).textTheme.bodySmall),
            const SizedBox(height: 16),
            Text("Artikelanzahl: ${order.itemCount}"),
            Text("Gesamtbetrag: €${order.totalAmount.toStringAsFixed(2)}"),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Zurück zur Bestellliste
              },
              child: const Text("Zurück"),
            )
          ],
        ),
      ),
    );
  }
}
