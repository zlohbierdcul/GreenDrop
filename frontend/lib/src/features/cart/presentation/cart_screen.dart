import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../domain/cart_provider.dart';
import 'widgets/cart_item_widget.dart';
import 'widgets/total_summery_widget.dart';
import 'widgets/order_type_toggle_widget.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Warenkorb',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ), 
        ),
         
      ),
      body: Padding( 
        padding: const EdgeInsets.all(8.0),
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5.0),
                  child:  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Waren", 
                    style: TextStyle(
                      fontSize: 24, 
                      fontWeight: FontWeight.bold
                      ),
                    ),
                    OrderTypeToggleWidget(),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: cartProvider.clearCart
                    ),
                  ]
                ),
              ),
            Expanded(
              child: ListView.builder(
                itemCount: cartProvider.items.length,
                itemBuilder: (context, index) {
                  final item = cartProvider.items[index];
                  return CartItemWidget(item: item);
                },
              ),
            ),
            TotalSummaryWidget(),
          ],
        ),
      ),
    );
  }

}
