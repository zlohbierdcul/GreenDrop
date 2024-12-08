enum GreendropDiscounts {
  none(0, "Kein Rabatt"),
  one(100, "1 Euro Rabatt"),
  ten(1000, "10 Euro Rabatt"),
  twenty(2000, "20 Euro Rabatt");

  final int value;
  final String label;

  const GreendropDiscounts(this.value, this.label);
}
