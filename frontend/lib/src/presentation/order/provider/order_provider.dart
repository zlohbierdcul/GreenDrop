import 'package:flutter/widgets.dart';
import 'package:greendrop/src/data/repositories/interfaces/authentication_repository.dart';
import 'package:greendrop/src/data/repositories/interfaces/order_repository.dart';
import 'package:greendrop/src/data/repositories/strapi/strapi_authentication_repository.dart';
import 'package:greendrop/src/data/repositories/strapi/strapi_order_repository.dart';
import 'package:greendrop/src/domain/enums/greendrop_discounts.dart';
import 'package:greendrop/src/domain/enums/payment_methods.dart';
import 'package:greendrop/src/domain/models/address.dart';
import 'package:greendrop/src/domain/models/order.dart';
import 'package:greendrop/src/domain/models/order_item.dart';
import 'package:greendrop/src/domain/models/shop.dart';
import 'package:greendrop/src/domain/models/user.dart';
import 'package:greendrop/src/presentation/common_widgets/loading_overlay.dart';
import 'package:greendrop/src/presentation/common_widgets/no_swipe_page_route.dart';
import 'package:greendrop/src/presentation/order/pages/order_confirmation_page.dart';
// import 'package:greendrop/src/utils/utils.dart';
import 'package:logging/logging.dart';

class OrderProvider extends ChangeNotifier {
  Logger log = Logger("OrderProvider");

  IAuthenticationRepository authRepository = StrapiAuthenticationRepository();
  IOrderRepository orderRepository = StrapiOrderRepository();

  PaymentMethods _selectedPaymentMethod = PaymentMethods.cash;
  GreendropDiscounts _selectedDiscount = GreendropDiscounts.none;
  Address? _selectedAddress;
  bool _isLoading = false;
  bool _inRange = true;

  final User _user = StrapiAuthenticationRepository().getUser();
  Order? _order;

  // getter
  bool get isLoading => _isLoading;
  PaymentMethods get paymentMethod => _selectedPaymentMethod;
  GreendropDiscounts get discount => _selectedDiscount;
  Address? get selectedAddress => _selectedAddress;
  bool get inRange => _inRange;
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

  void handleAddressChange(BuildContext context, dynamic a, Shop shop) async {
    var overlay = LoadingOverlay();
    _isLoading = true;
    overlay.show(context);
    _selectedAddress = a;
    // This Code is causing a bug, to while the bug is not fixed the address cannot be validated
    // _inRange = await checkInRange(_selectedAddress!, shop);
    _isLoading = false;
    overlay.hide();
    notifyListeners();
  }

  void initializeSelectedAddress() {
    if (_selectedAddress == null) {
      _selectedAddress = user.addresses.firstWhere((a) => a.isPrimary == true);
      notifyListeners();
    }
  }

  Iterable<GreendropDiscounts> getUserDiscountOptions(double totalCoast) {
    return GreendropDiscounts.values.where((discount) =>
        discount.value <= _user.greenDrops &&
        discount.value <= (totalCoast * 100));
  }

  Future<void> createOrder(Shop shop, List<OrderItem> orderItems) async {
    _isLoading = true;
    notifyListeners();

    _order = Order(
        address: _selectedAddress ?? _user.addresses[0],
        status: "pending",
        user: _user,
        shop: shop,
        paymentMethod: _selectedPaymentMethod.value,
        orderItems: orderItems);

    String orderId = await orderRepository.createOrder(_order!);

    _order = _order?.copyWith(id: orderId);

    log.info("Created order: $order");

    _isLoading = false;
    notifyListeners();
  }

  void handleOrder(
      BuildContext context, Shop shop, cartProvider, userProvider) async {
    if (_inRange) {
      await createOrder(shop, cartProvider.orderItems);
      userProvider.updateGreendops(
          cartProvider.getTotalCosts(), discount.value);
      Navigator.of(context).push(
        NoSwipePageRoute(
          builder: (context) => OrderConfirmationPage(
              earnedGreenDrops: cartProvider.getTotalCosts() ~/ 2),
        ),
      );
    }
  }
}
