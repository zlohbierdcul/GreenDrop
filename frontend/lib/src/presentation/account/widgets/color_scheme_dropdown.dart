import 'package:flutter/material.dart';
import 'package:greendrop/src/presentation/common_widgets/dropdown.dart';
import 'package:greendrop/src/presentation/theme/theme_provider.dart';
import 'package:provider/provider.dart';

class ColorSchemeDropdown extends StatelessWidget {
  const ColorSchemeDropdown({super.key});

  List<DropdownMenuItem<String>> get dropdownMenuItems {
    return [
      const DropdownMenuItem<String>(
          key: Key("theme_dark"), value: "dark", child: Text("Dunkel")),
      const DropdownMenuItem<String>(
          key: Key("theme_light"), value: "light", child: Text("Hell")),
      const DropdownMenuItem<String>(
          key: Key("theme_system"), value: "system", child: Text("System")),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "Farbschema:",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        Consumer<AppTheme>(
          builder: (context, appTheme, child) {
            return CustomDropdownButton(
              items: dropdownMenuItems,
              value: appTheme.themeMode.name,
              onChanged: (s) {
                switch (s) {
                  case "dark":
                    appTheme.themeMode = ThemeMode.dark;
                    break;
                  case "light":
                    appTheme.themeMode = ThemeMode.light;
                    break;
                  case "system":
                    appTheme.themeMode = ThemeMode.system;
                    break;
                }
              },
            );
          },
        ),
      ],
    );
  }
}
