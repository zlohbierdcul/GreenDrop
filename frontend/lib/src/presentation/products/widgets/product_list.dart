import 'package:flutter/material.dart';
import 'package:greendrop/src/presentation/products/provider/product_provider.dart';
import 'package:greendrop/src/presentation/products/widgets/product_card.dart';
import 'package:provider/provider.dart';

class ProductList extends StatelessWidget {
  const ProductList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(builder: (context, productProvider, child) => (
    (productProvider.productMap.isEmpty) 
      ? const Center(child: CircularProgressIndicator())
      : Consumer<ProductProvider>(
          builder: (context, productProvider, child) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: productProvider.productMap.entries
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
                  .toList()))
    )
    );

  }
}
