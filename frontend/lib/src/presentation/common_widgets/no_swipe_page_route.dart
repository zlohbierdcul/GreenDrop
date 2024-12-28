// deactivation the back-swipe option
import 'package:flutter/material.dart';

class NoSwipePageRoute<T> extends MaterialPageRoute<T> {
  NoSwipePageRoute({required super.builder});
  @override
  bool get popGestureEnabled => false;
}