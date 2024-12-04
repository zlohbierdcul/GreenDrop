import 'package:flutter/widgets.dart';
import 'package:greendrop/src/features/order/domain/greendrop_discounts.dart';
import 'package:greendrop/src/features/order/domain/payment_methods.dart';

class OrderProvider extends ChangeNotifier {
  PaymentMethods _selectedPaymentMethod = PaymentMethods.cash;
  GreendropDiscounts _selectedDiscount = GreendropDiscounts.none;

  PaymentMethods get paymentMethod => _selectedPaymentMethod;

  GreendropDiscounts get discount => _selectedDiscount;

  void setPaymentMethod(PaymentMethods paymentMethod) {
    _selectedPaymentMethod = paymentMethod;
    notifyListeners();
  }

  void setDiscount(int discountValue) {
    _selectedDiscount =
        GreendropDiscounts.values.firstWhere((d) => d.value == discountValue);
    notifyListeners();
  }
}
