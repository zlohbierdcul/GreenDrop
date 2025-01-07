import 'dart:async';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:greendrop/src/data/repositories/interfaces/authentication_repository.dart';
import 'package:greendrop/src/presentation/login/provider/registration_provider.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'registration_provider_test.mocks.dart';

@GenerateMocks([IAuthenticationRepository])
void main() {
    late RegistrationProvider provider;
    late MockIAuthenticationRepository mockAuthRepo;
  // Kleiner Helper, um kurz auf asynchrone Vorgänge zu warten.
  Future<void> pumpEventQueue() async {
    // 1 ms oder Duration.zero - Hauptsache, wir geben dem async Code Zeit
    await Future<void>.delayed(const Duration(milliseconds: 1));
  }

  setUpAll(() async {
    await dotenv.load(fileName: ".env");
  });

    setUp(() {
      // Für jeden Test eine neue Instanz
      provider = RegistrationProvider();
      mockAuthRepo = MockIAuthenticationRepository();

      // Wir überschreiben das echte Repository durch den Mock
      provider.authenticationRepository = mockAuthRepo;
    });
  group('RegistrationProvider Tests', () {


    test('Initialwerte', () {
      expect(provider.registrationPage, 1);
      expect(provider.isPasswordVisible, false);
      expect(provider.isConfirmPasswordVisible, false);
      expect(provider.isLoading, false);
      expect(provider.registrationSuccessful, false);
    });

    test('nextPage() erhöht _registrationPage', () {
      provider.nextPage();
      expect(provider.registrationPage, 2);
    });

    test('previousPage() verringert _registrationPage', () {
      provider.nextPage();      // 1 -> 2
      provider.nextPage();      // 2 -> 3
      provider.previousPage();  // 3 -> 2
      expect(provider.registrationPage, 2);
    });

    test('togglePasswordVisible() invertiert isPasswordVisible', () {
      expect(provider.isPasswordVisible, false);
      provider.togglePasswordVisible();
      expect(provider.isPasswordVisible, true);
    });

    test('toggleConfirmPasswordVisible() invertiert isConfirmPasswordVisible', () {
      expect(provider.isConfirmPasswordVisible, false);
      provider.toggleConfirmPasswordVisible();
      expect(provider.isConfirmPasswordVisible, true);
    });

    test('registerUser() => Erfolg (true)', () async {
      // ARRANGE
      when(mockAuthRepo.register(
        any, any, any, any, any, any, any, any, any, any,
      )).thenAnswer((_) async => true);

      provider.setUsername('john_doe');
      provider.setEmail('john@example.com');
      provider.setPassword('secret');

      // ACT
      runZonedGuarded(() {
        provider.registerUser(); // nicht awaiten
      }, (error, stack) {
     });

      await pumpEventQueue(); // Warten, bis async Code abgeschlossen ist

      // ASSERT
      verify(mockAuthRepo.register(
        'john_doe',
        'john@example.com',
        'secret',
        '', // firstname
        '', // lastname
        '', // birthdate
        '', // street
        '', // streetNumber
        '', // city
        '', // zipCode
      )).called(1);

      expect(provider.registrationSuccessful, true);
      // registerUser ruft nextPage => page=2
      expect(provider.registrationPage, 2);
      expect(provider.isLoading, false);
    });

    test('registerUser() => Fehlschlag (false)', () async {
      // ARRANGE
      when(mockAuthRepo.register(
        any, any, any, any, any, any, any, any, any, any,
      )).thenAnswer((_) async => false);

      // ACT
      runZonedGuarded(() {
        provider.registerUser();
      }, (error, stack) {
        // Exception ignorieren, falls eine auftreten sollte
      });

      await pumpEventQueue();

      // ASSERT
      verify(mockAuthRepo.register(
        '', '', '', '', '', '', '', '', '', '',
      )).called(1);

      expect(provider.registrationSuccessful, false);
      // nextPage => page=2
      expect(provider.registrationPage, 2);
      expect(provider.isLoading, false);
    });

    test('handleReset() setzt page=1 und alle Felder zurück', () async {
      // ARRANGE: Mach was kaputt
      provider.setUsername('someUser');
      provider.nextPage(); // jetzt page=2

      // ACT
      provider.handleReset();

      // ASSERT
      expect(provider.registrationPage, 1);
      // Und Felder? => wir testen via registerUser, ob leere Strings übergeben werden
      runZonedGuarded(() {
        provider.registerUser();
      }, (error, stack) {});

      await pumpEventQueue();

      verify(mockAuthRepo.register(
        '', '', '', '', '', '', '', '', '', '',
      )).called(1);
    });
  });
}
