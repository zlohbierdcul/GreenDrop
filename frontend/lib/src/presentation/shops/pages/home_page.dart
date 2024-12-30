import 'package:flutter/material.dart';
import 'package:greendrop/src/presentation/account/provider/user_provider.dart';
import 'package:greendrop/src/presentation/common_widgets/app_drawer.dart';
import 'package:greendrop/src/presentation/common_widgets/center_constrained_body.dart';
import 'package:greendrop/src/presentation/map/widgets/shop_map.dart';
import 'package:greendrop/src/presentation/shops/provider/shop_data_provider.dart';
import 'package:greendrop/src/presentation/shops/widgets/filter_dialog.dart';
import 'package:greendrop/src/presentation/shops/widgets/search_bar.dart';
import 'package:greendrop/src/presentation/shops/widgets/shop_list.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, userProvider, child) {
        userProvider.fetchUser();
        return Scaffold(
            appBar: AppDrawer.buildGreendropsAppBar(context),
            drawer: const AppDrawer(),
            body: NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  Consumer<ShopDataProvider>(
                    builder: (context, shopDataProvider, child) => SliverAppBar(
                      expandedHeight: 300,
                      floating: false,
                      stretch: true,
                      leading: Container(),
                      flexibleSpace: FlexibleSpaceBar(
                        centerTitle: true,
                        collapseMode: CollapseMode.parallax,
                        background: ShopMap(
                            shops: shopDataProvider.shopList.values.toList()),
                      ),
                    ),
                  ),
                ];
              },
              body: SingleChildScrollView(
                child: CenterConstrainedBody(
                  body: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            const Expanded(child: ShopSearchBar()),
                            const SizedBox(width: 16),
                            ElevatedButton(
                              onPressed: () =>
                                  FilterDialog.dialogBuilder(context),
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20))),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(vertical: 12.0),
                                child: Icon(Icons.tune_rounded),
                              ),
                            )
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 16.0),
                        child: Text(
                          "Coffeeshops in der Nähe",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const ShopList(),
                    ],
                  ),
                ),
              ),
            ));
      },
    );
  }
}
