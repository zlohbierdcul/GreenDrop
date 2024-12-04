import 'package:flutter/cupertino.dart';
import 'package:greendrop/src/features/shops/presentation/provider/shop_data_provider.dart';
import 'package:greendrop/src/features/shops/presentation/shops/shop_card.dart';
import 'package:provider/provider.dart';

class ShopList extends StatelessWidget {
  const ShopList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ShopDataProvider>(
      builder: (context, provider, child) {
        // Check if shopList is empty
        if (provider.shopList.isEmpty) {
          return const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(16),
                child: Text("Keine Shops gefunden."),
              ),
            ],
          );
        }
        return ListView.separated(
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          padding: const EdgeInsets.all(16),
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(height: 16);
          },
          itemCount: provider.shopList.length,
          itemBuilder: (BuildContext context, index) {
            // Assuming shopList is a Map or List
            final shop = provider.shopList.values.toList()[index];
            return ShopCard(shop: shop);
          },
        );
      },
    );
  }
}
