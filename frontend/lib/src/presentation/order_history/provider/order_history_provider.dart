import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:greendrop/src/data/repositories/interfaces/authentication_repository.dart';
import 'package:greendrop/src/data/repositories/interfaces/order_repository.dart';
import 'package:greendrop/src/data/repositories/strapi/strapi_authentication_repository.dart';
import 'package:greendrop/src/data/repositories/strapi/strapi_order_repository.dart';
import 'package:greendrop/src/domain/models/user.dart';
import 'package:logging/logging.dart';
import 'package:greendrop/src/domain/models/order.dart';

class OrderHistoryProvider with ChangeNotifier {
  Logger log = Logger("OrderHistoryProvider");

  IAuthenticationRepository authRepository = StrapiAuthenticationRepository();
  IOrderRepository orderRepository = StrapiOrderRepository();

  User? _user;
  List<Order> _orders = [];
  bool _isLoading = true;
  String? _errorMessage;

  List<Order> get orders => _orders;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;


  Future<void> init() async {
    _user = authRepository.getUser();
    await loadOrders();
  }

  Future<void> loadOrders() async {
    try {
      _isLoading = true;
      notifyListeners();

      if (_user == null) {
        throw Exception("Kein Benutzer eingeloggt.");
      }

      log.fine("Lade Bestellungen für Benutzer: ${_user!.id}");
      _orders = await orderRepository.getUserOrders(_user!);

      _errorMessage = null;
      log.info("Bestellungen geladen: ${_orders.length}");
    } catch (error) {
      _errorMessage = 'Fehler: $error';
      log.severe("Failed loading user orders: $_errorMessage");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
