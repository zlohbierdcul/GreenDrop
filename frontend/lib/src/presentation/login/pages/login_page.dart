import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:greendrop/src/presentation/common_widgets/text_form_field.dart';
import 'package:greendrop/src/presentation/login/provider/login_provider.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    if (!kIsWeb) FlutterNativeSplash.remove();
    return Consumer<LoginProvider>(
      builder: (context, loginProvider, child) => Scaffold(
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
                          "GreenDrop",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      _gap(),
                      CustomTextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: emailController,
                        hintText: "E-Mail",
                        label: "E-Mail",
                        icon: const Icon(Icons.email_outlined),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Textfeld ist leer!';
                          }
                          bool emailValid = RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value);
                          if (!emailValid) {
                            return 'Bitte geben Sie Ihre Email ein';
                          }
                          return null;
                        },
                      ),
                      _gap(),
                      CustomTextFormField(
                        controller: passwordController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Textfeld ist leer!';
                          }

                          if (value.length < 6) {
                            return 'Passwort muss mindestens 6 Zeichen haben';
                          }
                          return null;
                        },
                        obscureText: !loginProvider.isPasswordVisible,
                        label: "Passwort",
                        hintText: "Passwort",
                        suffixIcon: IconButton(
                          icon: Icon(loginProvider.isPasswordVisible
                              ? Icons.visibility_off
                              : Icons.visibility),
                          onPressed: () => loginProvider.setIsPasswordVisible(
                              !loginProvider.isPasswordVisible),
                        ),
                        icon: const Icon(Icons.lock_outline_rounded),
                      ),
                      _gap(),
                      CheckboxListTile(
                        value: loginProvider.rememberMeTicked,
                        onChanged: (value) {
                          if (value == null) return;
                          loginProvider.setRememberMeTicked(value);
                        },
                        title: const Text('Remember me'),
                        controlAffinity: ListTileControlAffinity.leading,
                        dense: true,
                        contentPadding: const EdgeInsets.all(0),
                      ),
                      _gap(),
                      Consumer<LoginProvider>(
                        builder: (context, loginProvider, child) => SizedBox(
                          width: double.infinity,
                          child: FilledButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: loginProvider.isLoading
                                  ? const Center(
                                      child: CircularProgressIndicator(
                                      color: Colors.white,
                                    ))
                                  : const Text(
                                      'Anmelden',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                            ),
                            onPressed: () async {
                              loginProvider.loginHandler(
                                  _formKey,
                                  emailController.text,
                                  passwordController.text);
                            },
                          ),
                        ),
                      ),
                      _gap(),
                      // Weiterleitung zur Registrierungsseite
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/register');
                        },
                        child: const Text(
                          'Noch kein Konto? Jetzt registrieren!',
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
      ),
    );
  }

  Widget _gap() => const SizedBox(height: 16);
}
