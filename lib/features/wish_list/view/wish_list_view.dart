import 'package:atomshop/common/constants/image_constants.dart';
import 'package:atomshop/common/widgets/common_button.dart';
import 'package:atomshop/common/widgets/loading.dart';
import 'package:atomshop/features/bottom_nav_bar/bottom_nav_bar_controller/bottom_nav_bar_controller.dart';
import 'package:atomshop/features/featured_products/view/single_product_detail_view.dart';
import 'package:atomshop/features/wish_list/controller/wishlist_controller.dart';
import 'package:atomshop/features/wish_list/model/wish_list_item_model.dart';
import 'package:atomshop/style/text_style/text_style.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class WishListView extends StatelessWidget {
  const WishListView({super.key});

  @override
  Widget build(BuildContext context) {
    final WishlistController controller = Get.put(WishlistController());
    controller.getWishListItems();
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Wishlist"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        forceMaterialTransparency: true,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.5), // Border height
          child: Container(
            color: Colors.grey.shade300, // Border color
            height: 1.5, // Border thickness
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
          child: Obx(() {
            if (controller.isLoading.value) {
              return _buildShimmerLoading();
            }

            if (controller.wishList.isEmpty) {
              return _buildEmptyState();
            }

            return GridView.builder(
              padding: const EdgeInsets.only(top: 10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.7,
              ),
              itemCount: controller.wishList.length,
              itemBuilder: (context, index) {
                final item = controller.wishList[index];
                return _buildWishListItem(item, controller);
              },
            );
          }),
        ),
      ),
    );
  }

  /// 🔹 Empty Wishlist UI
  Widget _buildEmptyState() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          AppImages.emptyCart,
          height: 200,
          width: 200,
        ),
        const SizedBox(height: 20),
        Text(
          "Your wishlist is empty",
          style: AppTextStyles.headline1,
        ),
        const SizedBox(height: 10),
        Text(
          "Tap the heart button to save your favorite items.",
          style: AppTextStyles.bodyText1.copyWith(color: Colors.grey),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 30),
        CommonButton(
          text: "Explore Categories",
          onPressed: () {
            final BottomNavController controller = Get.find();
            controller.changePage(1);
          },
        ),
      ],
    );
  }

  /// 🔹 Wishlist Item UI
  Widget _buildWishListItem(
      WishListItemModel item, WishlistController controller) {
    double screenWidth = Get.width;
    double cardWidth = screenWidth * 0.4; // 40% of screen width
    double imageSize = cardWidth * 0.6; // 60% of card width

    return InkWell(
      onTap: () {
        Get.to(() => SingleProductDetailView(productId: item.id ?? 0));
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: cardWidth,
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 6,
              spreadRadius: 2,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Wishlist Remove Icon
            Align(
              alignment: Alignment.topRight,
              child: InkWell(
                onTap: () {
                  controller.removeItem(item.id.toString());
                },
                child: CircleAvatar(
                  radius: cardWidth * 0.1, // 10% of card width
                  backgroundColor: Colors.red.shade50,
                  child: const Icon(Icons.delete, color: Colors.red),
                ),
              ),
            ),

            /// Product Image
            Expanded(
              child: Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: CachedNetworkImage(
                    imageUrl: item.picture ?? "",
                    fit: BoxFit.contain,
                    width: imageSize,
                    height: imageSize,
                    placeholder: (context, url) =>
                        ShimmerLoading(height: 180, borderRadius: 12),
                    errorWidget: (context, url, error) => const Icon(
                      Icons.image_not_supported,
                      size: 100,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),

            /// Product Title
            Text(
              item.title ?? "Product Name",
              style: AppTextStyles.headline3.copyWith(
                fontSize: cardWidth * 0.08, // Adjust font size
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),

            Text(
              item.brand!,
              style: AppTextStyles.bodyText1
                  .copyWith(fontSize: 12, fontWeight: FontWeight.w500),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 6),
            Text(
              "Available On Installment",
              style: AppTextStyles.bodyText1.copyWith(fontSize: 12),
              // maxLines: 1,
              overflow: TextOverflow.visible,
            ),
            const SizedBox(height: 6),

            /// Price
            Text(
              "Advance: RS.${item.price}",
              style: AppTextStyles.normal.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: cardWidth * 0.09,
              ),
            ),
            // IconButton(
            //     onPressed: () {
            //       final controller = Get.put(CartController());
            //     },
            //     icon: Row(
            //       children: [
            //         Text("Add to cart"),
            //         SizedBox(
            //           width: 10,
            //         ),
            //         Icon(
            //           Icons.shopping_cart,
            //           size: 20,
            //           color: Colors.black,
            //         ),
            //       ],
            //     ))
          ],
        ),
      ),
    );
  }

  /// 🔹 Shimmer Loading
  Widget _buildShimmerLoading() {
    return GridView.builder(
      padding: const EdgeInsets.only(top: 10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.7,
      ),
      itemCount: 6,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Card(
            elevation: 4,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Container(
              height: 200,
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }
}
