
import 'package:greendrop/src/domain/models/order.dart';
import 'package:greendrop/src/domain/models/user.dart';

abstract class IOrderRepository {
  Future<bool> createOrder(Order order);
  Future<List<Order>> getUserOrders(User user);
}