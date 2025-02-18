import 'package:atomshop/features/featured_products/model/single_product_detail_model.dart';
import 'package:atomshop/network/network_manager/network_manager.dart';
import 'package:get/get.dart';

class ProductDetailController extends GetxController {
  var isLoading = true.obs;
  var productDetail = Rxn<ProductDetailModel>();
  var selectedVariationPrice = 0.obs;
  var selectedColor = Rxn<int>(); // Tracks selected color ID
  var selectedMemory = Rxn<int>(); // Tracks selected memory ID

  RxInt currentPage = 0.obs;
  // List<String> images = [];
  void fetchProductDetails(int productId) async {
    try {
      isLoading(true);
      final response = await NetworkManager().getRequest('products/$productId');
      productDetail.value = ProductDetailModel.fromJson(response['data']);

      // Set default price and selections
      selectedVariationPrice.value = productDetail.value!.variationPrice;
      selectedColor.value = productDetail.value!.colors.first.id;
      selectedMemory.value = productDetail.value!.memories.first.id;
     // images = [productDetail.value!.picture, ...productDetail.value!.gallery];
    } catch (e) {
      print("Error fetching product: $e");
    } finally {
      isLoading(false);
    }
  }

  void updateSelectedColor(int colorId) {
    selectedColor.value = colorId;
  }

  void updateSelectedMemory(ProductVariant memory) {
    selectedMemory.value = memory.id;
    selectedVariationPrice.value =
        memory.variationPrice ?? productDetail.value!.variationPrice;
  }
}
