import 'package:flutter_test/flutter_test.dart';
import 'package:greendrop/src/presentation/shops/provider/filter_provider.dart';

void main() {
  group('FilterProvider Tests', () {
    late FilterProvider filterProvider;


    setUp(() {
      // Initialisiere den FilterProvider vor jedem Test
      filterProvider = FilterProvider();

    });


    test('Initialwerte sind korrekt', () {
      expect(filterProvider.deliveryCost, 10.0);
      expect(filterProvider.minCost, 50.0);
    });

    test('setDeliveryCost aktualisiert deliveryCost und benachrichtigt Listener', () {
      // ARRANGE
      const newDeliveryCost = 15.0;

      // ACT
      filterProvider.setDeliveryCost(newDeliveryCost);

      // ASSERT
      expect(filterProvider.deliveryCost, newDeliveryCost);
    });

    test('setMinCost aktualisiert minCost und benachrichtigt Listener', () {
      // ARRANGE
      const newMinCost = 60.0;

      // ACT
      filterProvider.setMinCost(newMinCost);

      // ASSERT
      expect(filterProvider.minCost, newMinCost);
    });

    test('resetFilter setzt deliveryCost und minCost auf Standardwerte und benachrichtigt Listener', () {
      // ARRANGE
      filterProvider.setDeliveryCost(20.0);
      filterProvider.setMinCost(70.0);

      // ACT
      filterProvider.resetFilter();

      // ASSERT
      expect(filterProvider.deliveryCost, 10.0);
      expect(filterProvider.minCost, 50.0);
    });

    test('Mehrfaches Setzen ruft notifyListeners korrekt auf', () {
      // ARRANGE
      const newDeliveryCost1 = 12.0;
      const newMinCost1 = 55.0;
      const newDeliveryCost2 = 18.0;
      const newMinCost2 = 65.0;

      // ACT
      filterProvider.setDeliveryCost(newDeliveryCost1);
      filterProvider.setMinCost(newMinCost1);
      filterProvider.setDeliveryCost(newDeliveryCost2);
      filterProvider.setMinCost(newMinCost2);

      // ASSERT
      expect(filterProvider.deliveryCost, newDeliveryCost2);
      expect(filterProvider.minCost, newMinCost2);
    });
  });
}
