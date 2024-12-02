import 'package:flutter/material.dart';

import '../../hamburger_menu/presentation/hamburger_menu.dart';

class ImpressumPage extends StatelessWidget {
  const ImpressumPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Row(
            children: [
              const Text('Greendrops'),
              const SizedBox(width: 8),
              TextButton(
                onPressed: () {
                  print('2233 Greendrobs');
                },
                child: const Text(
                  '#2233',
                ),

              ),
            ],
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 32.0),
              child: Image.asset(
                'assets/images/logo.png',
                width: 40,
                height: 40,
              ),
            ),
          ]
      ),
    drawer: const AppDrawer(),
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
                      "Impressum",
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
              child: Card(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Angaben gemäß § 5 TMG:",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text("GreenDrop GmbH"),
                      Text("Musterstraße 123"),
                      Text("12345 Musterstadt"),
                      SizedBox(height: 12),
                      Text("Vertreten durch den Geschäftsführer:",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                      ),
                      SizedBox(height: 4),
                      Text("CPD Team (Luc, Cedric H., Melanie, Alexander, Sajid, Cedric B.)"),
                      SizedBox(height: 12),
                      Text(
                          "Kontakt:",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text("Telefon: 01234/56789"),
                      Text("Fax: 01234/56789-10"),
                      Text("E-Mail: greendrop@muster.de"),
                      SizedBox(height: 12),
                      Text(
                        "Registereintrag:",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text("Eintragung im Handelsregister"),
                      Text("Amtsgericht Musterstadt, HRB 123456"),
                      SizedBox(height: 12),
                      Text(
                        "Umsatzsteuer-ID:",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text("USt.-ID: DE123456789"),
                      SizedBox(height: 12),
                      Text(
                        "Verantwortlich für den Inhalt nach § 55 Abs. 2 RStV:",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text("CPD Team, Musterstraße 123, 12345 Musterstadt"),
                      SizedBox(height: 12),
                      Text(
                        "Haftungsausschluss:",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text("Die Inhalte unserer Seiten wurden mit größter Sorgfalt erstellt. Für die Richtigkeit, Vollständigkeit und Aktualität der Inhalte können wir jedoch keine Gewähr übernehmen."),
                      SizedBox(height: 12),
                      Text(
                        "Haftung für Links:",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text("Unser Angebot enthält Links zu externen Webseiten Dritter, auf deren Inhalte wir keinen Einfluss haben. Deshalb können wir für diese fremden Inhalte auch keine Gewähr übernehmen. Die jeweiligen Anbieter sind für die Inhalte der verlinkten Seiten verantwortlich."),
                    ],
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
