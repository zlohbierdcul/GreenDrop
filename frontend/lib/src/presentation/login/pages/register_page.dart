import 'package:flutter/material.dart';
import 'package:geocode/geocode.dart';

import '../../../../main.dart';
import '../../../data/repositories/interfaces/authentication_repository.dart';
import '../../../data/repositories/strapi/strapi_authentication_repository.dart';

class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  String _username =  " ";
  String _email = " ";
  String _password = " ";
  String _forename =  " ";
  String _lastname =  " ";
  String _birthdate =  " ";
  String _street =  " ";
  String _housenumber = " ";
  String _town =  " ";
  String _plz =  " ";
  String _number = " ";
  final List<Address> _addresses = [];

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
                        _username = value;
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
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Email darf nicht leer sein!';
                        }
                        _email = value;
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        hintText: 'Email',
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
                        _forename = value;
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
                        _lastname = value;
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
                        _birthdate = value;
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
                        _street = value;
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
                        _housenumber = value;
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
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Stadt darf nicht leer sein!';
                        }
                        _town = value;
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Stadt',
                        hintText: 'Stadt',
                        prefixIcon: Icon(Icons.home_outlined),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    _gap(),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'PLZ darf nicht leer sein!';
                        }
                        _plz = value;
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: 'PLZ',
                        hintText: 'PLZ',
                        prefixIcon: Icon(Icons.home_outlined),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    _gap(),
                    // Handynummer Input
                    TextFormField(
                      validator: (value) {
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
                        onPressed: () async {
                          if (_formKey.currentState?.validate() ?? false) {

                            //check password
                            IAuthenticationRepository authenticationRepository =
                            StrapiAuthenticationRepository();

                            bool success = false;
                            try {

                              success = await authenticationRepository.register(
                                  _username, _email, _password, _forename, _lastname, _birthdate,_street,
                                  _housenumber, _town, _plz);
                            } catch (e) {
                              print(e);
                              print("Register failed.");
                            }

                            if (success) {
                              Navigator.of(navigatorKey.currentContext!).pushReplacementNamed("/login");
                            } else {
                            }
                            //register http

                            //Navigator.pushNamed(context, '/login');
                          }
                        },
                      ),
                    ),
                    _gap(),

                      // Weiterleitung zur Registrierungsseite
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, '/login');
                        },
                        child: const Text(
                          'Schon ein Konto? Hier anmelden!',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
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
