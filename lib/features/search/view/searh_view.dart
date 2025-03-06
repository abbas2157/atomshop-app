import 'package:atomshop/common/constants/app_constants.dart';
import 'package:atomshop/common/widgets/logo.dart';
import 'package:atomshop/extenstion/padding_extension.dart';
import 'package:atomshop/features/featured_products/view/single_product_detail_view.dart';
import 'package:atomshop/features/search/controller/search_products_controller.dart';
import 'package:atomshop/features/search/widgets/textfield.dart';
import 'package:atomshop/local_storage/local_storage_methods.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';

class SearchView extends StatelessWidget {
  final SearchProductsController controller =
      Get.put(SearchProductsController());
  final TextEditingController searchController = TextEditingController();

  SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: AppBar(
        title: logo(height: 100),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        forceMaterialTransparency: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Refined logo presentation

            SizedBox(
              height: 20,
            ),
            // Premium search field
            SearchTextField(
              controller: searchController,
              onSearch: (query) {
                if (query.isEmpty) {
                  controller.showRecentSearches();
                } else {
                  controller.searchProductsDebounced(query);
                }
              },
              onClear: () {
                searchController.clear();
                controller.clearSearchResults();
              },
            ),

            const SizedBox(height: 24),

            // Reactive UI section
            GetBuilder<SearchProductsController>(
              builder: (controller) {
                if (searchController.text.isEmpty) {
                  return _buildRecentSearches();
                } else if (controller.isLoading) {
                  return const Expanded(
                    child: Center(
                      child: SizedBox(
                        width: 28,
                        height: 28,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.5,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.blueAccent),
                        ),
                      ),
                    ),
                  );
                } else if (controller.searchProducts.isEmpty) {
                  return Expanded(
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.search_off,
                              size: 48, color: Colors.grey[300]),
                          const SizedBox(height: 16),
                          Text(
                            "No products found",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey[500],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  return Expanded(child: _buildSearchResults());
                }
              },
            ),
          ],
        ).paddingHorizontel(AppConstants.HorizontelPadding),
      ),
    );
  }

  // Refined search results with subtle shadows and spacing
  Widget _buildSearchResults() {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.only(top: 4, bottom: 16),
      itemCount: controller.searchProducts.length,
      itemBuilder: (context, index) {
        final product = controller.searchProducts[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                offset: const Offset(0, 2),
                blurRadius: 6,
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () {
                // Product details navigation would go here
                Get.to(()=>SingleProductDetailView(productId: product.id!));
              },
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    // Product image with subtle border
                    Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey.shade100),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CachedNetworkImage(
                          imageUrl: product.picture ?? "",
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Center(
                            child: SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.grey.shade300),
                              ),
                            ),
                          ),
                          errorWidget: (context, url, error) => Container(
                            color: Colors.grey.shade100,
                            child: Icon(Icons.image_not_supported,
                                size: 30, color: Colors.grey.shade400),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),

                    // Product information with clean typography
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.title ?? "",
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF2C2C2C),
                              height: 1.3,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 3),
                                decoration: BoxDecoration(
                                  color: Colors.blueAccent.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  product.category ?? "",
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.blueAccent,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                product.brand ?? "",
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // Subtle navigation indicator
                    Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 14,
                        color: Colors.grey.shade400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  // Redesigned recent searches with elegant chips
  Widget _buildRecentSearches() {
    if (controller.recentSearches.isEmpty) {
      return Expanded(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.history, size: 48, color: Colors.grey[200]),
              const SizedBox(height: 16),
              Text(
                "No recent searches",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[400],
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Recent Searches",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Color(0xFF2C2C2C),
                ),
              ),
              if (controller.recentSearches.length > 1)
                TextButton(
                  onPressed: () {
                    // Clear all recent searches functionality would go here
                    controller.recentSearches.clear();
                    LocalStorageMethods.instance.clearAllRecentSearches();
                    controller.update();
                  },
                  style: TextButton.styleFrom(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Text(
                    "Clear All",
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: controller.recentSearches.map((query) {
              return GestureDetector(
                onTap: () {
                  searchController.text = query;
                  controller.searchProductsDebounced(query);
                },
                child: Container(
                  decoration: BoxDecoration(
                    // ignore: deprecated_member_use
                    color: Colors.blueAccent.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 12, top: 8, bottom: 8),
                        child: Text(
                          query,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: Colors.blueAccent,
                          ),
                        ),
                      ),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(12),
                          onTap: () => controller.removeRecentSearch(query),
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Icon(
                              Icons.close,
                              size: 14,
                              color: Colors.blueAccent.withOpacity(0.7),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
