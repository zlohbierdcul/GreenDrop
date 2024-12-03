import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'order_details_page.dart';
import '../../../../theme/theme_provider.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                // Ändere dies hier, um die Karte zu dehnen
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Card(
                    child: OrdersList(),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}

class OrdersList extends StatelessWidget {
  final List<Order> orders = [
    Order(
        shopImage: "assets/images/shop1.jpg",
        shopName: "Shop A",
        date: "2024-12-01",
        itemCount: 3,
        totalAmount: 29.99,
        items: [
          OrderItem(number: 1, name: "Artikel 1", price: 9.99),
          OrderItem(number: 2, name: "Artikel 2", price: 10.00),
          OrderItem(number: 3, name: "Artikel 3", price: 10.00),
        ]),
    Order(
        shopImage: "assets/images/shop1.jpg",
        shopName: "Shop B",
        date: "2024-11-24",
        itemCount: 5,
        totalAmount: 49.99,
        items: [
          OrderItem(number: 1, name: "Artikel A", price: 15.00),
          OrderItem(number: 2, name: "Artikel B", price: 10.00),
          OrderItem(number: 3, name: "Artikel C", price: 12.99),
          OrderItem(number: 4, name: "Artikel D", price: 5.00),
          OrderItem(number: 5, name: "Artikel E", price: 7.00),
        ]),
    Order(
        shopImage: "assets/images/shop1.jpg",
        shopName: "Shop B",
        date: "2024-12-28",
        itemCount: 2,
        totalAmount: 49.99,
        items: [
          OrderItem(number: 1, name: "Artikel 1", price: 9.99),
          OrderItem(number: 2, name: "Artikel 2", price: 10.00),
          OrderItem(number: 3, name: "Artikel 3", price: 10.00),
        ]),
    Order(
        shopImage: "assets/images/shop1.jpg",
        shopName: "Shop B",
        date: "2024-11-22",
        itemCount: 1,
        totalAmount: 49.99,
        items: [
          OrderItem(number: 1, name: "Artikel A", price: 15.00),
          OrderItem(number: 2, name: "Artikel B", price: 10.00),
          OrderItem(number: 3, name: "Artikel C", price: 12.99),
          OrderItem(number: 4, name: "Artikel D", price: 5.00),
          OrderItem(number: 5, name: "Artikel E", price: 7.00),
        ]),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<AppTheme>(builder: (context, appTheme, child) {
      Color cardColor = Theme.of(context).cardColor;
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: orders.length,
          itemBuilder: (context, index) {
            final order = orders[index];
            return Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 4.0), // Neue Zeile: Abstand zwischen den Kästen
                child: InkWell(
                  onTap: () {
                    // Navigation zur Detailseite mit der ausgewählten Bestellung
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OrderDetailsPage(order: order),
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  order.shopName,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(order.date,
                                    style: const TextStyle(color: Colors.grey)),
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
    });
  }
}

class Order {
  final String shopImage;
  final String shopName;
  final String date;
  final int itemCount;
  final double totalAmount;
  final List<OrderItem> items; // Liste von Artikelobjekten

  Order({
    required this.shopImage,
    required this.shopName,
    required this.date,
    required this.itemCount,
    required this.totalAmount,
    required this.items,
  });
}

class OrderItem {
  final int number; // Nummer des Artikels
  final String name; // Name des Artikels
  final double price; // Preis des Artikels

  OrderItem({
    required this.number,
    required this.name,
    required this.price,
  });
}
