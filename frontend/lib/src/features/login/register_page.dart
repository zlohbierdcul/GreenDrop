import 'package:flutter/material.dart';

class Registration extends StatefulWidget {
  const Registration({Key? key}) : super(key: key);

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
                    const FlutterLogo(size: 100),
                    _gap(),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        "Registrieren bei GreenDrop",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    _gap(),
                    // Name Input
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Name darf nicht leer sein!';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Name',
                        hintText: 'Vollständiger Name',
                        prefixIcon: Icon(Icons.person_outline),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    _gap(),
                    // Email Input
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Email darf nicht leer sein!';
                        }
                        bool emailValid = RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(value);
                        if (!emailValid) {
                          return 'Bitte geben Sie eine gültige Email ein';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        hintText: 'Bitte Email angeben',
                        prefixIcon: Icon(Icons.email_outlined),
                        border: OutlineInputBorder(),
                      ),
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
                        // Vergleich mit dem Passwort (später erweitern, falls Passwort im State gespeichert wird)
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
                                _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                              });
                            },
                          )),
                    ),
                    _gap(),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4)),
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
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Haben Sie schon ein Konto? Login!'),
                    ),
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