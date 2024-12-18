import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:greendrop/src/presentation/products/provider/cart_provider.dart';
import 'package:greendrop/src/presentation/order/pages/order_page.dart';

class TotalSummaryWidget extends StatelessWidget {
  const TotalSummaryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainer,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Zwischensumme:', style: TextStyle(fontSize: 16)),
              Text('€${cartProvider.getTotalCosts().toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 16)),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Lieferkosten:', style: TextStyle(fontSize: 16)),
              Text('€${cartProvider.deliveryCosts.toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 16)),
            ],
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Gesamtbetrag:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Text('€${cartProvider.totalCosts.toStringAsFixed(2)}',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Mögliche GreenDrops:',
                  style: TextStyle(fontSize: 16)),
              Text('${cartProvider.greenDrops}',
                  style: const TextStyle(fontSize: 16)),
            ],
          ),
          if (cartProvider.cart.isNotEmpty) ...[
            Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: FilledButton(
                    onPressed: () => {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      OrderPage(shop: cartProvider.shop)))
                        },
                    child: const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.shopping_cart),
                            SizedBox(width: 20),
                            Text(
                              "Waren bestellen",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                          ],
                        ))))
          ],
        ],
      ),
    );
  }
}
