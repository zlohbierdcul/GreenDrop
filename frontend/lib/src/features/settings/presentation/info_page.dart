import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common_widgets/dropdown.dart';
import '../../../theme/theme_provider.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({super.key});

  List<DropdownMenuItem<String>> get dropdownMenuItems {
    return [
      const DropdownMenuItem<String>(key: Key("theme_1"), value: "dark", child: Text("Dark")),
      const DropdownMenuItem<String>(key: Key("theme_2"), value: "light", child: Text("Light")),
      const DropdownMenuItem<String>(key: Key("theme_3"), value: "system", child: Text("System")),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: SizedBox(
                width: double.infinity,
                height: 200,
                child: Card(
                  child: Center(child: Text("Impressum")),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: FilledButton(
                  onPressed: () => print("hello"),
                  child: const Text("Button")),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Consumer<AppTheme>(
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
            )
          ],
        ),
      ),
    );
  }
}
