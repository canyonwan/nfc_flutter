import 'package:get/get.dart';
import 'package:mallxx_app/app/models/refund_order_detail_model.dart';
import 'package:mallxx_app/app/modules/root/providers/cart_provider.dart';

class MyRefundOrderDetailController extends GetxController
    with StateMixin<bool> {
  final CartProvider _cartProvider = Get.find<CartProvider>();

  int orderId = 0; // 订单id
  bool loading = true;

  RefundOrderDetailDataModel data = RefundOrderDetailDataModel();

  @override
  void onInit() {
    orderId = Get.arguments['orderId'];
    super.onInit();
  }

  @override
  void onReady() {
    getRefundOrderDetail();
    super.onReady();
  }

  // 退款订单详情
  Future<void> getRefundOrderDetail() async {
    change(loading, status: RxStatus.loading());
    final res = await _cartProvider.refundOrderDetail(orderId);
    if (res.code == 200 && res.data != null) {
      data = res.data!;
      update();
      loading = false;
      change(loading, status: RxStatus.success());
    }
  }
}
