import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:greendrop/src/data/db/strapi.db.dart';
import 'package:dio/dio.dart';

import '../../../domain/models/order.dart';


class OrderProvider with ChangeNotifier {
  StrapiAPI api = StrapiAPI();
  final Dio _dio = Dio();
  List<Order> _orders = [];
  bool _isLoading = true;
  String? _errorMessage;

  List<Order> get orders => _orders;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  OrderProvider() {
    loadOrders();
  }

  Future<void> loadOrders() async {
    try {
      _isLoading = true;
      notifyListeners(); // UI aktualisieren

      final String url = "${dotenv.env['API_BASE_URL']}/api/orders";
      final headers = {
        'Authorization': 'Bearer ${dotenv.env['API_TOKEN']}',
        'Content-Type': 'application/json',
      };


       final response = await _dio.get(url, options: Options(headers: headers));

      if (response.statusCode == 200) {
        final data = response.data['data'] as List<dynamic>;
      // JSON-Daten in Order-Objekte umwandeln
      _orders = data.map((orderData) {
        return Order.fromJson(orderData['attributes']); // Annahme: "attributes" enthält die relevanten Daten
      }).cast<Order>().toList();
      _errorMessage = null;
      } else {
        throw Exception("Fehler beim Laden der Bestelldaten: ${response.statusCode}");
      }
    } catch (error) {
      _errorMessage = 'Fehler: $error';
    } finally {
      _isLoading = false;
      notifyListeners(); // UI aktualisieren
    }
  }
}
