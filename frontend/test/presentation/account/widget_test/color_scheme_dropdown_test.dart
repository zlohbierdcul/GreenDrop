import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:greendrop/src/presentation/common_widgets/dropdown.dart';
import 'package:greendrop/src/presentation/theme/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:greendrop/src/presentation/account/widgets/color_scheme_dropdown.dart';

void main() {
  group('ColorSchemeDropdown Widget Tests', () {
    late AppTheme appTheme;

    setUp(() {
      appTheme = AppTheme();
      appTheme.themeMode = ThemeMode.system; // Explicitly set themeMode
    });

    Widget createTestWidget() {
      return ChangeNotifierProvider<AppTheme>.value(
        value: appTheme,
        child: const MaterialApp(
          home: Scaffold(
            body: ColorSchemeDropdown(),
          ),
        ),
      );
    }

    testWidgets('displays all dropdown items', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      // Verify "Farbschema:" text is displayed
      expect(find.text("Farbschema:"), findsOneWidget);

      // Tap the dropdown button
      await tester.tap(find.byType(CustomDropdownButton));
      await tester.pumpAndSettle();

      // Verify dropdown items are displayed
      expect(find.text("Dunkel"), findsOneWidget);
      expect(find.text("Hell"), findsOneWidget);
      expect(find.text("System").last, findsOneWidget);
    });

    testWidgets('updates themeMode to dark when Dunkel is selected', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      // Tap the dropdown button
      await tester.tap(find.byType(CustomDropdownButton));
      await tester.pumpAndSettle();

      // Tap "Dunkel" option
      await tester.tap(find.text("Dunkel"));
      await tester.pumpAndSettle();

      // Verify the themeMode is updated
      expect(appTheme.themeMode, ThemeMode.dark);
    });

    testWidgets('updates themeMode to light when Hell is selected', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      // Tap the dropdown button
      await tester.tap(find.byType(CustomDropdownButton));
      await tester.pumpAndSettle();

      // Tap "Hell" option
      await tester.tap(find.text("Hell"));
      await tester.pumpAndSettle();

      // Verify the themeMode is updated
      expect(appTheme.themeMode, ThemeMode.light);
    });

    testWidgets('updates themeMode to system when System is selected', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      // Tap the dropdown button
      await tester.tap(find.byType(CustomDropdownButton));
      await tester.pumpAndSettle();

      // Tap "System" option
      await tester.tap(find.text("System").last);
      await tester.pumpAndSettle();

      // Verify the themeMode is updated
      expect(appTheme.themeMode, ThemeMode.system);
    });
  });
}
