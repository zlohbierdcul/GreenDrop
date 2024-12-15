import 'package:flutter/material.dart';
import 'package:greendrop/src/presentation/common_widgets/app_drawer.dart';
import 'package:greendrop/src/presentation/common_widgets/center_constrained_body.dart';
import 'package:greendrop/src/presentation/order_history/pages/order_details_page.dart';
import 'package:greendrop/src/presentation/theme/theme_provider.dart';
import 'package:greendrop/src/presentation/order_history/provider/order_provider.dart';
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
        body: const CenterConstrainedBody(
          body: Center(
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
                                  order.shopImage,
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
                                        order.shopName,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(order.date,
                                          style: const TextStyle(
                                              color: Colors.grey)),
                                    ],
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text("${order.itemCount} items"),
                                    Text(
                                      "€${order.totalAmount.toStringAsFixed(2)}",
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

class Order {
  final String shopImage;
  final String shopName;
  final String orderReference;
  final String date;
  final int itemCount;
  final double totalAmount;
  final List<OrderItem> items; // Liste von Artikelobjekten

  Order({
    required this.shopImage,
    required this.shopName,
    required this.orderReference,
    required this.date,
    required this.itemCount,
    required this.totalAmount,
    required this.items,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      shopImage: json['products'][0]['imageUrl'],
      shopName: json['name'],
      orderReference: json['id'],
      date: json['date'],
      itemCount: json['products'].length,
      totalAmount: json['products']
          .map<double>((product) => product['price'])
          .reduce((a, b) => a + b),
      items: (json['items'] as List<dynamic>)
          .map((itemData) => OrderItem.fromJson(itemData))
          .toList(),
    );
  }
}

class OrderItem {
  final String name;
  final double price;
  final String imageUrl;
  final String category;

  OrderItem({
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.category,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      name: json['name'],
      price: json['price'].toDouble(),
      imageUrl: json['imageUrl'],
      category: json['category'],
    );
  }
}
