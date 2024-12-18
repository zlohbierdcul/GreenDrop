import 'package:flutter/widgets.dart';
import 'package:greendrop/src/data/repositories/interfaces/authentication_repository.dart';
import 'package:greendrop/src/data/repositories/interfaces/order_repository.dart';
import 'package:greendrop/src/data/repositories/strapi/strapi_authentication_repository.dart';
import 'package:greendrop/src/data/repositories/strapi/strapi_order_repository.dart';
import 'package:greendrop/src/domain/enums/greendrop_discounts.dart';
import 'package:greendrop/src/domain/enums/payment_methods.dart';
import 'package:greendrop/src/domain/models/order.dart';
import 'package:greendrop/src/domain/models/order_item.dart';
import 'package:greendrop/src/domain/models/shop.dart';
import 'package:greendrop/src/domain/models/user.dart';
import 'package:greendrop/src/domain/models/address.dart';
import 'package:logging/logging.dart';

class OrderProvider extends ChangeNotifier {
  Logger log = Logger("OrderProvider");

  IAuthenticationRepository authRepository = StrapiAuthenticationRepository();
  IOrderRepository orderRepository = StrapiOrderRepository();
  Order? _order;

  bool _isLoading = false;

  PaymentMethods _selectedPaymentMethod = PaymentMethods.cash;
  GreendropDiscounts _selectedDiscount = GreendropDiscounts.none;
  final User _user =
      StrapiAuthenticationRepository().getUser() ?? User.genericUser;

  bool get isLoading => _isLoading;
  PaymentMethods get paymentMethod => _selectedPaymentMethod;
  GreendropDiscounts get discount => _selectedDiscount;
  User get user => _user;
  Order? get order => _order;

  void setPaymentMethod(PaymentMethods paymentMethod) {
    _selectedPaymentMethod = paymentMethod;
    notifyListeners();
  }

  void setDiscount(int discountValue) {
    _selectedDiscount =
        GreendropDiscounts.values.firstWhere((d) => d.value == discountValue);
    notifyListeners();
  }

  Iterable<GreendropDiscounts> getUserDiscountOptions() {
    return GreendropDiscounts.values
        .where((discount) => discount.value <= _user.greenDrops);
  }

  void createOrder(Shop shop, List<OrderItem> orderItems) async {
    _isLoading = true;
    notifyListeners();
    log.fine(_user.addresses);
    _order = Order(
        address: _user.addresses[0],
        status: "pending",
        user: _user,
        shop: shop,
        paymentMethod: _selectedPaymentMethod.value,
        orderItems: orderItems);
    await orderRepository.createOrder(_order!);

    log.info("Order $order");
    
    _isLoading = false;
    notifyListeners();
  }
}
