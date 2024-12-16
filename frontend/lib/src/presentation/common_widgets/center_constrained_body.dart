import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:greendrop/src/presentation/theme/theme_provider.dart';
import 'package:provider/provider.dart';

class CenterConstrainedBody extends StatelessWidget {
  final Widget body;
  const CenterConstrainedBody({super.key, required this.body});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                  "assets/images/${_isDarkMode(context) ? "background_pattern_dark.png" : "background_pattern_light.png"}"),
              repeat: ImageRepeat.repeat)),
      child: Scrollbar(
          child: Center(
              child: FractionallySizedBox(
                  widthFactor: kIsWeb ? 0.7 : 1,
                  child: ScrollConfiguration(
                      behavior: ScrollConfiguration.of(context)
                          .copyWith(scrollbars: false),
                      child: Material(elevation: 5, child: body))))),
    );
  }

  bool _isDarkMode(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    dynamic themeMode = context.watch<AppTheme>().themeMode;

    if (themeMode == ThemeMode.system) {
      return isDarkMode;
    } else {
      return themeMode == ThemeMode.dark;
    }
  }
}
