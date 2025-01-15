import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:greendrop/src/domain/models/shop.dart';
import 'package:greendrop/src/domain/models/address.dart';
import 'package:greendrop/src/presentation/order/provider/order_provider.dart';
import 'package:greendrop/src/presentation/common_widgets/dropdown.dart';
import 'package:greendrop/src/domain/models/user.dart';
import 'package:greendrop/src/presentation/order/widgets/address_selector.dart';

class MockOrderProvider extends Mock implements OrderProvider {
  User _mockUser = User.genericUser;
  @override
  get user => _mockUser;

  get addresses => _mockUser.addresses;
  
  @override
  get selectedAddress => addresses.first;

  set user (User user){
    _mockUser = user;
  }
  

  
  @override
  void handleAddressChange(BuildContext? context, dynamic address,Shop? shop){
    
  }
}

void main() {
  late MockOrderProvider mockOrderProvider;
  late Shop mockShop;
  late List<Address> addresses;
  late User mockUser;

  setUp(() {
    final shopAddress = Address(
      id: "3",
      zipCode: "68193",
      city: "Mannheim",
      street: "Luisenring",
      streetNumber: "5",
    );
    mockShop = Shop(
      reviewCount: 100,
      rating: 4.0,
      address: shopAddress,
      id: "1",
      name: "420 Vibes",
      radius: 10,
      minOrder: 12.00,
      deliveryCost: 1.00,
      description: "Test Shop",
      latitude: 47,
      longitude: 8,
    );

    addresses = [
      Address(
        id: '1',
        street: 'Main Street',
        streetNumber: '123',
        zipCode: '123456',
        city: 'Test City',
        isPrimary: true,
      ),
      Address(
        id: '2',
        street: 'Second Street',
        streetNumber: '456',
        zipCode: '123456',
        city: 'Another City',
        isPrimary: false,
      ),
    ];

    mockUser = User(
      id: User.genericUser.id,
      userId:User.genericUser.userId,
      userDetailId: "detail_1",
      userName: "Test User",
      firstName: "Testie",
      lastName: "User",
      birthdate: User.genericUser.birthdate,
      greenDrops: 1000,
      eMail: "test@user.com",
      addresses: addresses,
    );

    mockOrderProvider = MockOrderProvider();
    mockOrderProvider.user = mockUser;
    print(mockUser);
  });
  group(description, body)
  testWidgets('Displays addresses in the dropdown', (WidgetTester tester) async {
    // Act
    await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider<OrderProvider>.value(
          value: mockOrderProvider,
          child: Scaffold(
            body: SingleChildScrollView(
              child: AddressSelector(shop: mockShop),
            ),
          ),
        ),
      ),
    );


    

    
    final addressSelectorFinder = find.byKey(Key("addressSelector"));

    print(addressSelectorFinder);

    await tester.tap(find.byType(CustomDropdownButton));
    await tester.pumpAndSettle();

    print(find.descendant(of: addressSelectorFinder, matching: find.byType(DropdownMenuItem)));
    print(mockOrderProvider.user.addresses);
    // Assert
    expect(find.byKey(Key("addressSelector")), findsOneWidget);
    expect(find.text("${addresses[0].street} ${addresses[0].streetNumber}, ${addresses[0].city}"), findsAny);
      });
}
