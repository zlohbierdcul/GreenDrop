import 'package:flutter/material.dart';
import 'package:greendrop/src/presentation/common_widgets/text_form_field.dart';
import 'package:greendrop/src/presentation/login/provider/registration_provider.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Center(
          child: Card(
            elevation: 8,
            child: Container(
              padding: const EdgeInsets.all(16.0),
              constraints: const BoxConstraints(maxWidth: 350),
              child: SingleChildScrollView(
                child: Consumer<RegistrationProvider>(
                  builder: (context, provider, child) => Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 100,
                        child: AspectRatio(
                          aspectRatio: 1 / 1,
                          child: Image.asset(
                            "assets/images/logo.png",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      _gap(),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          "Registrieren bei GreenDrop",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      _gap(),
                      if (provider.registrationPage == 1) ...[
                        ...showUserInfoFields(context)
                      ] else if (provider.registrationPage == 2) ...[
                        ...showAddressFields(context)
                      ] else if (provider.registrationPage == 3) ...[
                        ...showPasswordFields(context)
                      ],
                      _gap(),
                      showButtons(_formKey),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _gap() => const SizedBox(height: 16);

  List<Widget> showUserInfoFields(BuildContext context) {
    RegistrationProvider provider = Provider.of<RegistrationProvider>(context);
    return [
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
    ];
  }

  List<Widget> showAddressFields(BuildContext context) {
    RegistrationProvider provider = Provider.of<RegistrationProvider>(context);
    return [
      Row(
        children: [
          Flexible(
            flex: 4,
            child: CustomTextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Straßenname darf nicht leer sein!';
                }
                provider.setStreet(value);
                return null;
              },
              icon: const Icon(Icons.signpost_outlined),
              label: "Straße",
              hintText: "Straße",
            ),
          ),
          const SizedBox(width: 16),
          Flexible(
            flex: 2,
            child: CustomTextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Hausnummer darf nicht leer sein!';
                }
                provider.setStreetNumber(value);
                return null;
              },
              label: "Nr",
              hintText: "Nr",
            ),
          ),
        ],
      ),
      _gap(),
      Row(
        children: [
          Flexible(
            flex: 5,
            child: CustomTextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Stadt darf nicht leer sein!';
                }
                provider.setCity(value);
                return null;
              },
              label: "Stadt",
              hintText: "Stadt",
              icon: const Icon(Icons.location_city_outlined),
            ),
          ),
          const SizedBox(width: 16),
          Flexible(
            flex: 4,
            child: CustomTextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'PLZ darf nicht leer sein!';
                }
                provider.setZipCode(value);
                return null;
              },
              label: "PLZ",
              hintText: "PLZ",
            ),
          ),
        ],
      ),
    ];
  }

  List<Widget> showPasswordFields(context) {
    RegistrationProvider provider = Provider.of<RegistrationProvider>(context);
    return [
      CustomTextFormField(
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Passwort darf nicht leer sein!';
            }
            if (value.length < 6) {
              return 'Passwort muss mindestens 6 Zeichen lang sein';
            }
            provider.setPassword(value);
            if (provider.password != provider.confirmPassword) {
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
    ];
  }

  Widget showButtons(formKey) {
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
