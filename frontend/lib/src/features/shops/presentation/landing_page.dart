import 'package:flutter/material.dart';
import 'package:greendrop/src/features/map/shops_map.dart';
import 'package:greendrop/src/features/shops/presentation/search_bar.dart';
import 'package:greendrop/src/features/shops/presentation/shop_card.dart';
import 'package:provider/provider.dart';

import '../domain/shop_data_provider.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverAppBar(
            expandedHeight: 300.0,
            floating: false,
            pinned: true,
            stretch: true,
            leading: Container(),
            flexibleSpace: const FlexibleSpaceBar(
                centerTitle: true,
                collapseMode: CollapseMode.parallax,
                background: ShopsMap(),
            ),
          ),
        ];
      },
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  const Expanded(child: ShopSearchBar()),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: () => print("filter"),
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 12.0),
                      child: Icon(Icons.filter_alt),
                    ),
                  )
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 16.0),
              child: Text(
                "Coffeeshops in der Nähe",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            ChangeNotifierProvider<ShopDataProvider>(
              create: (context) => ShopDataProvider(),
              child: Consumer<ShopDataProvider>(
                builder: (context, provider, child) {
                  if (provider.shopList.isEmpty) {
                    return const Center(child: Text("No shops available."));
                  }
                  return ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(16),
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(height: 16);
                    },
                    itemCount: provider.shopList.length,
                    itemBuilder: (BuildContext context, index) {
                      final shop = provider.shopList.values.toList()[index];
                      return ShopCard(shop: shop);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
