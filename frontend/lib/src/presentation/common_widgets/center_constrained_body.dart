import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CenterConstrainedBody extends StatelessWidget {
  final Widget body;
  const CenterConstrainedBody({super.key, required this.body});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/background_pattern.png"),
              repeat: ImageRepeat.repeat)),
      child: Scrollbar(
          child: Center(
              child: FractionallySizedBox(
                  widthFactor: kIsWeb ? 0.7 : 1,
                  child: ScrollConfiguration(
                      behavior: ScrollConfiguration.of(context)
                          .copyWith(scrollbars: false),
                      child: Material(
                        elevation: 5,
                        child: body))))),
    );
  }
}
