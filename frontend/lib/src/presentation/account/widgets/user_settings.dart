import 'package:flutter/material.dart';
import 'package:greendrop/src/presentation/account/widgets/color_scheme_dropdown.dart';

class UserSettings extends StatelessWidget {
  const UserSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 16.0, top: 16),
          child: Text("Einstellungen",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
        Card(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: ColorSchemeDropdown(),
          ),
        ),
      ],
    );
  }
}
