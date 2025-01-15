import 'package:flutter_test/flutter_test.dart';
import 'package:greendrop/src/domain/models/product.dart';
import 'package:greendrop/src/domain/models/shop.dart';
import 'package:greendrop/src/domain/models/address.dart';
import 'package:greendrop/src/presentation/products/provider/cart_provider.dart';
import 'package:greendrop/src/presentation/cart/provider/ordertype_toggle_provider.dart';


void main() {
  group('CartProvider Tests', () {
    late CartProvider cartProvider;
    late OrderTypeToggleProvider orderTypeToggleProvider;

    // Beispiel-Shop zur Verwendung in den Tests
    final exampleShop = Shop(
      id: 'shop001',
      name: 'Test Shop',
      description: 'A shop for testing',
      address: Address(
        id: 'addr001',
        street: 'Test Street',
        streetNumber: '1',
        zipCode: '12345',
        city: 'TestCity',
        isPrimary: true,
      ),
      rating: 4.5,
      reviewCount: 20,
      minOrder: 50.0,
      deliveryCost: 5.0,
      latitude: 49.0,
      longitude: 8.0,
      radius: 10.0,
    );

    // Beispiel-Produkte zur Verwendung in den Tests
    final product1 = Product(
        name: 'Orange',
        price: 1.50,
        stock: 30,
        category: 'Fruits',
        imageUrl: 'https://example.com/orange.jpg',
        description: 'A sweet and tangy orange',
        id: '1234'
    );

    final product2 = Product(
        name: 'Mango',
        price: 3.40,
        stock: 49,
        category: 'Fruits',
        imageUrl: 'https://example.com/mango.jpg',
        description: 'A sweet and tangy mango',
        id: '2345'
    );

    setUp(() {
      // Initialisiere die Mock-OrderTypeToggleProvider
      orderTypeToggleProvider = OrderTypeToggleProvider();

      // Initialisiere den CartProvider und setze die Abhängigkeiten
      cartProvider = CartProvider();
      cartProvider.orderTypeToggle = orderTypeToggleProvider;
      cartProvider.shop = exampleShop;
    });

    test('Initialwerte sind korrekt', () {
      expect(cartProvider.cart, isEmpty);
      expect(cartProvider.orderItems, isEmpty);
      expect(cartProvider.subtotal, 0.0);
      expect(cartProvider.totalCosts, 5.0); // subtotal + deliveryCosts
      expect(cartProvider.deliveryCosts, 5.0);
      expect(cartProvider.isMinOrderMet, false);
      expect(cartProvider.greenDrops, 2); // floor(5.0) ~/ 2 = 2
      expect(cartProvider.shop, equals(exampleShop));
    });

    test('addProductToCart fügt ein Produkt hinzu', () {
      cartProvider.addProductToCart(product1);
      expect(cartProvider.cart.length, 1);
      expect(cartProvider.cart[product1], 1);
      expect(cartProvider.subtotal, 1.5);
      expect(cartProvider.totalCosts, 6.5);
      expect(cartProvider.isMinOrderMet, false);
      expect(cartProvider.greenDrops, 3);
    });

    test('addProductToCart erhöht die Menge bei vorhandenem Produkt', () {
      cartProvider.addProductToCart(product1);
      cartProvider.addProductToCart(product1);
      expect(cartProvider.cart.length, 1);
      expect(cartProvider.cart[product1], 2);
      expect(cartProvider.subtotal, 3.0);
      expect(cartProvider.totalCosts, 8.0);
      expect(cartProvider.isMinOrderMet, false);
      expect(cartProvider.greenDrops, 4);
    });

    test('removeProductFromCart reduziert die Menge', () {
      cartProvider.addProductToCart(product1);
      cartProvider.addProductToCart(product1);
      cartProvider.removeProductFromCart(product1);
      expect(cartProvider.cart[product1], 1);
      expect(cartProvider.subtotal, 1.5);
      expect(cartProvider.totalCosts, 6.5);
      expect(cartProvider.greenDrops, 3);
    });

    test('removeProductFromCart entfernt das Produkt, wenn Menge 1', () {
      cartProvider.addProductToCart(product1);
      cartProvider.removeProductFromCart(product1);
      expect(cartProvider.cart.containsKey(product1), isFalse);
      expect(cartProvider.subtotal, 0.0);
      expect(cartProvider.totalCosts, 5.0);
      expect(cartProvider.greenDrops, 2);
    });

    test('removeProductFromCart tut nichts, wenn Produkt nicht im Warenkorb', () {
      cartProvider.removeProductFromCart(product1);
      expect(cartProvider.cart.containsKey(product1), isFalse);
      expect(cartProvider.cart.length, 0);
      expect(cartProvider.subtotal, 0.0);
      expect(cartProvider.totalCosts, 5.0);
      expect(cartProvider.greenDrops, 2);
    });

    test('getProductCount gibt die Gesamtmenge der Produkte im Warenkorb zurück', () {
      expect(cartProvider.getProductCount(), 0);
      cartProvider.addProductToCart(product1);
      expect(cartProvider.getProductCount(), 1);
      cartProvider.addProductToCart(product2);
      expect(cartProvider.getProductCount(), 2);
      cartProvider.addProductToCart(product1);
      expect(cartProvider.getProductCount(), 3);
    });

    test('getProductCountByProduct gibt die Menge eines spezifischen Produkts zurück', () {
      expect(cartProvider.getProductCountByProduct(product1), 0);
      cartProvider.addProductToCart(product1);
      expect(cartProvider.getProductCountByProduct(product1), 1);
      cartProvider.addProductToCart(product1);
      expect(cartProvider.getProductCountByProduct(product1), 2);
      cartProvider.addProductToCart(product2);
      expect(cartProvider.getProductCountByProduct(product1), 2);
      expect(cartProvider.getProductCountByProduct(product2), 1);
    });

    test('calculateOrderCosts berechnet die Gesamtkosten korrekt', () {
      // ACT & ASSERT
      expect(cartProvider.calculateOrderCosts(exampleShop), 10.0);

      cartProvider.addProductToCart(product1);
      expect(cartProvider.calculateOrderCosts(exampleShop), 11.5);

      cartProvider.addProductToCart(product2);
      expect(cartProvider.calculateOrderCosts(exampleShop), 14.9);
    });

    test('getTotalCosts berechnet die Gesamtsumme der Produkte korrekt', () {
      expect(cartProvider.getTotalCosts(), 0.0);
      cartProvider.addProductToCart(product1);
      expect(cartProvider.getTotalCosts(), 1.5);
      cartProvider.addProductToCart(product2);
      expect(cartProvider.getTotalCosts(), 4.9);
      cartProvider.addProductToCart(product1);
      expect(cartProvider.getTotalCosts(), 6.4 );
    });

    test('toCartItemList konvertiert den Warenkorb korrekt', () {
      cartProvider.addProductToCart(product1);
      cartProvider.addProductToCart(product2);
      cartProvider.addProductToCart(product1);

      final cartItems = cartProvider.toCartItemList();
      expect(cartItems.length, 2);

      final cartItem1 = cartItems.firstWhere((item) => item.product == product1);
      expect(cartItem1.quantity, 2);

      final cartItem2 = cartItems.firstWhere((item) => item.product == product2);
      expect(cartItem2.quantity, 1);
    });

    test('resetCart leert den Warenkorb', () {
      cartProvider.addProductToCart(product1);
      cartProvider.addProductToCart(product2);
      expect(cartProvider.cart.length, 2);

      cartProvider.resetCart();
      expect(cartProvider.cart, isEmpty);
      expect(cartProvider.subtotal, 0.0);
      expect(cartProvider.totalCosts, 5.0);
      expect(cartProvider.greenDrops, 2);
    });

    test('orderItems getter erstellt korrekte OrderItems', () {
      cartProvider.addProductToCart(product1);
      cartProvider.addProductToCart(product2);
      cartProvider.addProductToCart(product1);

      final orderItems = cartProvider.orderItems;
      expect(orderItems.length, 2);

      final orderItem1 = orderItems.firstWhere((item) => item.id == product1.id);
      expect(orderItem1.quantity, 2);
      expect(orderItem1.totalAmount, 3.0);

      final orderItem2 = orderItems.firstWhere((item) => item.id == product2.id);
      expect(orderItem2.quantity, 1);
      expect(orderItem2.totalAmount, 3.4);
    });
  });
}
