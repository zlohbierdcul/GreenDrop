
import 'package:flutter/material.dart';

class CustomDropdownButton extends StatelessWidget {
  static const double radius = 20;

  final List<DropdownMenuItem<dynamic>> items;
  final void Function(dynamic) onChanged;
  final dynamic value;

  const CustomDropdownButton({
    super.key,
    required this.items,
    required this.onChanged,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(radius),
      elevation: 2,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius),
          color: Theme.of(context).colorScheme.secondaryContainer
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: DropdownButton(
          items: items,
          onChanged: onChanged,
          value: value,
          dropdownColor: Theme.of(context).colorScheme.secondaryContainer,
          borderRadius: BorderRadius.circular(radius),
          underline: const SizedBox(),
        ),
      ),
    );
  }
  
}