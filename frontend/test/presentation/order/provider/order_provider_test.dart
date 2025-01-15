// test/presentation/order/provider/order_provider_test.dart

import 'dart:async';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:greendrop/src/data/repositories/interfaces/authentication_repository.dart';
import 'package:greendrop/src/data/repositories/interfaces/order_repository.dart';
import 'package:greendrop/src/domain/enums/greendrop_discounts.dart';
import 'package:greendrop/src/domain/enums/payment_methods.dart';
import 'package:greendrop/src/domain/models/address.dart';
import 'package:greendrop/src/domain/models/order_item.dart';
import 'package:greendrop/src/domain/models/shop.dart';
import 'package:greendrop/src/domain/models/user.dart';
import 'package:greendrop/src/presentation/order/provider/order_provider.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

// Generiere Mocks für die benötigten Repositories
@GenerateMocks([IAuthenticationRepository, IOrderRepository])
import 'order_provider_test.mocks.dart';

void main() {
  // Helper-Funktion, um kurz auf asynchrone Vorgänge zu warten.
  Future<void> pumpEventQueue({int milliseconds = 200}) async {
    await Future<void>.delayed(Duration(milliseconds: milliseconds));
  }

  setUpAll(() async {
    await dotenv.load(fileName: ".env");
  });

  group('OrderProvider Tests', () {
    late OrderProvider provider;
    late MockIAuthenticationRepository mockAuthRepo;
    late MockIOrderRepository mockOrderRepo;

    // Beispiel eines generischen Benutzers
    final genericUser = User(
        id: "000",
        userId: "000",
        userDetailId: "000",
        userName: "MaMu",
        firstName: "Max",
        lastName: "Mustermann",
        birthdate: "12-12-2024",
        greenDrops: 1337,
        eMail: "max.musterman@example.com",
        addresses: [
          Address(
              id: "007",
              street: "Beispielstraße",
              streetNumber: "42",
              zipCode: "68163",
              city: "Mannheim",
              isPrimary: true)
        ]);
    ;

    setUp(() {
      // Initialisiere den Provider und die Mocks
      provider = OrderProvider();
      mockAuthRepo = MockIAuthenticationRepository();
      mockOrderRepo = MockIOrderRepository();

      provider.authRepository = mockAuthRepo;
      provider.orderRepository = mockOrderRepo;
    });

    test('Initialwerte sind korrekt', () {
      expect(provider.isLoading, false);
      expect(provider.paymentMethod, PaymentMethods.cash);
      expect(provider.discount, GreendropDiscounts.none);
      expect(provider.selectedAddress, isNull);
      expect(provider.inRange, true);
      expect(provider.user, genericUser);
      expect(provider.order, isNull);
    });

    test('setPaymentMethod(PaymentMethods) setzt _selectedPaymentMethod', () {
      provider.setPaymentMethod(PaymentMethods.cash);
      expect(provider.paymentMethod, PaymentMethods.cash);
    });

    test('setDiscount(int) setzt _selectedDiscount korrekt', () {
      provider.setDiscount(GreendropDiscounts.ten.value);
      expect(provider.discount, GreendropDiscounts.ten);
    });

    test('initializeSelectedAddress() setzt _selectedAddress wenn null', () {
      // ARRANGE: Stelle sicher, dass _selectedAddress null ist
      provider.initializeSelectedAddress();

      // ASSERT
      expect(provider.selectedAddress, equals(genericUser.addresses.first));
    });

    test('getUserDiscountOptions(...) gibt korrekte Discounts zurück', () {
      // ARRANGE
      double totalCoast = 50.0; // totalCoast * 100 = 5000

      // ACT
      final discounts = provider.getUserDiscountOptions(totalCoast).toList();

      // ASSERT
      expect(discounts, [
        GreendropDiscounts.none,
        GreendropDiscounts.one,
        GreendropDiscounts.ten,
      ]);
    });

    test('createOrder(...) => Erfolg (createOrder returns orderId)', () async {
      // ARRANGE
      final shop = Shop(
        id: 'shop002',
        name: 'Another Shop',
        description: 'Another shop for testing',
        address: genericUser.addresses.first,
        rating: 4.0,
        reviewCount: 15,
        minOrder: 25.0,
        deliveryCost: 3.5,
        latitude: 49.492654,
        longitude: 8.471250,
        radius: 10.0,
      );

      final orderItems = [
        OrderItem(
          orderID: '11111',
          totalAmount: 2,
          quantity: 1,
          id: '1234',
          name: 'SmartTV',
          price: 199.99,
          stock: 25,
          category: 'Wearables',
          imageUrl: 'https://example.com/smartTV.jpg',
          description: 'A smartTV with multiple features',
        ),
        OrderItem(
          orderID: '2222',
          totalAmount: 4,
          quantity: 3,
          id: '2345',
          name: 'SmartWatch',
          price: 189.99,
          stock: 24,
          category: 'Wearables',
          imageUrl: 'https://example.com/smartwatch.jpg',
          description: 'A smartwatch with multiple features',
        ),
      ];

      const generatedOrderId = 'order123';

      // Stub: Wenn createOrder aufgerufen wird, gib eine orderId zurück
      when(mockOrderRepo.createOrder(any))
          .thenAnswer((_) async => generatedOrderId);

      // ACT
      runZonedGuarded(() {
        provider.createOrder(shop, orderItems);
      }, (error, stack) {
        // Ignoriere Exceptions (falls welche auftreten)
      });

      await pumpEventQueue();

      // ASSERT
      expect(provider.order?.id, 'order123'); // Da copyWith nicht neu zuweist
      expect(provider.isLoading, false);
    });
  });
}
