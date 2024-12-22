import 'package:flutter/material.dart';
import 'package:greendrop/src/presentation/login/provider/registration_provider.dart';
import 'package:provider/provider.dart';

class RegistrationButtons extends StatelessWidget {
  final GlobalKey<FormState> formKey;

  const RegistrationButtons({super.key, required this.formKey});

  @override
  Widget build(BuildContext context) {
    return Consumer<RegistrationProvider>(
      builder: (context, provider, child) => Column(
        children: [
          if (provider.registrationPage == 1) ...[
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () {
                  if (provider.validatePage(formKey)) {
                    provider.nextPage();
                  }
                },
                child: const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    'Weiter',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            // Weiterleitung zur Registrierungsseite
            TextButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/login');
              },
              child: const Text(
                'Schon ein Konto? Hier anmelden!',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ),
          ] else if (provider.registrationPage == 2) ...[
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () {
                  if (provider.validatePage(formKey)) {
                    provider.nextPage();
                  }
                },
                child: const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    'Weiter',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: provider.previousPage,
                child: const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    'Zurück',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            )
          ] else if (provider.registrationPage == 3) ...[
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    'Registrieren',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                onPressed: () {
                  if (provider.validatePage(formKey)) {
                    provider.nextPage();
                    provider.registerUser();
                  }
                },
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: provider.previousPage,
                child: const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    'Zurück',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            )
          ]
        ],
      ),
    );
  }
}
