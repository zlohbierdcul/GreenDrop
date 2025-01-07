import 'dart:async';
import 'package:flutter_test/flutter_test.dart';
import 'package:greendrop/src/domain/models/address.dart';
import 'package:greendrop/src/domain/models/user.dart';
import 'package:greendrop/src/presentation/account/provider/user_provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

// Interface, das du mocken willst:
import 'package:greendrop/src/data/repositories/interfaces/authentication_repository.dart';

// Generiere Mocks für IAuthenticationRepository:
@GenerateMocks([IAuthenticationRepository])
import 'user_provider_test.mocks.dart';

void main() {
  // Gruppe für alle UserProvider-Tests
  group('UserProvider Tests', ()
  {
    late UserProvider userProvider;
    late MockIAuthenticationRepository mockAuthRepo;

    // Beispiel-User für mehrere Tests
    final sampleUser = User(
      id: 'doc001',
      userId: 'user001',
      userDetailId: 'detail_001',
      userName: 'johndoe',
      firstName: 'John',
      lastName: 'Doe',
      birthdate: '01-01-2000',
      greenDrops: 100,
      eMail: 'john@example.com',
      addresses: [
        Address(
          id: 'addr1',
          street: 'Main Street',
          streetNumber: '10',
          zipCode: '12345',
          city: 'Mannheim',
          isPrimary: true,
        ),
        Address(
          id: 'addr2',
          street: 'Second Street',
          streetNumber: '20',
          zipCode: '54321',
          city: 'Berlin',
          isPrimary: false,
        ),
      ],
    );

    setUpAll(() async {
      await dotenv.load(fileName: ".env");
    });

    setUp(() {
      mockAuthRepo = MockIAuthenticationRepository();
      userProvider = UserProvider();
      // Injection:
      userProvider.authRepository = mockAuthRepo;
    });

    Future<void> pumpEventQueue() async {
      await Future<void>.delayed(const Duration(milliseconds: 1));
    }

    test('loadAccountData() - lädt User & setzt selectedAddress', () async {
      // ARRANGE
      // Wenn getUser() im Repository aufgerufen wird, soll sampleUser zurückkommen
      when(mockAuthRepo.getUser()).thenReturn(sampleUser);

      // ACT
      userProvider.loadAccountData();

      // ASSERT
      // userProvider.user sollte sampleUser sein
      expect(userProvider.user, equals(sampleUser));
      // Er nimmt die erste Adresse, die isPrimary == true hat
      expect(userProvider.selectedAddress?.id, 'addr1');
      // isLoading sollte nach loadAccountData = false sein
      expect(userProvider.isLoading, false);

      // Hier kannst du noch verifizieren, ob `mockAuthRepo.getUser()` genau 1x aufgerufen wurde:
      verify(mockAuthRepo.getUser()).called(1);
    });

    test('loadAccountData() - kein User vorhanden (null)', () {
      // ARRANGE
      when(mockAuthRepo.getUser()).thenReturn(null);

      // ACT
      userProvider.loadAccountData();

      // ASSERT
      // Wenn getUser() null liefert, passiert nichts
      expect(userProvider.user, isNull);
      expect(userProvider.selectedAddress, isNull);
      // check isLoading => in Code, wenn user==null, wird am Ende isLoading=false gesetzt oder nicht?
      // In deinem Code wird isLoading = false gesetzt
      // => Man könnte also expect(userProvider.isLoading, false) erwarten
      //   ABER in deinem Code steht: "if (_user == null) return;"
      //   => Du siehst also, nach dem return wird isLoading NICHT auf false gesetzt
      //   => dein Code bleibt beim initial _isLoading = true
      //   => Möglicherweise ein Logikfehler - wir testen, was tatsächlich passiert:
      expect(userProvider.isLoading, true);
    });

    test('updateAccount() - setzt _user & ruft updateUser() im Repo auf', () {
      // ARRANGE
      when(mockAuthRepo.updateUser(any)).thenAnswer((_) {});

      final updatedUser = User(
        id: sampleUser.id,
        userId: sampleUser.userId,
        userDetailId: sampleUser.userDetailId,
        userName: 'johndoeUpdated',
        firstName: 'JohnUpdated',
        lastName: sampleUser.lastName,
        birthdate: sampleUser.birthdate,
        greenDrops: sampleUser.greenDrops,
        eMail: sampleUser.eMail,
        addresses: sampleUser.addresses,
      );
      // ACT
      userProvider.updateAccount(updatedUser);

      // ASSERT
      expect(userProvider.user, updatedUser);
      verify(mockAuthRepo.updateUser(updatedUser)).called(1);
    });

    test('toggleEditing() ändert den Wert von _isEditing', () {
      // Anfangs false
      expect(userProvider.isEditing, false);
      userProvider.toggleEditing();
      expect(userProvider.isEditing, true);
      userProvider.toggleEditing();
      expect(userProvider.isEditing, false);
    });

    test('togglePrimary() invertiert _isPrimary', () {
      // Anfangs false
      expect(userProvider.isPrimary, false);
      userProvider.togglePrimary();
      expect(userProvider.isPrimary, true);
    });

    test('setPrimary(true) setzt _isPrimary auf true', () {
      userProvider.setPrimary(true);
      expect(userProvider.isPrimary, true);
    });

    test('signOut() ruft authRepository.signOut() auf, Exception ignorieren', () async{
      // ARRANGE
      when(mockAuthRepo.signOut()).thenAnswer((_) {});

      // ACT
      runZonedGuarded(() {
        userProvider.signOut();
      }, (error, stack) {
        //Exception ignorieren, da navigator null ergibt, und in Widget Tests bereits getestet wird
      });

      // Warte kurz auf das Ende des async Navigator-Aufrufs
      // (wo sonst die Null-Context-Exception hochkommt).
      await pumpEventQueue();


      // ASSERT
      // Trotzdem sicherstellen, dass signOut() im Repository aufgerufen wurde
      verify(mockAuthRepo.signOut()).called(1);
    });

    test('updateGreendops() - erhöht greenDrops und ruft updateAccount', () {
      // ARRANGE
      when(mockAuthRepo.getUser()).thenReturn(sampleUser);
      userProvider.loadAccountData();
      // => userProvider.user = sampleUser

      // Wir stubben updateUser(...) => kein besonderer Return
      when(mockAuthRepo.updateUser(any)).thenAnswer((_) {});

      // ACT
      userProvider.updateGreendops(50.0, 10);
      // totalCosts=50 => (totalCosts ~/2) = 25 => 100 + 25 - discount(10) = 115

      // ASSERT
      // greenDrops sollte um 15 erhöht sein (100 + 25 - 10 = 115)
      expect(userProvider.user?.greenDrops, 115);
      // Und updateAccount(...) => calls updateUser(...) => 1x
      verify(mockAuthRepo.updateUser(any)).called(1);
    });

    test('deleteAddress(...) ruft deleteAddress im Repo auf, Exception ignorieren', () async{
      // ARRANGE
      when(mockAuthRepo.getUser()).thenReturn(sampleUser);
      when(mockAuthRepo.deleteAddress(any)).thenAnswer((_) {});

      userProvider.loadAccountData();

      // ACT
      runZonedGuarded(() {
        userProvider.deleteAddress(sampleUser.addresses.first);
      }, (error, stack) {
        // Hier fängst du asynchron geworfene Exceptions ab,
        // anstatt dass der Test abbricht.
      });

      await pumpEventQueue();

      // ASSERT
      verify(mockAuthRepo.deleteAddress(sampleUser.addresses.first)).called(1);
    });
  });
}
