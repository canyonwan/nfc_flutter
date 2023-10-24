import 'package:easy_refresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:mallxx_app/app/modules/root/providers/cart_provider.dart';
import 'package:mallxx_app/app/routes/app_pages.dart';

import '../../../models/my_order_model.dart';

class MyRefundOrderController extends GetxController {
  final EasyRefreshController easyRefreshController = EasyRefreshController(
    controlFinishLoad: true,
    controlFinishRefresh: true,
  );

  final CartProvider _cartProvider = Get.find<CartProvider>();

  MyOrderDataModel? data;
  int totalPage = 0;
  int page = 1;
  List<OrderItemModel> orderList = [];

  @override
  void onInit() {
    getOrderList();
    super.onInit();
  }

  Future<void> getOrderList() async {
    final res = await _cartProvider.queryMyOrderList(6, page);
    if (res.code == 200) {
      if (res.data != null) {
        data = res.data!;
        totalPage = data!.totalPage;
        if (res.data!.orderList!.isNotEmpty) {
          orderList.addAll(res.data!.orderList!);
        }
      } else {
        orderList.clear();
      }
      update();
    }
  }

  Future<void> onRefresh() async {
    page = 1;
    if (orderList.isNotEmpty) {
      orderList.clear();
    }
    await getOrderList();
    easyRefreshController.finishRefresh();
  }

  Future<void> onLoadMore() async {
    if (page < totalPage) {
      page++;
      await getOrderList();
      easyRefreshController.finishLoad();
    } else {
      easyRefreshController.finishLoad(IndicatorResult.noMore);
    }
  }

  Future<void> onToOrderView(int orderId, String orderState) async {
    if (orderState == '6') {
      await Get.toNamed(
        Routes.MY_REFUND_ORDER_DETAIL,
        arguments: {'orderId': orderId},
      );
    } else {
      await Get.toNamed(Routes.MY_ORDER_DETAIL,
          arguments: {'orderId': orderId});
    }
    easyRefreshController.callRefresh();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
