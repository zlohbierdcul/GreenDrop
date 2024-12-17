import '../../../domain/models/cart_item.dart';
import 'package:flutter/services.dart';

class CartRepository {

  Future<dynamic> getData()async{

    String response = await rootBundle.loadString("assets/data/mock-cart.json");

    return response;
  }

}
