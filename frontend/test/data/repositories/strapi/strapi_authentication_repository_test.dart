import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:greendrop/src/data/db/strapi.db.dart';
import 'package:flutter/services.dart';
import 'package:greendrop/src/data/repositories/strapi/strapi_authentication_repository.dart';
import 'package:greendrop/src/domain/models/address.dart';
import 'package:greendrop/src/domain/models/user.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Erzeugt Mock-Klassen zu [Dio] und [StrapiAPI].
@GenerateMocks([Dio, StrapiAPI])
import 'strapi_authentication_repository_test.mocks.dart';

void main() {
  //MethodChannel simulieren, weil Tests in Dart VM laufen
  const MethodChannel secureStorageChannel =
  MethodChannel('plugins.it_nomads.com/flutter_secure_storage');

  TestWidgetsFlutterBinding.ensureInitialized();

  late StrapiAuthenticationRepository repository;
  late MockDio mockDio;
  late MockStrapiAPI mockApi;

  setUpAll(() async {

    // Aktiviert das Test-Framework und holt uns das Binding
    final binding = TestWidgetsFlutterBinding.ensureInitialized();
    // Hier setzen wir den neuen Mock-Handler über defaultBinaryMessenger
    binding.defaultBinaryMessenger.setMockMethodCallHandler(
      secureStorageChannel,
          (MethodCall methodCall) async {
        switch (methodCall.method) {
          case 'write':
          case 'read':
          case 'delete':
          case 'readAll':
          // Einfach irgendeinen Dummy-Wert zurückgeben, damit kein Fehler fliegt.
            return true;
          default:
            return null;
        }
      },
    );

    // Lädt deine .env-Datei (falls notwendig)
    await dotenv.load(fileName: ".env");

    // Erstellt die Mocks
    mockDio = MockDio();
    mockApi = MockStrapiAPI();

    // Stubs für API (Beispiel: getSignIn, getRegister, etc.)
    when(mockApi.getAuth()).thenReturn('Bearer fakeToken');
    when(mockApi.getSignIn()).thenReturn('/auth/local');
    when(mockApi.getRegister()).thenReturn('/auth/local/register');
    when(mockApi.getUser(any)).thenAnswer((inv) {
      final userId = inv.positionalArguments.first;
      return '/users/$userId';
    });
    when(mockApi.updateUser(any)).thenReturn('/updateUserURL');
    when(mockApi.updateAddress(any)).thenReturn('/updateAddressURL');
    when(mockApi.deleteAddress(any)).thenReturn('/deleteAddressURL');
    when(mockApi.addAddress()).thenReturn('/addAddressURL');
    when(mockApi.connectAddressToUser(any)).thenAnswer((inv) {
      final userDetailId = inv.positionalArguments.first;
      return '/connectAddressURL/$userDetailId';
    });
    when(mockApi.createAddress()).thenReturn('/createAddressURL');
    when(mockApi.createUserDetail()).thenReturn('/createUserDetailURL');
    when(mockApi.connectUserDetail(any)).thenAnswer((inv) {
      final userDetailId = inv.positionalArguments.first;
      return '/connectUserDetailURL/$userDetailId';
    });

    when(mockApi.baseUrl).thenReturn('https://example.com/api');

    // Stubs für Dio-Aktionen
    // => Alle .post(...)-Aufrufe geben standardmäßig eine 200er-Response zurück
    when(mockDio.post(any, data: anyNamed('data'), options: anyNamed('options')))
        .thenAnswer((invocation) async {
      return Response(
        data: {'jwt': 'fake_jwt', 'user': {'documentId': 'doc123', 'id': '123'}},
        statusCode: 200,
        requestOptions: RequestOptions(path: invocation.positionalArguments.first),
      );
    });

    when(mockDio.get(any, options: anyNamed('options'))).thenAnswer((_) async {
      return Response(
        data: {
          'documentId': 'ABC',
          'id': '123',
          'user_detail': {
            'documentId': 'detail_001',
            'username': 'john_doe',
            'first_name': 'John',
            'last_name': 'Doe',
            'birthdate': '01-01-2000',
            'green_drops': 100,
            'email': 'john@example.com',
            'addresses': [
              {
                'documentId': 'add1',
                'street': 'Main Street',
                'street_no': '6',
                'zip_code': '23456',
                'city': 'Mannheim',
                'is_primary': true,
              }
            ]
          }
        },
        statusCode: 200,
        requestOptions: RequestOptions(path: ''),
      );
    });

    when(mockDio.put(any, data: anyNamed('data'), options: anyNamed('options')))
        .thenAnswer((_) async {
      return Response(
        data: {'message': 'fakePutResponse'},
        statusCode: 200,
        requestOptions: RequestOptions(path: ''),
      );
    });

    when(mockDio.delete(any, options: anyNamed('options')))
        .thenAnswer((_) async {
      return Response(
        data: {'message': 'fakeDeleteResponse'},
        statusCode: 200,
        requestOptions: RequestOptions(path: ''),
      );
    });

    // Repository instanzieren + Mocks einhängen
    repository = StrapiAuthenticationRepository();
    repository.dio = mockDio;
    repository.api = mockApi;

    // SharedPreferences-Mock initialisieren
    SharedPreferences.setMockInitialValues({});
  });

  tearDownAll(() {
    final binding = TestWidgetsFlutterBinding.ensureInitialized();
    binding.defaultBinaryMessenger
        .setMockMethodCallHandler(secureStorageChannel, null);
  });

  group('StrapiAuthenticationRepository Tests', () {
    test('signIn - erfolgreicher Login (Status 200)', () async {

      // ACT
      final success = await repository.signIn("test@example.com", "secret");

      // ASSERT
      expect(success, true);
      verify(mockDio.post(
        argThat(contains('/auth/local')),
        data: {
          "identifier": "test@example.com",
          "password": "secret",
        },
      )).called(1);
    });

    test('signIn - fehlgeschlagener Login (Status 400)', () async {
      // ARRANGE
      final fakeResponse = Response(
        data: {},
        statusCode: 400,
        requestOptions: RequestOptions(path: '/auth/local'),
      );
      when(mockDio.post(any, data: anyNamed('data')))
          .thenAnswer((_) async => fakeResponse);

      // ACT
      final success = await repository.signIn("wrong@example.com", "wrong");

      // ASSERT
      expect(success, false);
      verify(mockDio.post(
        argThat(contains('/auth/local')),
        data: anyNamed('data'),
      )).called(1);
    });

    test('register - erfolgreicher Fall', () async {
      // 1) Register-Aufruf
      when(mockDio.post(
        argThat(contains('/auth/local/register')),
        data: anyNamed('data'),
      )).thenAnswer((_) async {
        return Response(
          data: {
            'jwt': 'fake_jwt',
            'user': { 'documentId': 'doc123', 'id': '123' },
          },
          statusCode: 200,
          requestOptions: RequestOptions(path: '/auth/local/register'),
        );
      });

      // 2) createAddress-Aufruf
      when(mockDio.post(
        argThat(contains('/createAddressURL')),
        data: anyNamed('data'),
        options: anyNamed('options'),
      )).thenAnswer((_) async {
        return Response(
          data: {
            "data": {"documentId": "addr123"}
          },
          statusCode: 200,
          requestOptions: RequestOptions(path: '/createAddressURL'),
        );
      });

      // 3) createUserDetail-Aufruf
      when(mockDio.post(
        argThat(contains('/createUserDetailURL')),
        data: anyNamed('data'),
        options: anyNamed('options'),
      )).thenAnswer((_) async {
        return Response(
          data: {
            "data": {"documentId": "detail123"}
          },
          statusCode: 200,
          requestOptions: RequestOptions(path: '/createUserDetailURL'),
        );
      });

      // 4) connectUserDetail-Aufruf (PUT)
      when(mockDio.put(
        argThat(contains('/connectUserDetailURL/detail123')),
        data: anyNamed('data'),
        options: anyNamed('options'),
      )).thenAnswer((_) async {
        return Response(
          data: {"message": "connected OK"},
          statusCode: 200,
          requestOptions: RequestOptions(path: '/connectUserDetailURL/detail123'),
        );
      });

      // --- ACT ---
      final success = await repository.register(
        "john_doe",
        "john@example.com",
        "password",
        "John",
        "Doe",
        "01-01-1990",
        "Main Street",
        "12",
        "Mannheim",
        "12345",
      );

      // --- ASSERT ---
      expect(success, true);
    });


    // Prüfen, ob wir "register" aufgerufen haben
      verify(mockDio.post(argThat(contains('/auth/local/register')),
          data: {
            "username": "john_doe",
            "email": "john@example.com",
            "password": "password",
          }))
          .called(1);

      // Prüfen, ob createAddress() aufgerufen wurde
      verify(mockDio.post(argThat(contains('/createAddressURL')),
          data: anyNamed('data'), options: anyNamed('options')))
          .called(1);

      // Prüfen, ob createUserDetail() aufgerufen wurde
      verify(mockDio.post(argThat(contains('/createUserDetailURL')),
          data: anyNamed('data'), options: anyNamed('options')))
          .called(1);

      // Prüfen, ob connectUserDetail(...) aufgerufen wurde
      verify(mockDio.put(
        argThat(contains('/connectUserDetailURL/detail123')),
        data: anyNamed('data'),
        options: anyNamed('options'),
      )).called(1);
    });

    test('addAddress - fügt Adresse hinzu und verknüpft sie', () async {
      // ARRANGE
      final address = Address(
        id: "temp",
        street: "New Street",
        streetNumber: "10",
        zipCode: "99999",
        city: "New City",
      );

      // Wenn addAddress() => '/addAddressURL'
      when(mockDio.post(
        argThat(contains('/addAddressURL')),
        data: anyNamed('data'),
      )).thenAnswer((_) async {
        return Response(
          data: {
            "data": {"documentId": "addrXXX"}
          },
          statusCode: 200,
          requestOptions: RequestOptions(path: '/addAddressURL'),
        );
      });

      // connectAddressToUser(...) -> put
      when(mockDio.put(
        argThat(contains('/connectAddressURL/')),
        data: anyNamed('data'),
      )).thenAnswer((_) async {
        return Response(
          data: {'message': 'connected!'},
          statusCode: 200,
          requestOptions: RequestOptions(path: ''),
        );
      });

      // ACT
      repository.addAddress(address);

      // ASSERT
      await untilCalled(mockDio.post(any, data: anyNamed('data')));

      verify(mockDio.post(
        argThat(contains('/addAddressURL')),
        data: {
          "data": {
            "street": "New Street",
            "street_no": "10",
            "city": "New City",
            "zip_code": "99999",
            "is_primary": null, // falls im Objekt nicht gesetzt
          }
        },
      )).called(1);

      // Dann den connectAddressToUser(...) call
      verify(mockDio.put(
        argThat(contains('/connectAddressURL/')),
        data: {
          "data": {
            "addresses": {
              "connect": ["addrXXX"],
            }
          }
        },
      )).called(1);
    });

    test('deleteAddress - ruft Dio.delete korrekt auf', () async {
      // ARRANGE
      final address = Address(
        id: "addrToDelete",
        street: "Street",
        streetNumber: "1",
        zipCode: "00000",
        city: "TestCity",
      );

      // ACT
      repository.deleteAddress(address);

      // ASSERT
      await untilCalled(mockDio.delete(any));
      verify(mockDio.delete(
        argThat(contains('/deleteAddressURL')),
      )).called(1);
    });

    test('updateUser - führt PUT auf /updateUserURL aus', () async {
      // ARRANGE
      final user = User(
        id: "docId",
        userId: "123",
        userDetailId: "detail_123",
        userName: "tester",
        firstName: "Testy",
        lastName: "McTestface",
        birthdate: "01-01-1990",
        greenDrops: 50,
        eMail: "test@example.com",
        addresses: [],
      );

      // ACT
      repository.updateUser(user);

      // ASSERT
      await untilCalled(mockDio.put(any, data: anyNamed('data')));
      verify(mockDio.put(
        argThat(equals('/updateUserURL')),
        data: {
          "data": {
            "username": "tester",
            "first_name": "Testy",
            "last_name": "McTestface",
            "birthdate": "01-01-1990",
            "green_drops": 50,
            "email": "test@example.com",
            "addresses": [],
          }
        },
      )).called(1);
    });

    test('signOut - setzt User auf null und löscht isLoggedIn aus SharedPreferences', () async {
      // ACT
      repository.signOut();

      // ASSERT
      // signOut() setzt _user = null und ruft prefs.remove("isLoggedIn") auf.
      // Du könntest hier verifizieren, ob "isLoggedIn" wirklich entfernt wurde:
      final prefs = await SharedPreferences.getInstance();
      expect(prefs.containsKey("isLoggedIn"), false);
    });
}
