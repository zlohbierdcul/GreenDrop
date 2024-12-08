import 'package:flutter/material.dart';
import 'package:greendrop/src/domain/enums/payment_methods.dart';
import 'package:greendrop/src/presentation/order/provider/order_provider.dart';
import 'package:provider/provider.dart';

class OrderPaymentSelection extends StatelessWidget {
  const OrderPaymentSelection({super.key});

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
                  title: Row(
                    children: [
                      paymentMethod.icon ?? const SizedBox(),
                      paymentMethod.label != null ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(paymentMethod.label!),
                      ) : const SizedBox(),
                      paymentMethod.image != null ? SizedBox(height: 20, child: Image.asset(paymentMethod.image!)) : const SizedBox(), 
                    ],
                  ),
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
