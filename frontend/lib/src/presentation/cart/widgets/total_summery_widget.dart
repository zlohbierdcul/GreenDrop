import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:greendrop/src/presentation/products/provider/cart_provider.dart';
import 'package:greendrop/src/presentation/order/pages/order_page.dart';

class TotalSummaryWidget extends StatelessWidget {
  const TotalSummaryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    const double maxPadding = 16;
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainer,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16), bottom: Radius.circular(16.0)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
         AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return FadeTransition(opacity: animation, child: SizeTransition(sizeFactor: animation, axisAlignment: -1.0, child: child));
              },
              child: !cartProvider.isMinOrderMet ? 
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: maxPadding),
                  color: Theme.of(context).colorScheme.errorContainer,
                    child: Text(
                      "Der Mindestbestellwert von ${cartProvider.minOrder.toStringAsFixed(2)}€ wurde nicht erreicht.",
                      style: TextStyle(color: Theme.of(context).colorScheme.error),
                    )
                )
                    : const SizedBox.shrink(),
              ),
          Padding(padding: EdgeInsets.all(maxPadding),
          child: Column(
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
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: FilledButton(
                onPressed: () {
                  cartProvider.isMinOrderMet ? 
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                OrderPage(shop: cartProvider.shop))): null;
                },
                child: const Padding(
                  padding: EdgeInsets.all(maxPadding),
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
                  )
                )
              )
            )
          ],
          ))
        ],
      ),
    );
  }
}
