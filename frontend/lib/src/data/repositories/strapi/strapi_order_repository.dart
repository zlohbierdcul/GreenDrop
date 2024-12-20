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

  // Add authorization token to every request
  StrapiOrderRepository._privateConstructor() {
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        options.headers["Authorization"] = api.getAuth();
        return handler.next(options);
      },
    ));
  }

  static final StrapiOrderRepository _singleton = StrapiOrderRepository._privateConstructor() ;

  factory StrapiOrderRepository() {
    return _singleton;
  }

  @override
  Future<bool> createOrder(Order order) async {
    final data = order.toJson();
    Response response = await dio.put(api.createOrder(), data: {"data": data});
    log.info(response.data);
    return false;
  }

  @override
  Future<List<Order>> getUserOrders(User user) async {
    Response response = await dio.get(api.getUserOrders(user.id));
    try {
      List<dynamic> data = response.data['data'];
      List<Future<Order>> futureOrders = data
          .map((json) => Order.fromJson(json))
          .toList(); //oder auch einfach nur user.id
      return Future.wait(futureOrders);
    } catch (e, stackTrace) {
      log.severe("Fehler beim Abrufen der Benutzerbestellungen", e, stackTrace);
      return [];
    }
  }
}
