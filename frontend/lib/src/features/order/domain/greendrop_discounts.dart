enum GreendropDiscounts {
  none(0, "Kein Rabat"),
  one(100, "1 Euro Rabat"),
  ten(1000, "10 Euro Rabat"),
  twenty(2000, "20 Euro Rabat");

  final int value;
  final String label;

  const GreendropDiscounts(this.value, this.label);
}
