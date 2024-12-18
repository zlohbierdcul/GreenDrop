enum GreendropDiscounts {
  none(0, "Kein Rabatt"),
  one(100, "100 GreenDrops"),
  ten(1000, "1000 GreenDrops"),
  twenty(2000, "2000 GreenDrops");

  final int value;
  final String label;

  const GreendropDiscounts(this.value, this.label);
}
