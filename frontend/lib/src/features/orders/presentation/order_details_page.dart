import 'package:flutter/material.dart';
import 'orders.dart';

//import '../features/orders/presentation/order_provider.dart';

class OrderDetailsPage extends StatelessWidget {
  final Order order;

  const OrderDetailsPage({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Details Bestellung vom ${order.date}"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              order.shopImage,
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),

            const SizedBox(height: 10),

            Text(
              order.shopName,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              "Bestellnummer: ${order.date}", //TODO: Bestellnummer ändern
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),

            const SizedBox(height: 20),

            const Text(
              "Sie haben folgende Artikel bestellt:",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Expanded(
              child: ListView.builder(
                itemCount: order.items.length,
                itemBuilder: (context, index) {
                  final item = order.items[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Row(
                      children: [
                        Text(
                          '${item.number}.',
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),

                        const SizedBox(width: 10),

                        Expanded(
                          child: Text(
                            item.name,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),

                        Text(
                          "€${item.price.toStringAsFixed(2)}",
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 20),

            Row(
              children: [
                Expanded(
                  child: Container(), // Leerer Container für Platzierung
                ),
                Text(
                  "Bezahlter Gesamtbetrag: €${order.totalAmount.toStringAsFixed(2)}",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.right,
                ),
              ],
            ),
            
            const SizedBox(height: 20),
            
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
