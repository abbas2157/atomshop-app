import 'dart:async';

import 'package:atomshop/features/search/model/search_products_model.dart';
import 'package:atomshop/network/network_manager/network_manager.dart';
import 'package:get/get.dart';

import '../../../local_storage/local_storage_methods.dart';

class SearchProductsController extends GetxController {
  bool isLoading = false;
  List<SearchProductsModel> searchProducts = [];
  List<String> recentSearches = [];
  Timer? _debounce;

  @override
  void onInit() {
    loadRecentSearches();
    super.onInit();
  }

  void loadRecentSearches() {
    recentSearches = LocalStorageMethods.instance.getRecentSearches();
    update();
  }

  void addToRecentSearches(String query) {
    if (query.isNotEmpty && !recentSearches.contains(query)) {
      recentSearches.insert(0, query);
      if (recentSearches.length > 10) {
        recentSearches.removeLast(); // Keep last 10 searches
      }
      LocalStorageMethods.instance.saveRecentSearch(query);
      update();
    }
  }

  void removeRecentSearch(String query) {
    recentSearches.remove(query);
    LocalStorageMethods.instance.clearRecentSearch(query);
    update();
  }

  void showRecentSearches() {
    loadRecentSearches();
    update();
  }

  void clearSearchResults() {
    searchProducts.clear();
    showRecentSearches();
    update();
  }

  void searchProductsDebounced(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 600), () => fetchProducts(query));
  }

  Future<void> fetchProducts(String query) async {
    if (query.isEmpty) return;
    try {
      isLoading = true;
      update();
      
      var response = await NetworkManager().getRequest('products?q=$query');
      if (response['success'] == true) {
        var products = response['data'] as List;
        searchProducts = products.map((json) => SearchProductsModel.fromJson(json)).toList();
        addToRecentSearches(query);
      }
    } catch (e) {
      print("Error fetching search products: $e");
    } finally {
      isLoading = false;
      update();
    }
  }
}
