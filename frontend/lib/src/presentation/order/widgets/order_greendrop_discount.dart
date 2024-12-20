import 'package:flutter/material.dart';
import 'package:greendrop/src/presentation/account/provider/account_data_provider.dart';
import 'package:greendrop/src/presentation/common_widgets/dropdown.dart';
import 'package:greendrop/src/presentation/order/provider/order_provider.dart';
import 'package:provider/provider.dart';

class OrderGreendropDiscount extends StatelessWidget {
  const OrderGreendropDiscount({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Consumer2<AccountProvider, OrderProvider>(
            builder: (context, accountProvider, orderProvider, child) =>
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Rabatte:",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      CustomDropdownButton(
                          items: orderProvider.getUserDiscountOptions()
                              .map((discount) => DropdownMenuItem(
                                  value: discount.value,
                                  child: Text(discount.label)))
                              .toList(),
                          onChanged: (v) => orderProvider.setDiscount(v),
                          value: orderProvider.discount.value)
                    ],
                  ),
                )));
  }
}
