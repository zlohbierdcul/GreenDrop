import 'dart:async';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:greendrop/src/data/repositories/interfaces/authentication_repository.dart';
import 'package:greendrop/src/data/repositories/interfaces/order_repository.dart';
import 'package:greendrop/src/domain/models/order.dart';
import 'package:greendrop/src/domain/models/order_item.dart';
import 'package:greendrop/src/domain/models/shop.dart';
import 'package:greendrop/src/domain/models/user.dart';
import 'package:greendrop/src/domain/models/address.dart';
import 'package:greendrop/src/presentation/order_history/provider/order_history_provider.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';


// Generiere Mocks für die benötigten Repositories
@GenerateMocks([IAuthenticationRepository, IOrderRepository])
import 'order_history_provider_test.mocks.dart';

void main() {
  // Helper-Funktion, um kurz auf asynchrone Vorgänge zu warten.
  Future<void> pumpEventQueue({int milliseconds = 100}) async {
    await Future<void>.delayed(Duration(milliseconds: milliseconds));
  }

  group('OrderHistoryProvider Tests', ()
  {
    late OrderHistoryProvider provider;
    late MockIAuthenticationRepository mockAuthRepo;
    late MockIOrderRepository mockOrderRepo;

    // Beispiel eines generischen Benutzers
    final genericUser = User.genericUser;

    setUpAll(() async {
      await dotenv.load(fileName: ".env");
    });

    setUp(() {
      // Initialisiere die Mock-Repositories
      mockAuthRepo = MockIAuthenticationRepository();
      mockOrderRepo = MockIOrderRepository();

      // Stub für getUser() in IAuthenticationRepository
      when(mockAuthRepo.getUser()).thenReturn(genericUser);

      // Initialisiere den Provider mit den Mock-Repositories
      provider = OrderHistoryProvider();

      // Wechsle die echten Repositories zu den Mock-Instanzen
      provider.authRepository = mockAuthRepo;
      provider.orderRepository = mockOrderRepo;
    });

    test('Initialwerte sind korrekt', () {
      expect(provider.isLoading, true); // Initialisierungszustand ist true
      expect(provider.orders, isEmpty);
      expect(provider.errorMessage, isNull);
    });

    test('loadOrders() => Erfolg (getUserOrders gibt Liste zurück)', () async {
      // ARRANGE
      final mockOrders = [
        Order(
          id: 'order1',
          address: genericUser.addresses.first,
          status: 'completed',
          user: genericUser,
          shop: Shop(
            id: 'shop1',
            name: 'Test Shop',
            description: 'Description',
            address: Address(
              id: 'addr1',
              street: 'Street',
              streetNumber: '1',
              zipCode: '12345',
              city: 'City',
              isPrimary: true,
            ),
            rating: 4.5,
            reviewCount: 10,
            minOrder: 20.0,
            deliveryCost: 3.0,
            latitude: 49.0,
            longitude: 8.0,
            radius: 10.0,
          ),
          paymentMethod: 'cash',
          orderItems: [
            OrderItem(
              orderID: 'order001',
              totalAmount: 2,
              quantity: 2,
              id: '1234',
              name: 'Laptop',
              price: 1000.0,
              stock: 5,
              category: 'Electronics',
              imageUrl: 'https://example.com/laptop.jpg',
              description: 'A high-end laptop',
            ),
            OrderItem(
              orderID: 'order002',
              totalAmount: 4,
              quantity: 3,
              id: '2345',
              name: 'Blueberry Kush',
              price: 10.0,
              stock: 5,
              category: 'rauchbar',
              imageUrl: 'https://example.com.jpg',
              description: 'A high you never forget.',
            ),
          ],
        ),
      ];

      // Stub für getUserOrders()
      when(mockOrderRepo.getUserOrders(genericUser))
          .thenAnswer((_) async => mockOrders);

      // ACT
      runZonedGuarded(() {
        provider
            .loadOrders(); // loadOrders erneut aufrufen mit Mock-Repositories
      }, (error, stack) {
        // Ignoriere Exceptions
      });

      await pumpEventQueue();

      // ASSERT
      expect(provider.orders, equals(mockOrders));
      expect(provider.isLoading, false);
      expect(provider.errorMessage, isNull);
    });

    test(
        'loadOrders() => Fehlschlag (getUserOrders wirft Exception)', () async {
      // ARRANGE
      when(mockOrderRepo.getUserOrders(genericUser))
          .thenThrow(Exception('Failed to load orders'));


      provider.loadOrders(); // loadOrders erneut aufrufen mit Mock-Repositories


      await pumpEventQueue();

      // ASSERT
      expect(provider.orders, isEmpty);
      expect(provider.isLoading, false);
      expect(provider.errorMessage, 'Fehler: Exception: Failed to load orders');
    });
  });
}
