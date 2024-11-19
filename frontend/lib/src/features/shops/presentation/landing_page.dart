import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common_widgets/dropdown.dart';
import '../../theme/theme_provider.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: SizedBox(
                width: double.infinity,
                height: 200,
                child: Card(
                  child: Center(child: Text("Landing Page")),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
