import 'package:flutter/material.dart';
import 'package:greendrop/src/common_widgets/dropdown.dart';
import 'package:greendrop/src/theme/theme_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const GreenDropApp());
}

class GreenDropApp extends StatelessWidget {
  const GreenDropApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AppTheme>(
      create: (_) => AppTheme(),
      builder: (context, _) => MaterialApp(
        title: 'GreenDrop',
        theme: ThemeData.from(colorScheme: AppTheme.lightTheme),
        darkTheme: ThemeData.from(colorScheme: AppTheme.darkTheme),
        themeMode: context.watch<AppTheme>().themeMode,
        debugShowCheckedModeBanner: false,
        home: const MyHomePage(title: 'GreenDrop'),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final dynamic title;

  const MyHomePage({super.key, required this.title});


  List<DropdownMenuItem<String>> get dropdownMenuItems {
    return [
      const DropdownMenuItem<String>(key: Key("theme_1"), value: "dark", child: Text("Dark")),
      const DropdownMenuItem<String>(key: Key("theme_2"), value: "light", child: Text("Light")),
      const DropdownMenuItem<String>(key: Key("theme_3"), value: "system", child: Text("System")),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
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
                    child: Center(child: Text("Card")),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: FilledButton(
                    onPressed: () => print("hello"),
                    child: const Text("Button")
                ),
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
                            case "dark": {
                              appTheme.themeMode = ThemeMode.dark;
                            }
                            case "light": {
                              appTheme.themeMode = ThemeMode.light;
                            }
                            case "system": {
                              appTheme.themeMode = ThemeMode.system;
                            }
                          }
                        });
                  },
                ),
              )
            ],
          )
        ),
      ),
      floatingActionButton: Consumer<AppTheme>(
        builder: (context, appTheme, child) {
          return FloatingActionButton(
            onPressed: () {
              appTheme.themeMode = appTheme.themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
            },
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          );
        },
      )
    );
  }
}
