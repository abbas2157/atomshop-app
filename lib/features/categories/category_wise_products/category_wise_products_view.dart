import 'package:atomshop/features/categories/category_wise_products/controller/categories_wise_products_controller.dart';
import 'package:atomshop/features/categories/category_wise_products/model/category_wise_product_model.dart';
import 'package:atomshop/features/featured_products/view/single_product_detail_view.dart';
import 'package:atomshop/style/text_style/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class CategoryWiseProducts extends StatelessWidget {
  CategoryWiseProducts({super.key, required this.id, required this.name});
  final CategoriesWiseProductsController controller =
      Get.put(CategoriesWiseProductsController());
  final String id;
  final String name;

  @override
  Widget build(BuildContext context) {
    controller.fetchProducts(id);
    return Scaffold(
        appBar: AppBar(
          forceMaterialTransparency: true,
          backgroundColor: Colors.transparent,
          title: Text(name, style: AppTextStyles.headline3),
        ),
        body: Obx(() {
          if (controller.isLoading.value) {
            return _buildShimmerGrid();
          }
          if (controller.categoryProducts.isEmpty) {
            return Center(child: Text("No products available"));
          }
          return GridView.builder(
            padding: EdgeInsets.all(12),
            shrinkWrap: true,
           // physics: NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200, // Max width per item
              crossAxisSpacing: 20,
              mainAxisSpacing: 10,
              childAspectRatio: 0.9, // Adjust ratio for responsiveness
            ),
            itemCount: controller.categoryProducts.length,
            itemBuilder: (context, index) {
              final product = controller.categoryProducts[index];
              return CategoryWiseProductCard(product: product);
            },
          );
        }));
  }

  Widget _buildShimmerGrid() {
    return GridView.builder(
      padding: EdgeInsets.all(12),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 1.1,
      ),
      itemCount: 6,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            height: 180,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );
      },
    );
  }
}

class CategoryWiseProductCard extends StatefulWidget {
  final CategoryWiseProductModel product;
  const CategoryWiseProductCard({super.key, required this.product});

  @override
  State<CategoryWiseProductCard> createState() =>
      _CategoryWiseProductCardState();
}

class _CategoryWiseProductCardState extends State<CategoryWiseProductCard> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double imageHeight = constraints.maxWidth * 0.5;
        return GestureDetector(
          onTap: () {
            Get.to(() => SingleProductDetailView(productId: widget.product.id));
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
              border: Border.all(color: Colors.grey.shade300),
            ),
            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: SizedBox(
                    height: imageHeight,
                    child: Image.network(
                      widget.product.image,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            width: double.infinity,
                            color: Colors.white,
                          ),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) => Icon(
                        Icons.image_not_supported,
                        size: imageHeight * 0.5,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  widget.product.name,
                  style: AppTextStyles.headline3.copyWith(
                    fontSize: constraints.maxWidth * 0.08, // Scalable text
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4),
                Text(
                  "Available on installments",
                  style: AppTextStyles.normal.copyWith(
                    fontSize: constraints.maxWidth * 0.07,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                Text(
                  "Advance: RS.${widget.product.price}",
                  style: AppTextStyles.normal.copyWith(
                    fontSize: constraints.maxWidth * 0.07,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey.shade700,
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isFavorite = !isFavorite;
                      });
                    },
                    child: AnimatedSwitcher(
                      duration: Duration(milliseconds: 300),
                      transitionBuilder:
                          (Widget child, Animation<double> animation) {
                        return ScaleTransition(scale: animation, child: child);
                      },
                      child: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: Colors.redAccent,
                        size:
                            constraints.maxWidth * 0.1, // Responsive icon size
                        key: ValueKey<bool>(isFavorite),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
