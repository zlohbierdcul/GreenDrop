import 'package:dio/dio.dart';
import 'package:greendrop/src/data/db/strapi_db.dart';
import 'package:greendrop/src/data/repositories/interfaces/order_repository.dart';
import 'package:greendrop/src/data/repositories/strapi/strapi_authentication_repository.dart';
import 'package:greendrop/src/domain/models/order.dart';
import 'package:greendrop/src/domain/models/order_item.dart';
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
        options.headers["Authorization"] =
            "Bearer ${StrapiAuthenticationRepository().jwtToken ?? ""}";
        return handler.next(options);
      },
    ));
  }

  static final StrapiOrderRepository _singleton =
      StrapiOrderRepository._privateConstructor();

  factory StrapiOrderRepository() {
    return _singleton;
  }

  Future<String> createOrderItem(OrderItem orderItem) async {
    final data = orderItem.toStrapiJson();
    Response response =
        await dio.post(api.createOrderItem(), data: {"data": data});

    // success
    if (response.statusCode == 201) {
      log.info("CreateOrderItem successful.");
      return response.data["data"]["documentId"];
    }

    log.warning("CreateOrderItem failed.");
    return "";
  }

  @override
  Future<String> createOrder(Order order) async {
    Set<String> orderItemIds = {};

    await Future.forEach(order.orderItems ?? [], (item) async {
      orderItemIds.add(await createOrderItem(item));
    });

    orderItemIds.remove("");

    print(orderItemIds);
    final data = order.toStrapiJson(orderItemIds.toList());
    Response response = await dio.post(api.createOrder(), data: {"data": data});

    // success
    if (response.statusCode == 201) {
      log.info("CreateOrder successful.");
      return response.data["data"]["documentId"];
    }

    log.warning("CreateOrder failed.");
    return "";
  }

  @override
  Future<List<Order>> getUserOrders(User user) async {
    Response baseResponse = await dio.get(api.getUserOrdersBase(user.userId));
    List<dynamic> orders = baseResponse.data['data'];
    if (orders.isEmpty) return [];
    Response itemResponse = await dio.get(api.getUserOrdersItems(user.userId));
    try {
      for (dynamic order in orders) {
        Response shopResponse =
            await dio.get(api.getShopById(order["shop"]["documentId"]));
        Response addressResponse = await dio
            .get(api.getAddressById(order["user_address"]["documentId"]));

        // extract data from response
        order["items"] = itemResponse.data["data"]
            .firstWhere((o) => o["documentId"] == order["documentId"])["items"];
        order["shop"] = shopResponse.data["data"];
        order["user_address"] = addressResponse.data["data"];
      }

      return orders.map((json) => Order.fromJson(json)).toList();
    } catch (e, stackTrace) {
      log.severe("Fehler beim Abrufen der Benutzerbestellungen", e, stackTrace);
      return [];
    }
  }
}
