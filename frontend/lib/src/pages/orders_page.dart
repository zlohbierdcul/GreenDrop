import 'package:flutter/material.dart';
import '../features/orders/presentation/orders.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bestellungen"),
      ),
      body: const Orders(), 
    );
  }
}
