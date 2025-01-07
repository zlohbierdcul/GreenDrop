import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:greendrop/src/presentation/cart/provider/ordertype_toggle_provider.dart';

void main() {
  group('OrderTypeToggleProvider Tests', () {
    late OrderTypeToggleProvider provider;

    setUp(() {
      // Vor jedem Test eine neue Instanz
      provider = OrderTypeToggleProvider();
    });

    test('Initialwert ist false', () {
      expect(provider.isToggled, false);
    });

    test('toggle() wechselt von false auf true', () {
      provider.toggle();
      expect(provider.isToggled, true);
    });

    test('toggle() wechselt von true auf false', () {
      // Erstes toggle() => true
      provider.toggle(); // false -> true
      // Zweites toggle() => false
      provider.toggle(); // true -> false
      expect(provider.isToggled, false);
    });

    test('setToggle(bool) setzt direkt den Wert', () {
      provider.setToggle(true);
      expect(provider.isToggled, true);

      provider.setToggle(false);
      expect(provider.isToggled, false);
    });

    test('currentIcon gibt korrektes Icon zurück (restaurant/delivery)', () {
      // Anfangs isToggled = false => Icons.restaurant
      expect(provider.currentIcon, Icons.restaurant);

      provider.toggle();
      // Jetzt isToggled = true => Icons.delivery_dining
      expect(provider.currentIcon, Icons.delivery_dining);
    });
  });
}
