import 'package:dio/dio.dart';
import 'package:greendrop/src/data/db/strapi.db.dart';
import 'package:greendrop/src/data/repositories/interfaces/order_repository.dart';
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
        options.headers["Authorization"] = api.getAuth();
        return handler.next(options);
      },
    ));
  }

  static final StrapiOrderRepository _singleton =
      StrapiOrderRepository._privateConstructor();

  factory StrapiOrderRepository() {
    return _singleton;
  }

  Future<String> createOrderItem(OrderItem orderItem) async{
    final data = orderItem.toStrapiJson();
    Response response = await dio.post(api.createOrderItem(), data: {"data": data});
    
    if(response.statusCode == 201){
      log.info(response.data);
      return response.data["data"]["documentId"];
    }
    
    log.warning(response.data);
    return "";

  }
  Future<String> createOrder(Order order) async {
    Set<String> _orderItemIds = {};
    
    await Future.forEach(order.orderItems ?? [] , (item) async{
      String itemId = await createOrderItem(item);
      _orderItemIds.add(itemId);
    } );

    _orderItemIds.remove("");
    final data = order.toStrapiJson(_orderItemIds.toList());
    Response response = await dio.post(api.createOrder(), data: {"data": data});
    log.info(response.data);

        if(response.statusCode == 201){
      log.info(response.data);
      return response.data["data"]["documentId"];
    }
    
    log.warning(response.data);
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
