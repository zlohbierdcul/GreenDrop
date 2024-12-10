import 'package:flutter/material.dart';
import 'package:greendrop/src/domain/models/shop.dart';
import 'package:greendrop/src/presentation/products/pages/product_page.dart';

class ShopMapDetails extends StatelessWidget {
  final Shop shop;

  const ShopMapDetails({super.key, required this.shop});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(50.0),
      child: Material(
        borderRadius: BorderRadius.circular(20),
        elevation: 5,
        child: Row(
          children: [
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                ),
                child: AspectRatio(
                  aspectRatio: 1 / 20,
                  child: Image.asset(
                    "assets/images/shop1.jpg",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Flexible(
              fit: FlexFit.tight,
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            shop.name,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.local_shipping,
                                color: Colors.grey,
                                size: 12,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                "\$${shop.deliveryCost.toStringAsFixed(2)}",
                                style: const TextStyle(color: Colors.grey),
                              ),
                              const SizedBox(
                                  width: 12), // Add spacing between them
                              const Icon(
                                Icons.shopping_bag,
                                color: Colors.grey,
                                size: 12,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                "Min: \$${shop.minOrder.toStringAsFixed(2)}",
                                style: const TextStyle(
                                    fontSize: 14, color: Colors.grey),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(Icons.star,
                                  color: Colors.orange, size: 14),
                              const SizedBox(width: 4),
                              Text(
                                shop.rating.toStringAsFixed(1),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${shop.address.zipCode} ${shop.address.city}",
                            style: const TextStyle(
                                fontSize: 14, color: Colors.grey),
                          ),
                          Text(
                            "${shop.address.street} ${shop.address.streetNumber}",
                            style: const TextStyle(
                                fontSize: 14, color: Colors.grey),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ShopPage(shop: shop)));
                              },
                              child: const Text("Zum Shop ->")),
                        ],
                      )
                    ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
