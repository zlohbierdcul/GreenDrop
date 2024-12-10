import 'package:flutter/material.dart';
import 'package:greendrop/src/domain/models/order.dart';
import 'package:greendrop/src/presentation/products/provider/cart_provider.dart';
import 'package:provider/provider.dart';

import '../../../domain/models/product.dart';
import '../provider/order_provider.dart';

class OrderProductList extends StatelessWidget {
  const OrderProductList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<CartProvider, OrderProvider>(
      builder: (context, cartProvider, orderProvider, child) {
        final totalCost = cartProvider.getTotalCosts();
        final discount = orderProvider.discount.value / 100;
        final finalAmount = totalCost - discount;

        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Table(
                  columnWidths: const {
                    0: FixedColumnWidth(40), // Fixed width of 50 pixels
                    1: FlexColumnWidth(3), // Proportional width with weight 2
                    2: FlexColumnWidth(2), // Proportional width with weight 1
                    3: FlexColumnWidth(2),
                  },
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  children: [
                    // Header Row
                    _buildHeaderRow(context),
                    // Product Rows
                    ...cartProvider.cart.entries
                        .map((entry) => _buildProductRow(entry)),
                    // Discount Row (if applicable)
                    if (discount > 0) _buildDiscountRow(discount),
                    // Total Row
                    _buildTotalRow(finalAmount),
                  ],
                ),
                const SizedBox(height: 50),
              ],
            ),
          ),
        );
      },
    );
  }

  TableRow _buildHeaderRow(BuildContext context) {
    return TableRow(
      decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black))),
      children: [
        const SizedBox.shrink(),
        _buildTableCell("Produkt", isHeader: true),
        _buildTableCell("Einzel-Preis", isHeader: true),
        _buildTableCell("Gesamt-Preis", isHeader: true),
      ],
    );
  }

  TableRow _buildProductRow(MapEntry<Product, int> entry) {
    return TableRow(
      children: [
        _buildTableCell("${entry.value}", isHeader: false),
        _buildTableCell(entry.key.name, isHeader: false),
        _buildTableCell("${entry.key.price.toStringAsFixed(2)}€",
            isHeader: false, alignment: TextAlign.right),
        _buildTableCell(
            "${(entry.key.price * entry.value).toStringAsFixed(2)}€",
            isHeader: false,
            alignment: TextAlign.right),
      ],
    );
  }

  TableRow _buildDiscountRow(double discount) {
    return TableRow(
      children: [
        _buildTableCell("", isHeader: false),
        _buildTableCell("Rabatt", isHeader: true),
        _buildTableCell("", isHeader: false),
        _buildTableCell("-${discount.toStringAsFixed(2)}€",
            isHeader: false, alignment: TextAlign.right),
      ],
    );
  }

  TableRow _buildTotalRow(double finalAmount) {
    return TableRow(
      decoration:
          const BoxDecoration(border: Border(top: BorderSide(width: 1.0))),
      children: [
        const SizedBox.shrink(),
        _buildTableCell("Gesamt", isHeader: true),
        const SizedBox.shrink(),
        _buildTableCell("${finalAmount.toStringAsFixed(2)}€",
            isHeader: true, alignment: TextAlign.right),
      ],
    );
  }

  static Widget _buildTableCell(String content,
      {bool isHeader = false, TextAlign alignment = TextAlign.left}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        content,
        style: TextStyle(
          fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
        ),
        textAlign: alignment,
      ),
    );
  }
}
