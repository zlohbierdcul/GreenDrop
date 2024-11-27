import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

class Registration extends StatefulWidget {
  const Registration({Key? key}) : super(key: key);

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _isAbove18 = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _zipController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _houseNumberController = TextEditingController();

  static Future<bool> checkAddress(String address) async {
    try {
      final locations = await locationFromAddress(address);
      return locations.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  void _validateAndRegister() async {
    if (_formKey.currentState?.validate() ?? false) {
      if (!_isAbove18) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Bitte bestätigen Sie, dass Sie mindestens 18 Jahre alt sind.'),
          ),
        );
        return;
      }

      final fullAddress =
          '${_streetController.text}, ${_zipController.text}, ${_cityController.text}';
      final isAddressValid = await checkAddress(fullAddress);

      if (!isAddressValid) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Die eingegebene Adresse ist ungültig. Bitte überprüfen Sie Ihre Angaben.'),
          ),
        );
        return;
      }

      // Wenn alles gültig ist
      Navigator.pushNamed(context, '/home');
    }
  }

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
                    _gap(),TextFormField(
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
                    ),
                    _gap(),
                    // Straße Input
                    TextFormField(
                      controller: _streetController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Straße darf nicht leer sein!';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Straße',
                        hintText: 'Deine Straße',
                        prefixIcon: Icon(Icons.location_on_outlined),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    _gap(),
                    TextFormField(
                      controller: _houseNumberController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Hausnummer darf nicht leer sein!';
                        }
                        if (!RegExp(r'^\d+[a-zA-Z]?$').hasMatch(value)) {
                          return 'Bitte eine gültige Hausnummer eingeben!';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Hausnummer',
                        hintText: '123 oder 123a',
                        prefixIcon: Icon(Icons.home_outlined),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    _gap(),
                    // PLZ Input
                    TextFormField(
                      controller: _zipController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'PLZ darf nicht leer sein!';
                        }
                        if (!RegExp(r'^\d{5}$').hasMatch(value)) {
                          return 'Bitte eine gültige PLZ eingeben!';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: 'PLZ',
                        hintText: '12345',
                        prefixIcon: Icon(Icons.local_post_office_outlined),
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    _gap(),
                    // Stadt Input
                    TextFormField(
                      controller: _cityController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Stadt darf nicht leer sein!';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Stadt',
                        hintText: 'Deine Stadt',
                        prefixIcon: Icon(Icons.location_city_outlined),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    _gap(),
                    // Handynummer Input
                    TextFormField(
                      controller: _phoneController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Handynummer darf nicht leer sein!';
                        }
                        if (!RegExp(r'^\+?[0-9]{7,15}$').hasMatch(value)) {
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
                          icon: Icon(_isPasswordVisible ? Icons.visibility_off : Icons.visibility),
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                        ),
                      ),
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
                          icon: Icon(
                              _isConfirmPasswordVisible ? Icons.visibility_off : Icons.visibility),
                          onPressed: () {
                            setState(() {
                              _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                            });
                          },
                        ),
                      ),
                    ),
                    _gap(),
                    // Checkbox für Altersbestätigung
                    Row(
                      children: [
                        Checkbox(
                          value: _isAbove18,
                          onChanged: (value) {
                            setState(() {
                              _isAbove18 = value ?? false;
                            });
                          },
                        ),
                        Expanded(
                          child: Text(
                            'Ich bestätige, dass ich mindestens 18 Jahre alt bin',
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                      ],
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
                        onPressed: _validateAndRegister,
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
