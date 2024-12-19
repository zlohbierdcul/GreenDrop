import 'package:flutter/material.dart';
import 'package:greendrop/src/presentation/common_widgets/app_drawer.dart';
import 'package:greendrop/src/presentation/common_widgets/center_constrained_body.dart';
import 'package:greendrop/src/presentation/order_history/widgets/order_history_list.dart';
import 'package:greendrop/src/presentation/order_history/provider/order_history_provider.dart';
import 'package:provider/provider.dart';

class OrderHistoryPage extends StatelessWidget {
  const OrderHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<OrderHistoryProvider>(
      create: (context) =>
          OrderHistoryProvider(), // Hier wird der Provider initialisiert
      child: Scaffold(
        appBar: AppDrawer.buildGreendropsAppBar(context),
        body: const CenterConstrainedBody(
          body: Center(
            child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 8.0),
                      child: SizedBox(
                        width: double.infinity,
                        height: 60,
                        child: Card(
                          child: Center(
                            child: Text(
                              "Bestellhistorie",
                              style: TextStyle(
                                fontSize: 24,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      // Ändere dies hier, um die Karte zu dehnen
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 8.0),
                        child: Card(
                          child: OrdersList(),
                        ),
                      ),
                    ),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}




  

