import 'package:flutter/material.dart';
import 'package:greendrop/src/features/products/domain/product.dart';
import 'package:greendrop/src/features/products/presentation/provider/product_provider.dart';
import 'package:greendrop/src/features/products/presentation/widgets/product_card.dart';
import 'package:provider/provider.dart';

class ProductList extends StatelessWidget {
  final Map<String, List<Product>> productMap;

  const ProductList({super.key, required this.productMap});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(
        builder: (context, productProvider, child) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: productMap.entries
                .map((entry) => (Padding(
                      padding: const EdgeInsets.only(
                          left: 16.0, top: 16.0, right: 16.0),
                      child: Card(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(16),
                                child: Text(
                                  entry.key,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                              ),
                              ...entry.value.map((p) => ProductCard(product: p))
                            ]),
                      ),
                    )))
                .toList()));
  }
}
