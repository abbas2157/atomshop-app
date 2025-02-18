import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../style/colors/app_colors.dart';
import '../../model/my_cart_model.dart';

class CartItemWidget extends StatelessWidget {
  final CartItem item;

  const CartItemWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(item.image, width: 100, height: 140, fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          width: 140,
                          child: Text(item.name, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold))
                      ),

                      Checkbox(value: true, onChanged: (bool? value){},activeColor: AppColors.secondaryLight,)
                    ],
                  ),
                  const SizedBox(height: 4),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        '\$${item.price.toStringAsFixed(2)}',
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.secondaryLight),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '\$${item.oldPrice.toStringAsFixed(2)}',
                        style: const TextStyle(fontSize: 12, color: Colors.grey, decoration: TextDecoration.lineThrough),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 35,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Row(
                          children: [
                            _buildQuantityButton(Icons.remove, () {}),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 4),
                              child: Text(item.quantity.toString(), style: const TextStyle(fontSize: 16)),
                            ),
                            _buildQuantityButton(Icons.add, () {}),
                          ],
                        ),
                      ),
                      //const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuantityButton(IconData icon, VoidCallback onPressed) {
    return IconButton(
      icon: Icon(icon, size: 18),
      onPressed: onPressed,
    );
  }
}