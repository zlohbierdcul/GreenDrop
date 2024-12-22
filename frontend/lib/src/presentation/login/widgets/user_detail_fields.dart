import 'package:flutter/material.dart';
import 'package:greendrop/src/presentation/common_widgets/text_form_field.dart';
import 'package:greendrop/src/presentation/login/provider/registration_provider.dart';
import 'package:provider/provider.dart';

class UserDetailFields extends StatelessWidget {
  const UserDetailFields({super.key});

  Widget _gap() => const SizedBox(height: 16);

  @override
  Widget build(BuildContext context) {
    return Consumer<RegistrationProvider>(
        builder: (context, provider, child) => Column(
              children: [
                CustomTextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Benutzername darf nicht leer sein!';
                    }
                    provider.setUsername(value);
                    return null;
                  },
                  icon: const Icon(Icons.person_outline),
                  label: "Benutzername",
                  hintText: "Benutzername",
                ),
                _gap(),
                Row(
                  children: [
                    Flexible(
                      flex: 5,
                      child: CustomTextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Vorname darf nicht leer sein!';
                          }
                          provider.setFirstname(value);
                          return null;
                        },
                        icon: const Icon(Icons.badge_outlined),
                        label: "Vorname",
                        hintText: "Vorname",
                      ),
                    ),
                    const SizedBox(width: 16),
                    // Nachname Input
                    Flexible(
                      flex: 5,
                      child: CustomTextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Nachname darf nicht leer sein!';
                          }
                          provider.setLastname(value);
                          return null;
                        },
                        label: "Nachname",
                        hintText: "Nachname",
                      ),
                    ),
                  ],
                ),
                _gap(),
                CustomTextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email darf nicht leer sein!';
                    }
                    provider.setEmail(value);
                    return null;
                  },
                  icon: const Icon(Icons.email_outlined),
                  label: "E-Mail",
                  hintText: "E-Mail",
                ),
                // Vorname Input
                _gap(),
                // Geburtsdatum Input
                CustomTextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Geburtsdatum darf nicht leer sein!';
                    }
                    provider.setBirthdate(value);
                    return null;
                  },
                  keyboardType: TextInputType.datetime,
                  icon: const Icon(Icons.date_range_outlined),
                  label: "Geburtsdatum",
                  hintText: "TT/MM/JJJJ",
                ),
              ],
            ));
  }
}
