import 'package:flutter/material.dart';
import 'package:greendrop/src/presentation/common_widgets/app_drawer.dart';

class OrderConfirmationPage extends StatelessWidget {
  const OrderConfirmationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('GreenDrop'),
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: OutlinedButton(
                onPressed: () => AppDrawer.showPopup(context),
                child: Center(
                    child: Row(
                  children: [
                    Image.asset(
                      'assets/images/logo.png',
                      width: 22,
                      height: 22,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      '2233',
                      style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context)
                              .colorScheme
                              .onSecondaryContainer),
                    ),
                  ],
                )),
              ),
            ),
          ],
        ),
        automaticallyImplyLeading: false,
      ),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
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
                padding: EdgeInsets.all(8.0),
                child: SizedBox(
                  width: double.infinity,
                  child: Card(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Vielen Dank für Ihre Bestellung.",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 24),
                          Text(
                            "Ihre Bestellnummer:",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text("GDObestellnummer123"),
                          SizedBox(height: 24),
                          Text(
                            "Verdiente GreenDrops:",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text("100"),
                          SizedBox(height: 24),
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
    );
  }
}
