import 'package:mockito/annotations.dart';
@GenerateMocks([Dio, StrapiAPI])

import 'package:shared_preferences/shared_preferences.dart';
import 'package:greendrop/src/data/repositories/strapi/strapi_authentication_repository.dart';
import 'strapi_authentication_repository_test.mocks.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:dio/dio.dart';
import 'package:greendrop/src/data/db/strapi.db.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  // Lade die .env-Datei

  late StrapiAuthenticationRepository repository;
  late MockDio mockDio;
  late MockStrapiAPI mockApi;

  setUpAll(() async{
    await dotenv.load(fileName: ".env");
    mockDio = MockDio();
    mockApi = MockStrapiAPI();


    // getAuth()
    when(mockApi.getAuth()).thenReturn('Bearer fakeToken');

    // getSignIn()
    when(mockApi.getSignIn()).thenReturn('auth/local');

    // getRegister()
    when(mockApi.getRegister()).thenReturn('auth/local/register');

    // getUser(id) => "/users/$id"
    when(mockApi.getUser(any)).thenAnswer((invocation) {
      final arg = invocation.positionalArguments.first;
      return '/users/$arg';
    });

    // updateUser(user) => '/updateUserURL'
    when(mockApi.updateUser(any)).thenReturn('/updateUserURL');

    // updateAddress(address) => '/updateAddressURL'
    when(mockApi.updateAddress(any)).thenReturn('/updateAddressURL');

    // addAddress() => '/addAddressURL'
    when(mockApi.addAddress()).thenReturn('/addAddressURL');

    // deleteAddress(address) => '/deleteAddressURL'
    when(mockApi.deleteAddress(any)).thenReturn('/deleteAddressURL');

    // connectAddressToUser(userId) => '/connectAddressURL/$userId'
    when(mockApi.connectAddressToUser(any)).thenAnswer((inv) {
      final userId = inv.positionalArguments.first;
      return '/connectAddressURL/$userId';
    });

    // createAddress() => '/createAddressURL'
    when(mockApi.createAddress()).thenReturn('/createAddressURL');

    // createUserDetail() => '/createUserDetailURL'
    when(mockApi.createUserDetail()).thenReturn('/createUserDetailURL');

    // connectUserDetail(userId) => '/connectUserDetail/$userId'
    when(mockApi.connectUserDetail(any)).thenAnswer((inv) {
      final userId = inv.positionalArguments.first;
      return '/connectUserDetail/$userId';
    });

    // getShops() => '/shopsURL'
    when(mockApi.getShops()).thenReturn('/shopsURL');

    // getProductsOfShopById(id) => '/products/$id'
    when(mockApi.getProductsOfShopById(any)).thenAnswer((inv) {
      final id = inv.positionalArguments.first;
      return '/products/$id';
    });

    // getDrugFromId(id) => '/drugs/$id'
    when(mockApi.getDrugFromId(any)).thenAnswer((inv) {
      final id = inv.positionalArguments.first;
      return '/drugs/$id';
    });

    // createOrder() => '/orders'
    when(mockApi.createOrder()).thenReturn('/orders');

    // getUserOrders(userId) => '/users/$userId/orders'
    when(mockApi.getUserOrders(any)).thenAnswer((inv) {
      final userId = inv.positionalArguments.first;
      return '/users/$userId/orders';
    });

    // getUserOrdersBase(userId) => '/someOtherURL'
    when(mockApi.getUserOrdersBase(any)).thenReturn('/someOtherURL');

    // getUserOrdersItems(userId) => '/someItemsURL'
    when(mockApi.getUserOrdersItems(any)).thenReturn('/someItemsURL');

    // getShopById(id) => '/shops/$id'
    when(mockApi.getShopById(any)).thenAnswer((inv) {
      final id = inv.positionalArguments.first;
      return '/shops/$id';
    });

    // getAddressById(id) => '/addresses/$id'
    when(mockApi.getAddressById(any)).thenAnswer((inv) {
      final id = inv.positionalArguments.first;
      return '/addresses/$id';
    });

    // baseUrl => "https://example.com/api"
    when(mockApi.baseUrl).thenReturn('https://example.com/api');

    // -----------------------------
    // STUBS FÜR DIO (falls benötigt)
    // -----------------------------

    // Wenn dein Code dio.post(...) mit bestimmten URL-Patterns aufruft
    // und du immer '200' simulieren willst:
    when(mockDio.post(any, data: anyNamed('data'))).thenAnswer((invocation) async {
      return Response(
        data: {'message': 'fakeResponse'},
        statusCode: 200,
        requestOptions: RequestOptions(path: invocation.positionalArguments.first),
      );
    });

    // Oder du kannst individuell stubs für get(...) / put(...) / delete(...) anlegen,
    // je nachdem, was du in Tests brauchst:
    when(mockDio.get(any)).thenAnswer((invocation) async {
      return Response(
        data: {'message': 'fakeGetResponse'},
        statusCode: 200,
        requestOptions: RequestOptions(path: invocation.positionalArguments.first),
      );
    });

    repository = StrapiAuthenticationRepository();
    repository.dio = mockDio;
    repository.api = mockApi;

    SharedPreferences.setMockInitialValues({});
  });

  group('StrapiAuthenticationRepository Tests', () {
    test('signIn returns true on 200', () async {
      // ARRANGE
      final responseData = {
        "documentId": "ABC",
        "id": "123",
        "user_detail": {
          "documentId": "detail_001",
          "username": "john_doe",
          "first_name": "John",
          "last_name": "Doe",
          "birthdate": "01-01-2000",
          "green_drops": 100,
          "email": "john@example.com",
          "addresses": [
            {
              "documentId": "add1",
              "street": "Main Street",
              "street_no": "6",
              "zip_code": "23456",
              "city": "Mannheim",
              "is_primary": true,
            }
          ]
        },
      };
      // Baue ein Fake-Response
      final fakeResponse = Response(
        data: responseData,
        statusCode: 200,
        requestOptions: RequestOptions(path: ''),
      );

      // Sage mockDio, dass es eine Response mit Status 200 zurückgibt
      when(mockDio.post(any, data: anyNamed('data'))).thenAnswer(
            (_) async => fakeResponse,
      );

      // ACT
      final success = await repository.signIn("test@example.com", "password");

      // ASSERT
      expect(success, true);
      // Prüfe, ob Dio.post() einmal mit passender URL aufgerufen wurde
      verify(mockDio.post(
        argThat(contains('auth/local')),
        data: anyNamed('data'),
      )).called(1);
    });

    test('signIn returns false on non-200', () async {
      // ARRANGE
      final fakeErrorResponse = Response(
        data: {},
        statusCode: 400, // 400 => kein Erfolg
        requestOptions: RequestOptions(path: ''),
      );
      when(mockDio.post(any, data: anyNamed('data')))
          .thenAnswer((_) async => fakeErrorResponse);

      // ACT
      final success = await repository.signIn("wrong@example.com", "password");

      // ASSERT
      expect(success, false);
    });

    test('signOut sets _user to null', () async {
      // Fülle repository._user => signOut soll es null setzen
      repository.signOut();

      // ASSERT
      // Du könntest hier intern _user prüfen, z.B. via
      //expect(repository.getUser(), null);
      //   Aber du bräuchtest ggf. Reflection oder expose _user
      //   Alternativ kannst du Signale checken: ...
    });

    test('fetchUser should parse and store user', () async {
      // ARRANGE
      // Baue ein Fake-Response mit Sample JSON
      final fakeResponse = Response(
        data: {
          "documentId": "ABC",
          "id": "123",
          "user_detail": {
            "documentId": "detail_001",
            "username": "john_doe",
            "first_name": "John",
            "last_name": "Doe",
            "birthdate": "01-01-2000",
            "green_drops": 100,
            "email": "john@example.com",
            "addresses": [
              {
                "documentId": "add1",
                "street": "Main Street",
                "street_no": "6",
                "zip_code": "23456",
                "city": "Mannheim",
                "is_primary": true,
              }
            ]
          }
        },
        statusCode: 200,
        requestOptions: RequestOptions(path: ''),
      );

      when(mockDio.get(any)).thenAnswer((_) async => fakeResponse);

      // ACT
      final user = await repository.fetchUser("123");

      // ASSERT
      expect(user.id, "ABC");
      expect(user.userId, "123");
      expect(user.eMail, "john@example.com");
      verify(mockDio.get(argThat(contains('/users/')))).called(1);
    });

    // Weitere Tests für register, createAddress, createUserDetail etc.
  });
 }
