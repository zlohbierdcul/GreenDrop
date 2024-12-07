import 'package:greendrop/src/domain/models/product.dart';

class Drug extends Product {
  Drug(
      {required super.name,
      required super.price,
      required super.stock,
      required super.category,
      required super.imageUrl,
      required super.description});
}
