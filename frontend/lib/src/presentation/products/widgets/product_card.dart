import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:greendrop/src/domain/models/drug.dart';
import 'package:greendrop/src/domain/models/product.dart';
import 'package:greendrop/src/presentation/products/provider/cart_provider.dart';
import 'package:provider/provider.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final cardWidth =
        MediaQuery.of(context).size.width - 32;
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
      child: Card(
        elevation: 5,
        color: Theme.of(context).colorScheme.surfaceContainer,
        child: IntrinsicHeight(
          child: Row(
            children: [
              ClipRRect(
                borderRadius:
                    const BorderRadius.horizontal(left: Radius.circular(10)),
                child: SizedBox(
                  width: cardWidth * 0.25,
                  height: 120,
                  child: Image.network(
                    "${dotenv.env["API_BASE_URL"]}${product.imageUrl}",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 16, right: 8, top: 8, bottom: 8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      (product.runtimeType == Drug)
                          ? Row(
                              children: [
                                Text(
                                    "THC: ${((product as Drug).thc * 100).toStringAsFixed(0)}%"),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                    "CBD: ${((product as Drug).cbd * 100).toStringAsFixed(0)}%"),
                              ],
                            )
                          : const Row(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                "${product.price.toStringAsFixed(2)}€",
                                style: const TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                              if (product.runtimeType == Drug)
                                const Text(" / g")
                            ],
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Consumer<CartProvider>(
                            builder: (context, cartProvider, child) => Stack(
                              alignment: Alignment.topRight,
                              children: [
                                cartProvider.getProductCountByProduct(product) == 0
                                    ? Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: FilledButton(
                                            onPressed: () => {
                                                  cartProvider
                                                      .addProductToCart(product)
                                                },
                                            child: const Icon(Icons.add)),
                                      )
                                    : Row(
                                        children: [
                                          ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  shape: const CircleBorder(),
                                                  padding: const EdgeInsets.all(8),
                                                  elevation: 5),
                                              onPressed: () => cartProvider
                                                  .removeProductFromCart(product),
                                              child: const Icon(Icons.remove)),
                                          Text(cartProvider
                                              .getProductCountByProduct(product)
                                              .toString()),
                                          ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  shape: const CircleBorder(),
                                                  padding: const EdgeInsets.all(8),
                                                  elevation: 5),
                                              onPressed: () => cartProvider
                                                  .addProductToCart(product),
                                              child: const Icon(Icons.add)),
                                        ],
                                      )
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
