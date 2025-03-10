import 'package:atomshop/features/payments/model/payment_model.dart';
import 'package:atomshop/local_storage/local_storage_methods.dart';
import 'package:atomshop/network/network_manager/network_manager.dart';
import 'package:get/get.dart';

class PaymentController extends GetxController {
  var payments = <PaymentModel>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    fetchPayments();
    super.onInit();
  }

  Future<void> fetchPayments() async {
    try {
      isLoading(true);
      final response = await NetworkManager().postRequest(
          'account/payment-history',
          {"uuid": LocalStorageMethods.instance.getUserUUID()});

      if (response['success']) {
        payments.value = (response['data'] as List)
            .map((e) => PaymentModel.fromJson(e))
            .toList();
      }
    } catch (e) {
      print("Error fetching payments: $e");
    } finally {
      isLoading(false);
    }
  }
}
