import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:greendrop/src/domain/models/shop.dart';

class ShopInfo extends StatelessWidget {
  final Shop shop;

  const ShopInfo({super.key, required this.shop});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: kIsWeb ? 4 / 1 : 2 / 1,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      "assets/images/shop1.jpg",
                      fit: BoxFit.cover,
                    )),
              ),
              const SizedBox(height: 16),
              Text(
                shop.name,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Icon(Icons.star, color: Colors.orange, size: 16),
                  const SizedBox(width: 4),
                  Text(
                    shop.rating.toStringAsFixed(1),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 16),
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
                  const SizedBox(width: 16), // Add spacing between them
                  const Icon(
                    Icons.shopping_bag,
                    color: Colors.grey,
                    size: 16,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    "Min: \$${shop.minOrder.toStringAsFixed(2)}",
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  )
                ],
              ),
              const SizedBox(height: 10),
              Text(shop.description),
            ],
          ),
        ),
      ),
    );
  }
}
