import 'package:flutter/material.dart';
import 'package:greendrop/src/features/products/domain/product.dart';
import 'package:greendrop/src/features/products/presentation/provider/product_provider.dart';
import 'package:greendrop/src/features/products/presentation/widgets/product_card.dart';
import 'package:provider/provider.dart';

class ShopProductList extends StatelessWidget {
  final List<Product> products;

  const ShopProductList({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(
        builder: (context, productProvider, child) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    "Produkte",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
                ...products.map((p) => ProductCard(product: p))
              ],
            ));
  }
}
