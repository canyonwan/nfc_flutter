import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mallxx_app/app/models/my_order_model.dart';
import 'package:mallxx_app/app/modules/root/providers/cart_provider.dart';
import 'package:mallxx_app/app/routes/app_pages.dart';
import 'package:mallxx_app/utils/enums.dart';
import 'package:oktoast/oktoast.dart';

class MyOrderController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final EasyRefreshController easyRefreshController = EasyRefreshController(
    controlFinishLoad: true,
    controlFinishRefresh: true,
  );

  late TabController tabController;

  final CartProvider _cartProvider = Get.find<CartProvider>();

  final List<String> tabs = ['全部', '待付款', '待发货', '待收货', '待评价'];

  MyOrderDataModel? data;
  int totalPage = 0;
  int page = 1;
  int currentType = 1;
  List<OrderItemModel> orderList = [];
  String reason = ''; // 退款原因

  @override
  void onInit() {
    tabController = TabController(length: tabs.length, vsync: this);
    currentType = Get.arguments['type'];
    tabController.index = currentType - 1;
    getOrderList();
    super.onInit();
  }

  @override
  void onClose() {
    tabController.dispose();
    easyRefreshController.dispose();
  }

  void onSelect(int index) {
    currentType = index + 1;
    easyRefreshController.callRefresh();
  }

  Future<void> getOrderList() async {
    final res = await _cartProvider.queryMyOrderList(currentType, page);
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

  // 取消订单
  // 二次确认弹窗
  Future<void> onCancelOrder(String paymentCode) async {
    final res = await _cartProvider.cancelOrder(paymentCode);
    showToast(res.msg);
    await easyRefreshController.callRefresh();
    Get.back();
    easyRefreshController.callRefresh();
  }

  // 去付款
  // 支付页面
  Future<void> onToPayment(OrderItemModel orderModel) async {
    await Get.toNamed(Routes.ORDER_PAYMENT, arguments: {
      'payPrice': orderModel.orderAmount,
      'paymentNum': orderModel.paymentNum,
      'payType': PayTypeEnum.cart
    });
    easyRefreshController.callRefresh();
  }

  // 申请退款
  Future<void> onApplyForRefund(String paymentCode) async {
    // 弹窗二次确认  输入原因
    final res = await _cartProvider.orderRefund(paymentCode, reason);
    showToast(res.msg);
    Get.back();
    easyRefreshController.callRefresh();
  }

  // 查看物流
  // 进入订单详情
  Future<void> showLogistics(int orderId, String orderState) async {
    if (orderState == '6') {
      await Get.toNamed(
        Routes.MY_REFUND_ORDER_DETAIL,
        arguments: {'orderId': orderId},
      );
    } else {
      await Get.toNamed(
        Routes.MY_ORDER_DETAIL,
        arguments: {'orderId': orderId},
      );
    }
    easyRefreshController.callRefresh();
  }

  // 确认收货
  // 二次确认弹窗
  Future<void> confirmGoods(int order_id) async {
    await _cartProvider.confirmReceipt(order_id);
    easyRefreshController.callRefresh();
  }

  // 删除订单
  // 二次确认弹窗
  Future<void> deleteOrder(int order_id) async {
    await _cartProvider.delOrder(order_id);
    easyRefreshController.callRefresh();
  }

  // 查看订单
  // 进入订单详情
  Future<void> showOrder(int orderId, String orderState) async {
    if (orderState == '6') {
      await Get.toNamed(
        Routes.MY_REFUND_ORDER_DETAIL,
        arguments: {'orderId': orderId},
      );
    } else {
      await Get.toNamed(
        Routes.MY_ORDER_DETAIL,
        arguments: {'orderId': orderId},
      );
    }
    easyRefreshController.callRefresh();
  }

  // 退款原因
  void onReasonChanged(String value) {
    reason = value;
  }

  // 去评价
  Future<void> onToAppraise(int orderId, int goodsId, String img) async {
    await Get.toNamed(
      Routes.APPRAISE_ORDER,
      arguments: {'orderId': orderId, 'goodsId': goodsId, 'img': img},
    );
    easyRefreshController.callRefresh();
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
}
