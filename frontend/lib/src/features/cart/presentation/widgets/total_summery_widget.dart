import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../domain/cart_provider.dart';

class TotalSummaryWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Zwischensumme:', style: TextStyle(fontSize: 16)),
              Text('€${cartProvider.subtotal.toStringAsFixed(2)}', style: TextStyle(fontSize: 16)),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Lieferkosten:', style: TextStyle(fontSize: 16)),
              Text('€${cartProvider.deliveryCost.toStringAsFixed(2)}', style: TextStyle(fontSize: 16)),
            ],
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Gesamtbetrag:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Text('€${cartProvider.total.toStringAsFixed(2)}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ],
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Mögliche GreenDrops:', style: TextStyle(fontSize: 16)),
              Text('${cartProvider.greenDrops}', style: TextStyle(fontSize: 16)),
            ],
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              // Bestellung abschließen Logik
            },
            child: Text('Waren bestellen'),
          ),
        ],
      ),
    );
  }
}
