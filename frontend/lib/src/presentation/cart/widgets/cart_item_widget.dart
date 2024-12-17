import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../products/provider/cart_provider.dart';
import '../../../domain/models/cart_item.dart';

class CartItemWidget extends StatelessWidget {
  final CartItem item;

  const CartItemWidget({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
  

   return Card(
      child: SizedBox(
        height: 100,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  item.product.name,
                  style: const TextStyle(fontSize: 16.0),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all((8.0)),
                child:Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Text(
                        '${(item.product.price * item.quantity).toStringAsFixed(2)} €',
                        style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    CartItemQuantityToggleWidget(item: item),
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


class CartItemQuantityToggleWidget extends StatelessWidget {
  final CartItem item;

  const CartItemQuantityToggleWidget({Key? key, required this.item}) : super(key: key);

  Widget build(BuildContext context){
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    return Container(
      child: Row(
        children:[
          IconButton(
            onPressed: () {
              cartProvider.removeProductFromCart(item.product);
            }, 
            icon: const Icon(Icons.remove)
          ),
          Text('${item.quantity}'),
          IconButton(
            onPressed: () {
              cartProvider.addProductToCart(item.product);
            }, 
            icon: const Icon(Icons.add)
          ),
        ],
      ),
    );
  }
}