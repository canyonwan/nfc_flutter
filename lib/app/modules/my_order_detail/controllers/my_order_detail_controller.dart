import 'package:get/get.dart';
import 'package:mallxx_app/app/models/order_detail_model.dart';
import 'package:mallxx_app/app/modules/root/providers/cart_provider.dart';

class MyOrderDetailController extends GetxController with StateMixin<bool> {
  final CartProvider _cartProvider = Get.find<CartProvider>();

  int orderId = 0; // 订单id
  bool loading = true;

  OrderDetailDataModel data = OrderDetailDataModel();

  @override
  void onInit() {
    orderId = Get.arguments['orderId'];
    super.onInit();
  }

  @override
  void onReady() {
    getOrderDetail();
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  // 订单详情
  Future<void> getOrderDetail() async {
    change(loading, status: RxStatus.loading());
    final res = await _cartProvider.orderDetail(orderId);
    if (res.code == 200 && res.data != null) {
      data = res.data!;
      loading = false;
      update();
      change(loading, status: RxStatus.success());
    }
  }
}
