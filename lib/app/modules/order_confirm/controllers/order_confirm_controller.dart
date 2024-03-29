import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:mallxx_app/app/models/cart_create_order_model.dart';
import 'package:mallxx_app/app/modules/order_confirm/order_choose_coupon/views/order_choose_coupon_view.dart';
import 'package:mallxx_app/app/modules/root/providers/cart_provider.dart';
import 'package:mallxx_app/utils/enums.dart';
import 'package:oktoast/oktoast.dart';

import '/app/models/address_model.dart';
import '/app/models/order_confirm_model.dart';
import '/app/routes/app_pages.dart';
import '../providers/order_confirm_provider.dart';

class OrderConfirmController extends GetxController
    with StateMixin<CartCreateOrderDataModel> {
  final OrderConfirmProvider orderConfirmProvider =
      Get.find<OrderConfirmProvider>();
  final CartProvider cartProvider = Get.find<CartProvider>();

  MyAddressItem defaultAddress = MyAddressItem();
  final buyProductList = RxList<OrderFirmProduct>();

  // String cartIds = '';
  // String address = ''; // 收货地址
  String remarks = ''; // 备注
  // String goodsId = ''; // 商品页生成订单从商品详情传过来的商品id
  Map<String, dynamic> goodsMap = {};
  int? couponId = null; // 用户选择的代金券id
  int? shippingAddressId = null; // 收货地址id
  CartCreateOrderDataModel? cartCreateOrderData;

  // int orderSourceType = 0; // 订单来源

  @override
  void onInit() {
    // 这里为生成订单统一页面
    // 从商品页和购物车进入调用的接口不同
    // 这里定义商品页0;购物车1 2:礼品卡
    goodsMap = Get.arguments['goodsMap'];
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    if (goodsMap['orderSourceType'] == 1) {
      onCreateCartOrder();
    } else if (goodsMap['orderSourceType'] == 0) {
      onCreateGoodsOrder();
    } else if (goodsMap['orderSourceType'] == 2) {
      onCreateGiftCardOrder();
    }
  }

  // 选择收货地址
  Future<void> onAddress() async {
    MyAddressItem address =
        await Get.toNamed(Routes.ADDRESS_BOOK, arguments: {"isReturn": true});
    defaultAddress = address;
    shippingAddressId = address.id!;
    // await onCreateCartOrder();
    update();
  }

  // 进入页面, 生成购物车订单
  Future<void> onCreateCartOrder() async {
    change(null, status: RxStatus.loading());
    final res = await orderConfirmProvider.createCartOrder(
        goodsMap['cartIds'], goodsMap['address'],
        couponId: couponId, shippingAddressId: shippingAddressId);
    if (res.code == 200) {
      change(res.data, status: RxStatus.success());
      cartCreateOrderData = res.data!;
      defaultAddress = res.data!.showAddress!;
      shippingAddressId = res.data!.showAddress!.id!;
      update();
    } else {
      change(res.data, status: RxStatus.error(res.msg));
    }
  }

  // 提交订单
  //
  Future<void> onCommitCartOrder() async {
    EasyLoading.show();
    if (shippingAddressId != null) {
      final res = await orderConfirmProvider.cartCommitOrder(
          goodsMap['cartIds'], shippingAddressId!,
          couponId: couponId, remark: remarks);
      if (res.code == 200) {
        Get.toNamed(Routes.ORDER_PAYMENT, arguments: {
          'payPrice': cartCreateOrderData!.totalPrice,
          'orderCode': res.data!.orderSn!,
          'payType': PayTypeEnum.cart
        });
      } else {
        if (res.msg == '请先绑定手机号') {
          Get.toNamed(Routes.BINDTEL);
        }
      }
    } else {
      showToast('请选择收货地址');
    }
    EasyLoading.dismiss();
  }

  // 礼品卡生成订单
  Future<void> onCreateGiftCardOrder() async {
    change(null, status: RxStatus.loading());
    final res = await orderConfirmProvider.createGiftCardOrder(
      card_number: goodsMap['cardNumber'],
    );
    if (res.code == 200) {
      change(res.data, status: RxStatus.success());
      cartCreateOrderData = res.data!;
      defaultAddress = res.data!.showAddress!;
      shippingAddressId = res.data!.showAddress!.id!;
      update();
    } else {
      Get.back();
    }
  }

  // 提交订单
  Future<void> onCommitGoodsOrder() async {
    EasyLoading.show();
    if (shippingAddressId != null) {
      final res = await orderConfirmProvider.goodsCommitOrder(
          goodsMap['goodsId'], goodsMap['goodsNum'],
          shippingAddressId: shippingAddressId!,
          couponId: couponId,
          remark: remarks);
      if (res.code == 200) {
        Get.toNamed(Routes.ORDER_PAYMENT, arguments: {
          'payPrice': cartCreateOrderData!.totalPrice,
          'orderCode': res.data!.orderSn!,
          'payType': PayTypeEnum.goods
        });
      } else {
        if (res.msg == '请先绑定手机号') {
          Get.toNamed(Routes.BINDTEL);
        }
      }
    } else {
      showToast('请选择收货地址');
    }
    EasyLoading.dismiss();
  }

  // 提交礼品卡的订单
  Future<void> onCommitGiftCardOrder() async {
    EasyLoading.show();
    if (shippingAddressId != null) {
      final res = await orderConfirmProvider.commitGiftCardOrder(
        cardNumber: goodsMap['cardNumber'],
        shippingAddressId: shippingAddressId!,
      );
      if (res.code == 200) {
        Get.toNamed(Routes.MY_ORDER, arguments: {'type': 3});
      }
    } else {
      showToast('请选择收货地址');
    }
    EasyLoading.dismiss();
  }

  // 进入页面, 生成商品页订单
  Future<void> onCreateGoodsOrder() async {
    change(null, status: RxStatus.loading());
    final res = await orderConfirmProvider.createGoodsOrder(
        goodsMap['goodsId'], goodsMap['goodsNum'],
        address: goodsMap['address'],
        couponId: couponId,
        shippingAddressId: shippingAddressId);
    if (res.code == 200) {
      change(res.data, status: RxStatus.success());
      cartCreateOrderData = res.data!;
      defaultAddress = res.data!.showAddress!;
      shippingAddressId = res.data!.showAddress!.id!;
      update();
    } else {
      change(res.data, status: RxStatus.error(res.msg));
    }
  }

  // 选择代金券
  Future<void> onCoupon() async {
    final res = await Get.bottomSheet(
        OrderChooseCouponView(totalPrice: cartCreateOrderData!.totalPrice!));
    couponId = res;
    update();
    await onCreateCartOrder();
  }

  // 用户输入备注
  void onRemarkChange(String value) {
    remarks = value;
    update();
  }

  // 确认支付
  void onConfirmPay() {
    if (goodsMap['orderSourceType'] == 1) {
      onCommitCartOrder();
    } else if (goodsMap['orderSourceType'] == 0) {
      onCommitGoodsOrder();
    } else if (goodsMap['orderSourceType'] == 2) {
      onCommitGiftCardOrder();
    }
  }
}
