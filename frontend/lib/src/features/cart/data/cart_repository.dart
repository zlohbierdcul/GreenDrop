import '../domain/cart_item.dart';
import 'package:flutter/services.dart';

class CartRepository {

  Future<dynamic> getData()async{

    String response = await rootBundle.loadString("assets/data/mock-cart.json");

    return response;
  }
  // Stub for future data fetching or persistence logic
  Future<List<CartItem>> fetchCartItems() async {

    String response = await getData();
    print(response);
    List<CartItem> cartItems = CartItem.parseCartItems(response);
    print("Parsed Items: ${cartItems.length}");
    return cartItems;
  }
}
