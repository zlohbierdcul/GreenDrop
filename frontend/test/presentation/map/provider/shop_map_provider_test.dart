import 'package:flutter_test/flutter_test.dart';
import 'package:greendrop/src/presentation/map/provider/shop_map_provider.dart';

void main() {
  group('ShopMapProvider Tests (reine Logik, Fehler ignorieren)', () {
    late ShopMapProvider provider;
    setUp(() {
      provider = ShopMapProvider();
    });

    test('Standardwerte sind korrekt', () {
      expect(provider.isZoomedIn, false);
      expect(provider.focusedShop, isNull);
      expect(provider.latitudePerson, 49.492654);
      expect(provider.longitudePerson, 8.471250);
      expect(provider.shops, isEmpty);
      expect(provider.isLoading, true);
      // Da im Code "bool isLoading = true;" steht.
    });

    test('setIsZoomedIn(true) -> isZoomedIn = true', () {
      provider.setIsZoomedIn(true);
      expect(provider.isZoomedIn, true);
    });
  });
}
