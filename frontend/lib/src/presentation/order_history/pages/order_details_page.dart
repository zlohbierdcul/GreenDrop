import 'package:flutter/material.dart';
import 'package:greendrop/src/presentation/common_widgets/app_drawer.dart';
import 'package:greendrop/src/presentation/common_widgets/center_constrained_body.dart';
import 'package:greendrop/src/presentation/order_history/pages/order_history_page.dart';
import 'package:provider/provider.dart';
import 'package:greendrop/src/presentation/order_history/provider/order_history_provider.dart';
import 'package:greendrop/src/domain/models/order.dart';

class OrderDetailsPage extends StatelessWidget {
  final Order order;

  const OrderDetailsPage({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Consumer<OrderHistoryProvider>(
      builder: (context, orderProvider, child ) {
        if (orderProvider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (orderProvider.errorMessage != null) {
          return Center(
            child: Text('Fehler: ${orderProvider.errorMessage}'),
          );
        } else if (orderProvider.orders.isEmpty) {
          return const Center(child: Text('Keine Bestellungen gefunden'));
        } else {
          return Scaffold(
            appBar: AppDrawer.buildGreendropsAppBar(context),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: SizedBox(
                        width: double.infinity,
                        height: 60,
                        child: Card(
                          child: Center(
                            child: Text(
                              "Bestellung ${order.id}",
                              style: const TextStyle(
                                fontSize: 24,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Card(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(16.0),
                                  child: Image.asset(
                                    'assets/images/default_shop.jpg',
                                    width: double.infinity,
                                    height: 200,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  order.shop.name,
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  "Bestellnummer: ${order.id}",
                                  style: const TextStyle(
                                      fontSize: 16, color: Colors.grey),
                                ),
                                // Text(
                                //   "Bestelldatum: ${order.date}",
                                //   style: const TextStyle(
                                //       fontSize: 16, color: Colors.grey),
                                // ),
                                const SizedBox(height: 20),
                                const Text(
                                  "Sie haben folgende Artikel bestellt:",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: order.orderItems?.length,
                                  itemBuilder: (context, index) {
                                    final item = order.orderItems![index];
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4.0),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              item.name,
                                              style:
                                                  const TextStyle(fontSize: 16),
                                            ),
                                          ),
                                          Text(
                                            "€${item.price.toStringAsFixed(2)}",
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  children: [
                                    Expanded(
                                      child:
                                          Container(), // Leerer Container für Platzierung
                                    ),
                                    Text(
                                      "Bezahlter Gesamtbetrag: €${order.orderItems!.map((item) => item.price).reduce((a, b) => a + b).toStringAsFixed(2)}",
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.right,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
