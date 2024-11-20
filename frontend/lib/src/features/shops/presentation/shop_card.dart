import 'package:flutter/material.dart';
import 'package:greendrop/src/features/shops/data/shop.dart';

class ShopCard extends StatelessWidget {
  final Shop shop;

  const ShopCard({super.key, required this.shop});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final bool isLargeScreen = width > 800;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => print(shop.name),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: isLargeScreen ? 230 : 350,
          ),
          child: isLargeScreen
              ? WebShopCard(shop: shop)
              : MobileShopCard(shop: shop),
        ),
      ),
    );
  }
}

class WebShopCard extends StatelessWidget {
  final Shop shop;

  const WebShopCard({super.key, required this.shop});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          // Image section
          Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
              child: AspectRatio(
                aspectRatio: 3 / 2,
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
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                ShopDetailRow(shop: shop),
                Expanded(child: Container()),
                ShopCostsRow(shop: shop)
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

class MobileShopCard extends StatelessWidget {
  final Shop shop;

  const MobileShopCard({super.key, required this.shop});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Image section
          Flexible(
            flex: 1,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              child: AspectRatio(
                aspectRatio: 8 / 2,
                child: Image.asset(
                  "assets/images/shop1.jpg",
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Flexible(
              child: Padding(
            padding: const EdgeInsets.all(16.0),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              ShopDetailRow(shop: shop),
              Expanded(child: Container()),
              ShopCostsRow(shop: shop)
            ]),
          )),
        ],
      ),
    );
  }
}

class ShopDetailRow extends StatelessWidget {
  final Shop shop;

  const ShopDetailRow({super.key, required this.shop});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final bool isLargeScreen = width > 800;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              shop.name,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Material(
              elevation: 8,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12))),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    const Icon(Icons.star, color: Colors.orange, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      shop.rating.toStringAsFixed(1),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        isLargeScreen
            ? Text(
                shop.description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              )
            : const SizedBox(),
        const SizedBox(height: 16),
        Text(
          "${shop.zipCode} ${shop.city}",
          style: const TextStyle(fontSize: 14, color: Colors.grey),
        ),
        Text(
          "${shop.street} ${shop.streetNumber}",
          style: const TextStyle(fontSize: 14, color: Colors.grey),
        ),
      ],
    );
  }
}

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
