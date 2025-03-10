import 'package:atomshop/features/orders/model/order_model.dart';
import 'package:atomshop/local_storage/local_storage_methods.dart';
import 'package:atomshop/network/network_manager/network_manager.dart';
import 'package:get/get.dart';

class OrderController extends GetxController {
  var isLoading = true.obs;
  var orders = <OrderModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchOrders();
  }

  Future<void> fetchOrders() async {
    try {
      isLoading(true);
      var response = await NetworkManager().postRequest(
        'account/my-orders',
        {"uuid": LocalStorageMethods.instance.getUserUUID()},
      );

      if (response['success']) {
        var ordersList = (response['data'] as List)
            .map((json) => OrderModel.fromJson(json))
            .toList();
        orders.value = ordersList;
      }
    } catch (e) {
      print("Error fetching orders: $e");
    } finally {
      isLoading(false);
    }
  }
}
