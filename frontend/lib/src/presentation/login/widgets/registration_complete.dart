import 'package:flutter/material.dart';
import 'package:greendrop/src/presentation/login/provider/registration_provider.dart';
import 'package:provider/provider.dart';

class RegistrationComplete extends StatelessWidget {
  const RegistrationComplete({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<RegistrationProvider>(
      builder: (context, provider, child) => Column(
        children: [
          provider.registrationSuccessful
              ? const Text("Registration erfolgreich.")
              : const Text("Registration fehlgeschlagen!")
        ],
      ),
    );
  }
}
