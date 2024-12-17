
import 'package:flutter/material.dart';
import 'package:greendrop/src/presentation/cart/provider/ordertype_toggle_provider.dart';
import 'package:provider/provider.dart';


class OrderTypeToggleWidget extends StatelessWidget {
  final OrderTypeToggleProvider toggleProvider;

  const OrderTypeToggleWidget({super.key, required this.toggleProvider});


  @override
  Widget build(BuildContext context) {
   

    return GestureDetector(
      onTap: () {
        toggleProvider.toggle(); // Toggle the state
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: 60,
        height: 30,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: toggleProvider.isToggled ? Colors.green : Colors.grey,
        ),
                child: Stack(
                  
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 3.0),
              child: AnimatedAlign(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                alignment: toggleProvider.isToggled
                    ? Alignment.centerRight
                    : Alignment.centerLeft,
                  child: Container(
                    width: 24,
                    height: 24,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                  child: Icon(
                    toggleProvider.isToggled ? Icons.delivery_dining : Icons.restaurant,
                    size: 16,
                    color: toggleProvider.isToggled ? Colors.green : Colors.grey,
                  ),
                ),
              ),
          )
          ],
        ),
      ),
    );
  }
}