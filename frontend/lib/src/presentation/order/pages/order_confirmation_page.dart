import 'package:flutter/material.dart';
import 'package:greendrop/src/presentation/common_widgets/app_drawer.dart';

class OrderConfirmationPage extends StatelessWidget {
  const OrderConfirmationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppDrawer.buildGreendropsAppBar(context),
      body: Center(
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
              const Padding(
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
              Padding(padding: const EdgeInsets.all(8.0),
                child: Center(child: SizedBox(
                  child: FilledButton(onPressed: () => Navigator.pushReplacementNamed(context, "/home"), child:
                  const Text("Zurück zur Startseite")
                  ),
                ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
