import 'package:flutter/material.dart';
import 'package:greendrop/src/presentation/login/provider/registration_provider.dart';
import 'package:provider/provider.dart';

class RegistrationComplete extends StatelessWidget {
  const RegistrationComplete({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<RegistrationProvider>(
      builder: (context, provider, child) => Stack(
        alignment: Alignment.topCenter,
        children: [
          Column(
            children: [
              provider.registrationSuccessful
                  ? Column(
                      children: [
                        const SizedBox(height: 16),
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Image.asset("assets/images/celebration.png",
                                width: 100),
                          ],
                        ),
                        const SizedBox(height: 32),
                        const Text(
                          "Registration war erfolgreich.",
                          style: TextStyle(fontSize: 20),
                        ),
                        const Text(
                          "Du kannst dich jetzt anmelden!",
                          style: TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 16),
                        FilledButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .pushReplacementNamed("/login");
                              provider.handleReset();
                            },
                            child: const Text("Zum Login"))
                      ],
                    )
                  : Column(
                      children: [
                        Icon(Icons.warning_rounded,
                            size: 100,
                            color: Theme.of(context).colorScheme.error),
                        const SizedBox(height: 16),
                        const Text(
                          "Registration ist fehlgeschlagen.",
                          style: TextStyle(fontSize: 20),
                        ),
                        const Text(
                          "Bitte versuch es noch einmal!",
                          style: TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 16),
                        FilledButton(
                            onPressed: provider.handleReset,
                            child: const Text("Zur Registration"))
                      ],
                    ),
            ],
          )
        ],
      ),
    );
  }
}
