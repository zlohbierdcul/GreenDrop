import 'package:flutter/material.dart';
import 'package:greendrop/src/presentation/products/provider/cart_provider.dart';
import 'package:provider/provider.dart';

class OrderProductList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (context, cartProvider, child) => Card(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
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
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                  "${(entry.key.price * entry.value).toString()}€")
                            ],
                          )
                        ],
                      ))),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Gesamter Betrag"),
                      Text("${cartProvider.getTotalCosts().toString()}€")
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
