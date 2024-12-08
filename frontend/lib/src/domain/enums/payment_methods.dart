import 'package:flutter/material.dart';

enum PaymentMethods {
  cash("cash", "Bar", null, Icon(Icons.payments)),
  paypal("paypal", null, "assets/images/paypal_logo.png", null);

  final String value;
  final String? label;
  final String? image;
  final Icon? icon;

  const PaymentMethods(this.value, this.label, this.image, this.icon);
}
