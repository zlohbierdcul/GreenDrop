enum PaymentMethods {
  cash("cash", "Bar"),
  paypal("paypal", "PayPal");

  final String value;
  final String label;

  const PaymentMethods(this.value, this.label);
}
