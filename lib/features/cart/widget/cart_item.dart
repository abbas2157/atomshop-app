import 'package:atomshop/features/cart/model/cart_item_model.dart';
import 'package:atomshop/features/featured_products/widgets/quantity_selector_button/quantity_selector_button.dart';
import 'package:atomshop/style/colors/app_colors.dart';
import 'package:atomshop/style/text_style/text_style.dart';
import 'package:flutter/material.dart';

class CartItemWidget extends StatelessWidget {
  final CartItemModel item;
  final VoidCallback onDeleteTap;

  const CartItemWidget({super.key, required this.item, required this.onDeleteTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                item.product?.picture ?? "",
                width: 80,
                height: 80,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    Icon(Icons.image_not_supported, size: 50, color: Colors.grey.shade400),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.product?.title ?? "",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.headline2,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Rs ${item.product?.price ?? "0"}',
                    style: AppTextStyles.bodyText1.copyWith(color: AppColors.secondaryLight),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: Icon(Icons.delete, color: Colors.red.shade400, size: 24),
              onPressed: onDeleteTap,
            ),
          ],
        ),
      ),
    );
  }
}
