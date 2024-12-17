import 'package:dio/dio.dart';
import 'package:greendrop/src/data/db/strapi.db.dart';
import 'package:greendrop/src/data/repositories/interfaces/order_repository.dart';
import 'package:greendrop/src/domain/models/order.dart';
import 'package:greendrop/src/domain/models/user.dart';
import 'package:logging/logging.dart';

class StrapiOrderRepository extends IOrderRepository {
  Logger log = Logger("StrapiOrderRepository");
  Dio dio = Dio();
  StrapiAPI api = StrapiAPI();

  @override
  Future<bool> createOrder(Order order) async {
    final data = order.toJson();
    Response response = await dio.put(api.createOrder(), data: {"data": data});
    log.info(response.data);
    return false;
  }

  @override
  Future<List<Order>> getUserOrders(User user) async {
    try {
      Response response = await dio.get(api.getUserOrders());
      List<dynamic> data = response.data['data'];
      List<Future<Order>> futureOrders = data.map((json) => Order.fromJson(response.data["user"]["id"], json)).toList(); //oder auch einfach nur user.id
      return Future.wait(futureOrders);
    } catch (e, stackTrace) {
      log.severe("Fehler beim Abrufen der Benutzerbestellungen", e, stackTrace);
      return [];
    }
  }
}
