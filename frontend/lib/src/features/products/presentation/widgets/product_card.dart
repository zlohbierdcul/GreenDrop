import 'package:flutter/material.dart';
import 'package:greendrop/src/features/products/domain/product.dart';
import 'package:greendrop/src/features/products/presentation/provider/cart_provider.dart';
import 'package:provider/provider.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final cardWidth =
        MediaQuery.of(context).size.width - 32; // Subtract padding.

    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
      child: Card(
        elevation: 5,
        color: Theme.of(context).colorScheme.surfaceContainer,
        child: Row(
          children: [
            ClipRRect(
              borderRadius:
                  const BorderRadius.horizontal(left: Radius.circular(10)),
              child: SizedBox(
                width: cardWidth * 0.25,
                height: 120,
                child: Image.asset(
                  "assets/images/shop1.jpg",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    Text("Ursprung: ${product.origin}"),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${product.price.toStringAsFixed(2)}€",
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        Consumer<CartProvider>(
                          builder: (context, cartProvider, child) => Stack(
                            alignment: Alignment.topRight,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: FilledButton(
                                    onPressed: () => {
                                          //
                                          cartProvider.addProductToCart(product)
                                        },
                                    child: Icon(Icons.add)),
                              ),
                              if (cartProvider
                                      .getProductCountByProduct(product) >
                                  0) ...[
                                Container(
                                  width: 30,
                                  height: 30,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimary,
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Text(
                                    cartProvider
                                        .getProductCountByProduct(product)
                                        .toString(),
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary),
                                  ),
                                )
                              ]
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
