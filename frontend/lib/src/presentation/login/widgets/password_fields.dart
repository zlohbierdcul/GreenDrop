import 'package:flutter/material.dart';
import 'package:greendrop/src/presentation/common_widgets/text_form_field.dart';
import 'package:greendrop/src/presentation/login/provider/registration_provider.dart';
import 'package:provider/provider.dart';

class PasswordFields extends StatelessWidget {
  const PasswordFields({super.key});

  Widget _gap() => const SizedBox(height: 16);

  @override
  Widget build(BuildContext context) {
    return Consumer<RegistrationProvider>(
      builder: (context, provider, child) => Column(
        children: [
          CustomTextFormField(
              controller: provider.passwordController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Passwort darf nicht leer sein!';
                }
                if (value.length < 6) {
                  return 'Passwort muss mindestens 6 Zeichen lang sein';
                }
                provider.setPassword(value);
                if (provider.passwordController.text !=
                    provider.confirmPasswordController.text) {
                  return "Passwörter stimmen nicht überein";
                }
                return null;
              },
              label: 'Passwort',
              hintText: 'Erstelle ein Passwort',
              icon: const Icon(Icons.lock_outline_rounded),
              obscureText: !provider.isPasswordVisible,
              suffixIcon: IconButton(
                icon: Icon(provider.isPasswordVisible
                    ? Icons.visibility_off
                    : Icons.visibility),
                onPressed: provider.togglePasswordVisible,
              )),
          _gap(),
          // Passwort Bestätigung Input
          CustomTextFormField(
              controller: provider.confirmPasswordController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Passwort-Bestätigung darf nicht leer sein!';
                }
                if (value.length < 6) {
                  return 'Passwort muss mindestens 6 Zeichen lang sein';
                }
                provider.setConfirmPassword(value);
                if (provider.password != provider.confirmPassword) {
                  return "Passwörter stimmen nicht überein";
                }
                return null;
              },
              obscureText: !provider.isConfirmPasswordVisible,
              label: 'Passwort bestätigen',
              hintText: 'Wiederhole dein Passwort',
              icon: const Icon(Icons.lock_outline_rounded),
              suffixIcon: IconButton(
                icon: Icon(provider.isConfirmPasswordVisible
                    ? Icons.visibility_off
                    : Icons.visibility),
                onPressed: provider.toggleConfirmPasswordVisible,
              )),
        ],
      ),
    );
  }
}
