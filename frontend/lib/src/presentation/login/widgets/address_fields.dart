import 'package:flutter/material.dart';
import 'package:greendrop/src/presentation/common_widgets/text_form_field.dart';
import 'package:greendrop/src/presentation/login/provider/registration_provider.dart';
import 'package:provider/provider.dart';

class AddressFields extends StatelessWidget {
  const AddressFields({super.key});

  Widget _gap() => const SizedBox(height: 16);

  @override
  Widget build(BuildContext context) {
    return Consumer<RegistrationProvider>(
        builder: (context, provider, child) => Column(
              children: [
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
              ],
            ));
  }
}
