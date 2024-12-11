import 'package:flutter/material.dart';
import 'package:greendrop/src/presentation/common_widgets/app_drawer.dart';
import 'package:greendrop/src/presentation/order_history/pages/order_details_page.dart';
import 'package:greendrop/src/presentation/theme/theme_provider.dart';
import 'package:greendrop/src/presentation/order_history/provider/order_history_provider.dart';
import 'package:provider/provider.dart';

class OrderHistoryPage extends StatelessWidget {
  const OrderHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<OrderProvider>(
      create: (context) =>
          OrderProvider(), // Hier wird der Provider initialisiert
      child: Scaffold(
        appBar: AppDrawer.buildGreendropsAppBar(context),
        body: const Center(
          child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: SizedBox(
                      width: double.infinity,
                      height: 60,
                      child: Card(
                        child: Center(
                          child: Text(
                            "Bestellhistorie",
                            style: TextStyle(
                              fontSize: 24,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    // Ändere dies hier, um die Karte zu dehnen
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 8.0),
                      child: Card(
                        child: OrdersList(),
                      ),
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}

class OrdersList extends StatelessWidget {
  const OrdersList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppTheme>(builder: (context, appTheme, child) {
      Color cardColor = Theme.of(context).cardColor;
      return Consumer<OrderProvider>(
        // Daten vom Provider beziehen
        builder: (context, orderProvider, child) {
          if (orderProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (orderProvider.errorMessage != null) {
            return Center(child: Text('Fehler: ${orderProvider.errorMessage}'));
          } else if (orderProvider.orders.isEmpty) {
            return const Center(child: Text('Keine Bestellungen gefunden'));
          } else {
            final orders = orderProvider.orders;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  final order = orders[index];
                  return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical:
                              4.0), // Neue Zeile: Abstand zwischen den Kästen
                      child: InkWell(
                        onTap: () {
                          // Navigation zur Detailseite mit der ausgewählten Bestellung
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  OrderDetailsPage(order: order),
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: cardColor, // Hintergrundfarbe des Containers
                            borderRadius:
                                BorderRadius.circular(8.0), // Abgerundete Ecken
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(
                                8.0), // Innenabstand des Containers
                            child: Row(
                              children: [
                                Image.asset(
                                  'assets/images/default_shop.jpg',
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.cover,
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        order.shop.name,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      // Text(order.date,
                                      //     style: const TextStyle(
                                      //         color: Colors.grey)),
                                    ],
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text("${order.orderItems?.length ?? 0} items"),
                                    Text(
                                      "€${order.orderItems?.map((item) => item.price).reduce((a, b) => a + b).toStringAsFixed(2)}",
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ));
                },
              ),
            );
          }
        },
      );
    });
  }
}


  

