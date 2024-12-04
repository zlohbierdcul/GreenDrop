import 'package:flutter/material.dart';
import 'package:greendrop/src/domain/enums/payment_methods.dart';
import 'package:greendrop/src/presentation/order/provider/order_provider.dart';
import 'package:provider/provider.dart';

class OrderPaymentSelection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Consumer<OrderProvider>(
        builder: (context, orderProvider, child) => Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Zahlungsart:",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              ...PaymentMethods.values.map((paymentMethod) {
                return RadioListTile<PaymentMethods>(
                  value: paymentMethod,
                  groupValue: orderProvider.paymentMethod,
                  title: Text(paymentMethod.label),
                  onChanged: (_) =>
                      orderProvider.setPaymentMethod(paymentMethod),
                  selected: orderProvider.paymentMethod == paymentMethod,
                  mouseCursor: SystemMouseCursors.click,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}
