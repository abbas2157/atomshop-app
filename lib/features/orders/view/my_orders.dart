import 'package:atomshop/features/orders/controller/order_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


import 'package:shimmer/shimmer.dart';

class OrderHistoryScreen extends StatelessWidget {
  final OrderController controller = Get.put(OrderController());

  OrderHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Orders"),backgroundColor: Colors.transparent,),
      body: SafeArea(
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.orders.isEmpty) {
            return const Center(child: Text("No orders found."));
          }

          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  minWidth: 700, // 👈 Table ki minimum width set ki hai
                ),
                child: Table(
                  border: TableBorder.all(color: Colors.grey.shade300),
                  columnWidths: const {
                    0: FixedColumnWidth(60),
                    1: FixedColumnWidth(70),
                    2: FlexColumnWidth(2), // ✅ Zyada jagah milegi
                    3: FlexColumnWidth(1.2), // ✅ Payment wale text ke liye
                    4: FixedColumnWidth(130),
                  },
                  children: [
                    /// **Header Row**
                    TableRow(
                      decoration: BoxDecoration(color: Colors.black),
                      children: [
                        _buildTableHeaderCell("PR No"),
                        _buildTableHeaderCell("Image"),
                        _buildTableHeaderCell("Product Title"),
                        _buildTableHeaderCell("Payment Details"),
                        _buildTableHeaderCell("Status"),
                      ],
                    ),

                    /// **Dynamic Rows (With IntrinsicHeight)**
                    ...controller.orders.map((order) {
                      return TableRow(
                        children: [
                          _wrapIntrinsicHeight(_buildTableCell("PR-${order.id}")),
                          _wrapIntrinsicHeight(_buildImageCell(order.product.picture)),
                          _wrapIntrinsicHeight(_buildMultiLineCell(order.product.title)),
                          _wrapIntrinsicHeight(
                            _buildMultiLineCell(
                              "Advance: Rs. ${order.advancePrice}\n"
                              "Total: Rs. ${order.totalDealPrice}\n"
                              "Tenure: ${order.installmentTenure}M",
                            ),
                          ),
                          _wrapIntrinsicHeight(_buildStatusCell(order.status)),
                        ],
                      );
                    }).toList(),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  /// **Wraps Each Cell in IntrinsicHeight for Auto Row Height**
  Widget _wrapIntrinsicHeight(Widget child) {
    return IntrinsicHeight(child: child);
  }

  /// **Header Cell**
  Widget _buildTableHeaderCell(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.white),
        textAlign: TextAlign.center,
      ),
    );
  }

  /// **Normal Text Cell**
  Widget _buildTableCell(String text) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Text(text, textAlign: TextAlign.center),
    );
  }

  /// **Image Cell**
  Widget _buildImageCell(String imageUrl) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        width: 60,
        height: 60,
        fit: BoxFit.contain,
      ),
    );
  }

  /// **Multi-line Cell (Auto Adjust)**
  Widget _buildMultiLineCell(String text) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Text(
        text,
        textAlign: TextAlign.left,
        softWrap: true,
        overflow: TextOverflow.visible,
      ),
    );
  }

  /// **Status Chip**
  Widget _buildStatusCell(String status) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Chip(
        label: Text(status),
        backgroundColor: status == "Pending"
            ? Colors.orange.shade100
            : Colors.green.shade100,
      ),
    );
  }
}







class ShimmerLoader extends StatelessWidget {
  const ShimmerLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 5,
      itemBuilder: (context, index) {
        return Card(
          elevation: 4,
          margin: const EdgeInsets.only(bottom: 16),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12)),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            height: 16,
                            width: double.infinity,
                            color: Colors.white),
                        const SizedBox(height: 8),
                        Container(height: 14, width: 150, color: Colors.white),
                        const SizedBox(height: 8),
                        Container(height: 14, width: 100, color: Colors.white),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
