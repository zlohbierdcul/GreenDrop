enum SortingModel {
  defaultState("name", "Namen"),
  deliveryCost("deliveryCost", "Lieferkosten"),
  minCost("minCost", "Mindestbestellung"),
  rating("rating", "Bewertung");

  final String value;
  final String label;

  const SortingModel(this.value, this.label);
}
