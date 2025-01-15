import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:greendrop/src/data/repositories/interfaces/shop_repository.dart';
import 'package:greendrop/src/domain/models/product.dart';
import 'package:greendrop/src/presentation/products/provider/product_provider.dart';
import 'package:mockito/annotations.dart';
import 'product_provider_test.mocks.dart';

@GenerateMocks([IShopRepository])
void main() {
  late ProductProvider provider;
  late MockIShopRepository mockShopRepository;


  setUpAll(() async {
    await dotenv.load(fileName: ".env");
    provider = ProductProvider();
    mockShopRepository = MockIShopRepository();

    provider.repository = mockShopRepository;
  });

  group('ProductProvider Tests', () {

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

  });
}
