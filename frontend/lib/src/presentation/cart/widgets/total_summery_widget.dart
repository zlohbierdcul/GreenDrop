import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:greendrop/src/presentation/products/provider/cart_provider.dart';
import 'package:greendrop/src/presentation/order/pages/order_page.dart';


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
              Text('€${cartProvider.getTotalCosts().toStringAsFixed(2)}', style: TextStyle(fontSize: 16)),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Lieferkosten:', style: TextStyle(fontSize: 16)),
              Text('€${cartProvider.deliveryCosts.toStringAsFixed(2)}', style: TextStyle(fontSize: 16)),
            ],
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Gesamtbetrag:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Text('€${cartProvider.totalCosts.toStringAsFixed(2)}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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
             Navigator.push(context, MaterialPageRoute(builder: (context) => OrderPage(shop: cartProvider.shop)));
            },
            child: Text('Waren bestellen'),
          ),
        ],
      ),
    );
  }
}
