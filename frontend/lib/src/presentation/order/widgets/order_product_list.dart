import 'package:flutter/material.dart';
import 'package:greendrop/src/presentation/products/provider/cart_provider.dart';
import 'package:provider/provider.dart';

import '../provider/order_provider.dart';

class OrderProductList extends StatelessWidget {
  const OrderProductList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<CartProvider, OrderProvider>(
      builder: (context, cartProvider, orderProvider, child) => Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Produkte:",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Column(
                children: [
                  ...cartProvider.cart.entries.map((entry) => (Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text("${entry.value.toString()}x "),
                              Text(entry.key.name),
                            ],
                          ),
                          Row(
                            children: [
                              Text("${entry.key.price.toString()}€"),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                  "${(entry.key.price * entry.value).toString()}€")
                            ],
                          ),
                        ],
                      ))),
                  drawRecipe(orderProvider),

                ],
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Gesamter Betrag"),
                      Text("${(cartProvider.getTotalCosts()- orderProvider.discount.value/100).toString()}€")
                    ],
                  )
                ],
          ),
        ),
      ),
    );
  }

  Row drawRecipe(OrderProvider orderProvider) {
    if(orderProvider.discount.value != 0) {
      return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
          const Text("GreenDrop Rabatt"),
          const SizedBox(
          width: 10,
          ),
          Text(
          "${(orderProvider.discount.value/100).toString()}€")]);
    }
    return Row();
  }
}
