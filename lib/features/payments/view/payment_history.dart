import 'package:atomshop/features/payments/controller/payment_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:url_launcher/url_launcher.dart';

class PaymentHistoryScreen extends StatelessWidget {
  final PaymentController controller = Get.put(PaymentController());

   PaymentHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Payment History"),backgroundColor: Colors.transparent,),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columns: [
              DataColumn(label: Text("Installment Month", style: TextStyle(fontWeight: FontWeight.bold))),
              DataColumn(label: Text("Amount", style: TextStyle(fontWeight: FontWeight.bold))),
              DataColumn(label: Text("Payment Date", style: TextStyle(fontWeight: FontWeight.bold))),
              DataColumn(label: Text("Payment Method", style: TextStyle(fontWeight: FontWeight.bold))),
              DataColumn(label: Text("Payment Receipt", style: TextStyle(fontWeight: FontWeight.bold))),
              DataColumn(label: Text("Status", style: TextStyle(fontWeight: FontWeight.bold))),
            ],
            rows: controller.payments.map((payment) {
              return DataRow(cells: [
                DataCell(Text(payment.id == 6 ? "Advance" : "Installment ${payment.id - 5}")),
                DataCell(Text("Rs. ${payment.installmentPrice}")),
                DataCell(Text(payment.paymentDate.isNotEmpty ? payment.paymentDate : "-")),
                DataCell(Text(payment.paymentMethod ?? "-")),
                DataCell(
                  payment.receipet == "-" || payment.receipet.isEmpty
                      ? Text("-")
                      : GestureDetector(
                          onTap: () {
                            launchUrl(Uri.parse(payment.receipet));
                          },
                          child: Text("View", style: TextStyle(color: Colors.orange, decoration: TextDecoration.underline)),
                        ),
                ),
                DataCell(
                  payment.status == "Paid"
                      ? Icon(Icons.check_circle, color: Colors.green)
                      : Icon(Icons.cancel, color: Colors.red),
                ),
              ]);
            }).toList(),
          ),
        );
      }),
    );
  }
}
