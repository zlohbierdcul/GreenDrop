import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:greendrop/src/data/repositories/interfaces/shop_repository.dart';
import 'package:greendrop/src/domain/models/address.dart';
import 'package:greendrop/src/domain/models/product.dart';
import 'package:greendrop/src/domain/models/shop.dart';
import 'package:greendrop/src/presentation/products/provider/product_provider.dart';
import 'package:mockito/annotations.dart';
import 'product_provider_test.mocks.dart';

@GenerateMocks([IShopRepository])
void main() {
  late ProductProvider provider;
  late MockIShopRepository mockShopRepository;

  Future<void> pumpEventQueue({int milliseconds = 200}) async {
    await Future<void>.delayed(Duration(milliseconds: milliseconds));
  }

  setUpAll(() async {
    await dotenv.load(fileName: ".env");
  });

  setUp(() {
    provider = ProductProvider();
    mockShopRepository = MockIShopRepository();

    provider.repository = mockShopRepository;
  });

  group('ProductProvider Tests', () {
    final shop = Shop(
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
      reviewCount: 10,
      minOrder: 20.0,
      deliveryCost: 3.0,
      latitude: 49.0,
      longitude: 8.0,
      radius: 10.0,
    );

    final products = [
      Product(
        id: 'prod001',
        name: 'Product 1',
        description: 'Description 1',
        price: 10.0,
        category: 'Category A',
        stock: 100,
        imageUrl: 'https://example.com/prod1.jpg',
      ),
      Product(
        id: 'prod002',
        name: 'Product 2',
        description: 'Description 2',
        price: 15.0,
        category: 'Category B',
        stock: 50,
        imageUrl: 'https://example.com/prod2.jpg',
      ),
      Product(
        id: 'prod003',
        name: 'Product 3',
        description: 'Description 3',
        price: 20.0,
        category: 'Category A',
        stock: 30,
        imageUrl: 'https://example.com/prod3.jpg',
      ),
    ];

    test('Initialwerte sind korrekt', () {
      expect(provider.productMap, isEmpty);
    });

    test('clearProducts() leert _productMap und benachrichtigt Listener', () {
      // ARRANGE: Setze _productMap auf eine nicht-leere Map
      provider.setShopProducts(products);
      expect(provider.productMap, isNotEmpty);

      // ACT: Rufe clearProducts auf
      bool notified = false;
      provider.addListener(() {
        notified = true;
      });
      provider.clearProducts();

      // ASSERT
      expect(provider.productMap, isEmpty);
      expect(notified, isTrue);
    });

    test('setShopProducts() gruppiert Produkte nach Kategorie und benachrichtigt Listener', () {
      // ARRANGE: Definiere erwartetes Ergebnis
      final expectedMap = {
        'Category A': [
          products[0],
          products[2],
        ],
        'Category B': [
          products[1],
        ],
      };

      // ACT: Rufe setShopProducts auf
      bool notified = false;
      provider.addListener(() {
        notified = true;
      });
      provider.setShopProducts(products);

      // ASSERT
      expect(provider.productMap, equals(expectedMap));
      expect(notified, isTrue);
    });

    test('loadShopProducts() lädt Produkte vom Repository, gruppiert sie und benachrichtigt Listener', () async {
      // ARRANGE: Mock die getAllShopProducts-Methode
      when(mockShopRepository.getAllShopProducts(any)).thenAnswer((_) async => products);

      // Definiere das erwartete gruppierte Map
      final expectedMap = {
        'Category A': [
          products[0],
          products[2],
        ],
        'Category B': [
          products[1],
        ],
      };

      // ACT: Rufe loadShopProducts auf
      bool notified = false;
      provider.addListener(() {
        notified = true;
      });

      provider.loadShopProducts(shop);

      await pumpEventQueue();

      // ASSERT
      expect(provider.productMap, equals(expectedMap));
      expect(notified, isTrue);
      verify(mockShopRepository.getAllShopProducts(shop.id)).called(1);
    });

    test('loadShopProducts() behandelt leere Produktliste korrekt', () async {
      // ARRANGE: Mock die getAllShopProducts-Methode mit einer leeren Liste
      when(mockShopRepository.getAllShopProducts(shop.id)).thenAnswer((_) async => []);

      // ACT: Rufe loadShopProducts auf
      bool notified = false;
      provider.addListener(() {
        notified = true;
      });
      provider.loadShopProducts(shop);

      await pumpEventQueue();

      // ASSERT
      expect(provider.productMap, isEmpty);
      expect(notified, isTrue);
      verify(mockShopRepository.getAllShopProducts(shop.id)).called(1);
    });
  });
}
