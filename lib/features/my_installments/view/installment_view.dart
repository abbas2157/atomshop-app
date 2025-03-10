import 'package:atomshop/features/my_installments/controller/installmetn_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class InstallmentHistoryScreen extends StatelessWidget {
  final InstallmentController controller = Get.put(InstallmentController());

  InstallmentHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Installment History"),
        backgroundColor: Colors.transparent,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            
            
            columns: [
              DataColumn(
                
                  label: Text("Month",
                      style: TextStyle(fontWeight: FontWeight.bold))),
              DataColumn(
                  label: Text("Amount",
                      style: TextStyle(fontWeight: FontWeight.bold))),
              DataColumn(
                  label: Text("Payment Date",
                      style: TextStyle(fontWeight: FontWeight.bold))),
              DataColumn(
                  label: Text("Method",
                      style: TextStyle(fontWeight: FontWeight.bold))),
              DataColumn(
                  label: Text("Receipt",
                      style: TextStyle(fontWeight: FontWeight.bold))),
              DataColumn(
                  label: Text("Status",
                      style: TextStyle(fontWeight: FontWeight.bold))),
            ],
            rows: controller.installments.map((installment) {
              return DataRow(cells: [
                DataCell(Text(installment.month)),
                DataCell(Text("Rs. ${installment.installmentPrice}")),
                DataCell(Text(installment.paymentDate.isNotEmpty
                    ? installment.paymentDate
                    : "-")),
                DataCell(Text(installment.paymentMethod ?? "-")),
                DataCell(
                  installment.receipet == "-" || installment.receipet.isEmpty
                      ? Text("-")
                      : GestureDetector(
                          onTap: () {
                            // Open receipt URL in browser
                            Get.to(() => ViewReceiptScreen(
                                  receiptUrl: installment.receipet,
                                ));
                          },
                          child: Text("View",
                              style: TextStyle(
                                  color: Colors.blue,
                                  decoration: TextDecoration.underline)),
                        ),
                ),
                DataCell(
                  installment.status == "Paid"
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

class ViewReceiptScreen extends StatelessWidget {
  const ViewReceiptScreen({super.key, required this.receiptUrl});
  final String receiptUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Payment Receipt")),
      body: Center(
        child: receiptUrl.isNotEmpty
            ? ElevatedButton(
                onPressed: () {
                  // Open receipt URL in browser
                  launchUrl(Uri.parse(receiptUrl));
                },
                child: Text("Open Receipt"),
              )
            : Text("No Receipt Available"),
      ),
    );
  }
}
