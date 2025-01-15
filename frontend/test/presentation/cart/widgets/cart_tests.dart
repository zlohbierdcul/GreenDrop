import 'package:flutter_test/flutter_test.dart';
import 'package:greendrop/src/domain/models/cart_item.dart';
import 'package:greendrop/src/presentation/cart/widgets/cart_item_widget.dart';
import 'package:greendrop/src/presentation/cart/widgets/total_summery_widget.dart';
import 'package:greendrop/src/presentation/products/provider/cart_provider.dart';
import 'package:mockito/mockito.dart';

import 'package:provider/provider.dart';
import '../../cart/provider/mock_cart_provider.dart';
import 'package:flutter/material.dart';


void main() {

  late MockCartProvider mockCartProvider;
  late CartItem item;

  setUp(() {
    mockCartProvider = MockCartProvider();
    
    var entry =  mockCartProvider.cart.entries.first;
    item = CartItem(product: entry.key, quantity: entry.value);
    


  });
  group('CartItemWidget Tests', () {

    testWidgets("widget is being displayed", (WidgetTester tester) async {
         await tester.pumpWidget(
        MaterialApp(
        home: ChangeNotifierProvider<CartProvider>.value(
          value: mockCartProvider,
          child: Scaffold(
            body: SingleChildScrollView(
              child: CartItemWidget(item: item),
            ),
          ),
        ),
      ),
    );

    expect(find.byType(CartItemWidget), findsOne);
  });
    testWidgets('displays item details correctly', (WidgetTester tester) async {
      
      await tester.pumpWidget(
        MaterialApp(
        home: ChangeNotifierProvider<CartProvider>.value(
          value: mockCartProvider,
          child: Scaffold(
            body: SingleChildScrollView(
              child: CartItemWidget(item: item),
            ),
          ),
        ),
      ),
    );

      Finder cartItemWidget = find.byType(CartItemWidget);
      Finder quantitytoggler = find.byType(CartItemQuantityToggleWidget);

      expect(quantitytoggler, findsOneWidget);
      expect(find.descendant(of: cartItemWidget, matching: find.text('${item.product.name}')), findsOne);
      expect(find.descendant(of: cartItemWidget, matching: find.text('${item.product.price} €')), findsOne);
      expect(find.descendant(of: quantitytoggler, matching: find.text('${item.quantity}')), findsOne);
      expect(find.descendant(of: quantitytoggler, matching: find.byIcon(Icons.add)), findsOne);
    });

    testWidgets('increases quantity on "+" button tap', (WidgetTester tester) async {
      int initialQuantity = item.quantity;
      await tester.pumpWidget(
        MaterialApp(
        home: ChangeNotifierProvider<CartProvider>.value(
          value: mockCartProvider,
          child: Scaffold(
            body: SingleChildScrollView(
              child: CartItemWidget(item: item),
            ),
          ),
        ),
      ),
    );
      
      Finder quantityToggler = find.byType(CartItemQuantityToggleWidget);
      Finder addButton = find.descendant(of: quantityToggler, matching: find.byIcon(Icons.add));

      item.quantity = initialQuantity+1;
      await tester.pumpWidget(
        MaterialApp(
        home: ChangeNotifierProvider<CartProvider>.value(
          value: mockCartProvider,
          child: Scaffold(
            body: SingleChildScrollView(
              child: CartItemWidget(item: item),
            ),
          ),
        ),
      ),
    );

      print(addButton);
      await tester.tap(addButton);
      await tester.pumpAndSettle();

      print(mockCartProvider.cart.entries.first);

      expect(find.descendant(of: quantityToggler, matching: find.text('${initialQuantity+1}')), findsOne);
    });

    testWidgets('display correct amount of items as list', (WidgetTester tester) async {
      int initialQuantity = 2;
      item.quantity = initialQuantity;

      await tester.pumpWidget(
        MaterialApp(
        home: ChangeNotifierProvider<CartProvider>.value(
          value: mockCartProvider,
          child: Scaffold(
            body: Expanded(
              child: ListView.builder(
                itemCount: mockCartProvider.toCartItemList().length,
                itemBuilder: (context, index) => CartItemWidget(item: mockCartProvider.toCartItemList()[index])
                ),
              ),
            ),
          ),
        ),
    );

      Finder cartItemWidget = find.byType(CartItemWidget);

      await tester.tap(find.byIcon(Icons.remove));
      await tester.pump();

      expect(cartItemWidget, findsNWidgets(3));
    });
  });
  
  group("Summary Widget", (){

      testWidgets('display summary widget', (WidgetTester tester) async {
      int initialQuantity = 2;
      item.quantity = initialQuantity;

      await tester.pumpWidget(
        MaterialApp(
        home: ChangeNotifierProvider<CartProvider>.value(
          value: mockCartProvider,
          child: Scaffold(
            body: SingleChildScrollView(
              child: TotalSummaryWidget()
            )
              ),
            ),
          ),
        );

      expect(find.byType(TotalSummaryWidget), findsOne);
  });

  testWidgets('display summary widget', (WidgetTester tester) async {
      int initialQuantity = 2;
      item.quantity = initialQuantity;

      await tester.pumpWidget(
        MaterialApp(
        home: ChangeNotifierProvider<CartProvider>.value(
          value: mockCartProvider,
          child: Scaffold(
            body: SingleChildScrollView(
              child: TotalSummaryWidget()
            )
              ),
            ),
          ),
        );

      expect(find.byType(TotalSummaryWidget), findsOne);
  });

  testWidgets('display summary widget', (WidgetTester tester) async {
      int initialQuantity = 2;
      item.quantity = initialQuantity;

      await tester.pumpWidget(
        MaterialApp(
        home: ChangeNotifierProvider<CartProvider>.value(
          value: mockCartProvider,
          child: Scaffold(
            body: SingleChildScrollView(
              child: TotalSummaryWidget()
            )
              ),
            ),
          ),
        );

      print(find.byType(TotalSummaryWidget));

      print(find.descendant(of: find.byType(TotalSummaryWidget), matching: find.byType(Text)));
      expect(find.text("€${mockCartProvider.deliveryCosts.toStringAsFixed(2)}"), findsOne);
      expect(find.text("€${mockCartProvider.totalCosts.toStringAsFixed(2)}"), findsOne);
      expect(find.text("€${mockCartProvider.getTotalCosts().toStringAsFixed(2)}"), findsOne);
      expect(find.text("${mockCartProvider.greenDrops}"), findsOne);
  });




  });

  // testWidgets('remove item when "Remove" button is tapped and quantity = 0', (WidgetTester tester) async {
  //     int initialQuantity = 1;
  //     item.quantity = initialQuantity;

  //     await tester.pumpWidget(
  //       MaterialApp(
  //       home: ChangeNotifierProvider<CartProvider>.value(
  //         value: mockCartProvider,
  //         child: Scaffold(
  //           body: SingleChildScrollView(
  //             child: CartItemWidget(item: item),
  //           ),
  //         ),
  //       ),
  //     ),
  //   );

  //     Finder cartItemWidget = find.byType(CartItemWidget);

  //     await tester.tap(find.byIcon(Icons.remove));
  //     await tester.pump();

  //     expect(find.descendant(of: cartItemWidget, matching: find.text('${initialQuantity-1}')), findsOneWidget);

}
