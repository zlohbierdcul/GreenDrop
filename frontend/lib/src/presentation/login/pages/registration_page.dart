import 'package:flutter/material.dart';
import 'package:greendrop/src/presentation/login/provider/registration_provider.dart';
import 'package:greendrop/src/presentation/login/widgets/address_fields.dart';
import 'package:greendrop/src/presentation/login/widgets/celebration.dart';
import 'package:greendrop/src/presentation/login/widgets/password_fields.dart';
import 'package:greendrop/src/presentation/login/widgets/registration_buttons.dart';
import 'package:greendrop/src/presentation/login/widgets/registration_complete.dart';
import 'package:greendrop/src/presentation/login/widgets/user_detail_fields.dart';
import 'package:provider/provider.dart';

class RegistrationPage extends StatelessWidget {
  RegistrationPage({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Scaffold(
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
                            const UserDetailFields()
                          ] else if (provider.registrationPage == 2) ...[
                            const AddressFields()
                          ] else if (provider.registrationPage == 3) ...[
                            const PasswordFields()
                          ] else if (provider.registrationPage == 4) ...[
                            const RegistrationComplete()
                          ],
                          _gap(),
                          RegistrationButtons(formKey: _formKey),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        const Celebration()
      ],
    );
  }

  Widget _gap() => const SizedBox(height: 16);
}
