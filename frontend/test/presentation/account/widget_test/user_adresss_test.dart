import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:greendrop/src/data/repositories/interfaces/authentication_repository.dart';
import 'package:greendrop/src/domain/models/address.dart';
import 'package:greendrop/src/domain/models/user.dart';
import 'package:greendrop/src/presentation/account/provider/account_data_provider.dart';
import 'package:greendrop/src/presentation/account/widgets/user_address.dart';
import 'package:provider/provider.dart';

// Ein einfacher Fake-AccountProvider, um das Verhalten zu testen
class FakeAccountProvider extends ChangeNotifier implements AccountProvider {
  bool _isPrimary = false;

  @override
  bool get isPrimary => _isPrimary;

  @override
  void togglePrimary() {
    _isPrimary = !_isPrimary;
    notifyListeners();
  }

  @override
  Future<void> deleteAddress(Address address) async {
    // Hier könntest du einen bool setzen, um zu tracken, dass deleteAddress aufgerufen wurde
  }

  @override
  Future<void> handleAddressEdit(
      GlobalKey<FormState> formKey,
      String street,
      String streetNumber,
      String zipCode,
      String city,
      bool isPrimary,
      Address address,
      ) async {
    // Hier könntest du Felder speichern oder Flags setzen, um das Verhalten zu prüfen
  }

  @override
  late IAuthenticationRepository authRepository;

  @override
  void cancelEditing(BuildContext context) {

  }

  @override
  void changePrimaryAddress() {

  }

  @override
  void fetchUser() {

  }

  @override
  void handleAddressAdd(GlobalKey<FormState> formkey, String street, String streetNumber, String zipCode, String city) {

  }

  @override
  void handleAddressChange(a) {

  }

  @override
  void handleDetailEdit(GlobalKey<FormState> formKey, String userName, String firstName, String lastName, String email) {

  }

  @override
  bool get isEditing => throw UnimplementedError();

  @override
  bool get isLoading => throw UnimplementedError();

  @override
  void loadAccountData() {
  }

  @override
  Address? get selectedAddress => throw UnimplementedError();

  @override
  void setPrimary(bool v) {
  }

  @override
  void signOut() {

  }

  @override
  int sortAddresses(Address a, Address b) {
    throw UnimplementedError();
  }

  @override
  void toggleEditing() {
  }

  @override
  void updateAccount(User newUser) {
  }

  @override
  void updateGreendops(double totalCosts, int discount) {
  }

  @override
  User? get user => throw UnimplementedError();
}

void main() {
  group('UserAddress Widget Tests', () {
    late Address testAddress;
    late FakeAccountProvider fakeProvider;

    setUp(() {
      testAddress = Address(
        id: 'address_1',
        street: 'Main Street',
        streetNumber: '42',
        zipCode: '12345',
        city: 'Berlin',
        isPrimary: false,
      );
      fakeProvider = FakeAccountProvider();
    });

    Widget createTestWidget() {
      return ChangeNotifierProvider<AccountProvider>.value(
        value: fakeProvider,
        child: MaterialApp(
          home: Scaffold(
            body: UserAddress(address: testAddress),
          ),
        ),
      );
    }

    testWidgets('Should display all address information correctly',
            (WidgetTester tester) async {
          await tester.pumpWidget(createTestWidget());

          // Überprüfe, ob die angezeigten Texte vorhanden sind
          expect(find.text('Hauptadresse: '), findsOneWidget);
          expect(find.text('Nein'), findsOneWidget); // testAddress.isPrimary == false

          expect(find.text('Straße: '), findsOneWidget);
          expect(find.text('Main Street'), findsOneWidget);

          expect(find.text('Hausnummer: '), findsOneWidget);
          expect(find.text('42'), findsOneWidget);

          expect(find.text('Postleitzahl: '), findsOneWidget);
          expect(find.text('12345'), findsOneWidget);

          expect(find.text('Stadt: '), findsOneWidget);
          expect(find.text('Berlin'), findsOneWidget);
        });

    testWidgets('Should show delete button when address is not primary',
            (WidgetTester tester) async {
          await tester.pumpWidget(createTestWidget());

          // Da isPrimary = false, sollte der Delete-Button existieren
          final deleteButton = find.byIcon(Icons.delete);
          expect(deleteButton, findsOneWidget);
        });

    testWidgets('Should not show delete button when address is primary',
            (WidgetTester tester) async {
          // Mache Adresse zu isPrimary = true
          testAddress = Address(
            id: 'address_2',
            street: 'Main Street',
            streetNumber: '42',
            zipCode: '12345',
            city: 'Berlin',
            isPrimary: true,
          );

          await tester.pumpWidget(
            ChangeNotifierProvider<AccountProvider>.value(
              value: fakeProvider,
              child: MaterialApp(
                home: Scaffold(
                  body: UserAddress(address: testAddress),
                ),
              ),
            ),
          );

          // Da isPrimary = true, sollte der Delete-Button nicht existieren
          final deleteButton = find.byIcon(Icons.delete);
          expect(deleteButton, findsNothing);
        });

    testWidgets('Should show popup dialog when delete is tapped',
            (WidgetTester tester) async {
          await tester.pumpWidget(createTestWidget());

          // Tippen auf das Icon zum Löschen
          await tester.tap(find.byIcon(Icons.delete));
          await tester.pumpAndSettle();

          // Der AlertDialog sollte erscheinen
          expect(find.text('Addresse löschen?'), findsOneWidget);
          expect(find.text('Sind Sie sich sicher?'), findsOneWidget);
          expect(find.text('Abbrechen'), findsOneWidget);
          expect(find.text('Löschen'), findsOneWidget);
        });

    testWidgets('Should show edit popup when edit icon is tapped',
            (WidgetTester tester) async {
          await tester.pumpWidget(createTestWidget());

          // Tippen auf das Icon zum Bearbeiten
          await tester.tap(find.byIcon(Icons.edit));
          await tester.pumpAndSettle();

          // Überprüfung: AlertDialog sollte erscheinen
          expect(find.text('Persönliche Daten bearbeiten'), findsOneWidget);

          // Die TextFormFields sollten da sein
          expect(find.text('Straße'), findsOneWidget);
          expect(find.text('Hausnummer'), findsOneWidget);
          expect(find.text('Postleitzahl'), findsOneWidget);
          expect(find.text('Stadt'), findsOneWidget);
        });
  });
}
