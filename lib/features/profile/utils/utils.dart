import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

Future<void> showLogoutDialog(BuildContext context, VoidCallback onConfirm) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text("Confirm Logout"),
      content: const Text("Are you sure you want to log out?"),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context), // Close dialog
          child: const Text("Cancel", style: TextStyle(color: Colors.grey)),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context); // Close dialog
            onConfirm(); // Perform logout action
          },
          child: const Text("Logout", style: TextStyle(color: Colors.red)),
        ),
      ],
    ),
  );
}

void showToastMessage(String message,{ToastGravity? gravity}) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: gravity ??ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 16.0);
}

String formatAmount(String amount, {String currencySymbol = 'Rs: '}) {
  final double _amount = double.parse(amount);
  final formatter = NumberFormat.currency(
    locale: 'en_PK', // You can change this based on your region
    symbol: currencySymbol,
    decimalDigits: 0, // Change this to 2 if you want decimal points
  );
  return formatter.format(_amount);
}
