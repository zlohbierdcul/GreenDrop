import 'package:flutter/material.dart';
import 'package:greendrop/src/presentation/common_widgets/app_drawer.dart';
import 'package:greendrop/src/presentation/common_widgets/center_constrained_body.dart';

import '../../common_widgets/no_swipe_page_route.dart';
import '../../map/pages/order_tracking_page.dart';

class OrderConfirmationPage extends StatelessWidget {

  final int earnedGreenDrops;
  final String? orderID;
  // required parameters so we don't have to use Providers only for these 2
  const OrderConfirmationPage({super.key, required this.earnedGreenDrops, required this.orderID});

  @override
  Widget build(BuildContext context) {
    // Entferne Rücknavigation mit onWillPop
    return WillPopScope(
        onWillPop: () async => false,
    child: Scaffold(
    appBar: AppDrawer.buildGreendropsAppBar(
    context,
    automaticallyImplayLeading: false,
    ),
      body: CenterConstrainedBody(
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(bottom: 8.0),
                        child: SizedBox(
                          width: double.infinity,
                          height: 60,
                          child: Card(
                            child: Center(
                              child: Text(
                                "Bestellbestätigung",
                                style: TextStyle(
                                  fontSize: 24,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: double.infinity,
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Vielen Dank für Ihre Bestellung. Sie wird in kürze eintreffen",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 24),
                                  const Text(
                                    "Sie können ihre Bestellung einsehen unter der Bestellnummer:",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text("Greendrop#$orderID"),
                                  const SizedBox(height: 24),
                                  const Text(
                                    "Verdiente GreenDrops:",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text("$earnedGreenDrops"),
                                  const SizedBox(height: 24),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () => Navigator.of(context).pushReplacement(
                      NoSwipePageRoute(builder: (context) => const TrackingMap()
                      )
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: Text(
                      "Track your Order",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () => Navigator.pushReplacementNamed(context, "/home"),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: Text(
                      "Zurück zur Startseite",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
