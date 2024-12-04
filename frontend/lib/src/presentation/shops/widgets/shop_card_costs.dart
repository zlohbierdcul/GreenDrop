import 'package:flutter/material.dart';
import 'package:greendrop/src/domain/models/shop.dart';

class ShopCostsRow extends StatelessWidget {
  final Shop shop;

  const ShopCostsRow({super.key, required this.shop});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Row(
          children: [
            const Icon(
              Icons.local_shipping,
              color: Colors.grey,
              size: 16,
            ),
            const SizedBox(width: 4),
            Text(
              "\$${shop.deliveryCost.toStringAsFixed(2)}",
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
        const SizedBox(width: 16), // Add spacing between them
        Row(
          children: [
            const Icon(
              Icons.shopping_bag,
              color: Colors.grey,
              size: 16,
            ),
            const SizedBox(width: 4),
            Text(
              "Min: \$${shop.minOrder.toStringAsFixed(2)}",
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
      ],
    );
  }
}
