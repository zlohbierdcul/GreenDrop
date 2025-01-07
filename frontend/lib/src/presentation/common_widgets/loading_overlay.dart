import 'package:flutter/material.dart';

class LoadingOverlay {
  LoadingOverlay();

  OverlayEntry? _overlay;

  void show(BuildContext context) {
    if (_overlay == null) {
      _overlay = OverlayEntry(
        builder: (context) => Container(
          alignment: Alignment.center,
          color: const Color.fromARGB(124, 0, 0, 0),
          height: double.infinity,
          width: double.infinity,
          child: const CircularProgressIndicator(),
        ),
      );

      Overlay.of(context).insert(_overlay!);
    }
  }

    void hide() {
    if (_overlay != null) {
      _overlay!.remove();
      _overlay = null;
    }
  }
}
