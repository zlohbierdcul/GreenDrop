import 'package:flutter/material.dart';

class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

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
              padding: const EdgeInsets.all(32.0),
              constraints: const BoxConstraints(maxWidth: 350),
              child: SingleChildScrollView(
                child: Column(
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
                    // Benutzername Input
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Benutzername darf nicht leer sein!';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Benutzername',
                        hintText: 'Wähle einen Benutzernamen',
                        prefixIcon: Icon(Icons.person_outline),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    _gap(),
                    // Vorname Input
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Vorname darf nicht leer sein!';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Vorname',
                        hintText: 'Dein Vorname',
                        prefixIcon: Icon(Icons.person_outline),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    _gap(),
                    // Nachname Input
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Nachname darf nicht leer sein!';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Nachname',
                        hintText: 'Dein Nachname',
                        prefixIcon: Icon(Icons.person_outline),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    _gap(),
                    // Geburtsdatum Input
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Geburtsdatum darf nicht leer sein!';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Geburtsdatum',
                        hintText: 'TT/MM/JJJJ',
                        prefixIcon: Icon(Icons.calendar_today_outlined),
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.datetime,
                    ),
                    _gap(),
                    // Straßenname Input
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Straßenname darf nicht leer sein!';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Straßenname',
                        hintText: 'Straße',
                        prefixIcon: Icon(Icons.home_outlined),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    _gap(),
                    // Hausnummer Input
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Hausnummer darf nicht leer sein!';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Hausnummer',
                        hintText: 'Hausnummer',
                        prefixIcon: Icon(Icons.home_outlined),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    _gap(),
                    // Handynummer Input
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Handynummer darf nicht leer sein!';
                        }
                        if (!RegExp(r'^\+?[0-9]{7,15}\$').hasMatch(value)) {
                          return 'Bitte eine gültige Handynummer eingeben!';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Handynummer',
                        hintText: '+49 123 456 789',
                        prefixIcon: Icon(Icons.phone_outlined),
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.phone,
                    ),
                    _gap(),
                    // Passwort Input
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Passwort darf nicht leer sein!';
                        }
                        if (value.length < 6) {
                          return 'Passwort muss mindestens 6 Zeichen lang sein';
                        }
                        return null;
                      },
                      obscureText: !_isPasswordVisible,
                      decoration: InputDecoration(
                          labelText: 'Passwort',
                          hintText: 'Erstelle ein Passwort',
                          prefixIcon: const Icon(Icons.lock_outline_rounded),
                          border: const OutlineInputBorder(),
                          suffixIcon: IconButton(
                            icon: Icon(_isPasswordVisible
                                ? Icons.visibility_off
                                : Icons.visibility),
                            onPressed: () {
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                          )),
                    ),
                    _gap(),
                    // Passwort Bestätigung Input
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Passwort-Bestätigung darf nicht leer sein!';
                        }
                        return null;
                      },
                      obscureText: !_isConfirmPasswordVisible,
                      decoration: InputDecoration(
                          labelText: 'Passwort bestätigen',
                          hintText: 'Wiederhole dein Passwort',
                          prefixIcon: const Icon(Icons.lock_outline_rounded),
                          border: const OutlineInputBorder(),
                          suffixIcon: IconButton(
                            icon: Icon(_isConfirmPasswordVisible
                                ? Icons.visibility_off
                                : Icons.visibility),
                            onPressed: () {
                              setState(() {
                                _isConfirmPasswordVisible =
                                !_isConfirmPasswordVisible;
                              });
                            },
                          )),
                    ),
                    _gap(),
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
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                        onPressed: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            Navigator.pushNamed(context, '/home');
                          }
                        },
                      ),
                    ),
                    _gap(),

                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _gap() => const SizedBox(height: 16);
}
