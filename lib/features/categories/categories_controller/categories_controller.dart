import 'package:atomshop/features/categories/model/category_model.dart';
import 'package:atomshop/features/categories/model/category_product_model.dart';
import 'package:atomshop/network/network_manager/network_manager.dart';
import 'package:atomshop/network/urls/app_urls.dart';
import 'package:get/state_manager.dart';
import 'package:get/get.dart';

class CategoriesController extends GetxController {
  final RxList<CategoryModel> categories = <CategoryModel>[].obs;
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  ////////////////////////////////////////////////////////////////
  final RxList<CategoryProductModel> categoryProducts =
      <CategoryProductModel>[].obs;
  final RxBool isLoadingCategoryProducts = false.obs;
  final RxString errorMessageCategoryProducts = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }

  /// Fetch categories from API
  Future<void> fetchCategories() async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      final response = await NetworkManager().getRequest(AppUrls.categories);

      if (response['success']) {
        final List<dynamic> categoryList =
            response['data']; // API pagination structure
        categories.value =
            categoryList.map((json) => CategoryModel.fromJson(json)).toList();
      } else {
        errorMessage.value =
            response['message'] ?? 'Failed to fetch categories';
      }
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchCategoryProducts(String categoryId) async {
    isLoadingCategoryProducts.value = true;
    errorMessageCategoryProducts.value = '';

    try {
      final response =
          await NetworkManager().getRequest("products/category/$categoryId");

      if (response['success']) {
        final List<dynamic> categoryproductsList =
            response['data']; // API pagination structure
        categoryProducts.value = categoryproductsList
            .map((json) => CategoryProductModel.fromJson(json))
            .toList();
      } else {
        errorMessageCategoryProducts.value =
            response['message'] ?? 'Failed to fetch categories products';
      }
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoadingCategoryProducts.value = false;
    }
  }
}
