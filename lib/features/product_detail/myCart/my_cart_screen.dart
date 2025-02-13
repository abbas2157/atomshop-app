import 'package:atomshop/features/product_detail/myCart/widgets/cart_item_widget.dart';
import 'package:atomshop/style/colors/app_colors.dart';
import 'package:flutter/material.dart';

import '../model/my_cart_model.dart';

class CartScreen extends StatelessWidget {
  final List<CartItem> cartItems = [
    CartItem(
      image: 'assets/images/magnetic_watch.png',
      name: 'Loop Silicone Strong Magnetic Watch',
      price: 15.25,
      oldPrice: 20.00,
      quantity: 1,
    ),
    CartItem(
      image: 'assets/images/smart_watch.png',
      name: 'M6 Smart Watch IP67 Waterproof',
      price: 12.00,
      oldPrice: 18.00,
      quantity: 1,
    ),
  ];

  CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Cart', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text(
              'Voucher Code',
              style: TextStyle(color: AppColors.secondaryLight, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final item = cartItems[index];
                return CartItemWidget(item: item);
              },
            ),
          ),
          _buildOrderSummary(),
        ],
      ),
    );
  }

  Widget _buildOrderSummary() {
    double subtotal = cartItems.fold(0, (sum, item) => sum + (item.price * item.quantity));

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 8, spreadRadius: 2),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Order Info', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Subtotal', style: TextStyle(fontSize: 14)),
              Text('\$${subtotal.toStringAsFixed(2)}', style: const TextStyle(fontSize: 14)),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text('Shipping Cost', style: TextStyle(fontSize: 14)),
              Text('\$0.00', style: TextStyle(fontSize: 14)),
            ],
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Total', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              Text('\$${subtotal.toStringAsFixed(2)}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            child: Text('Checkout (${cartItems.length})', style: const TextStyle(fontSize: 16, color: Colors.white)),
          ),
        ],
      ),
    );
  }
}