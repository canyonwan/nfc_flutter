import 'package:get/get.dart';
import 'package:mallxx_app/app/models/cart_model.dart';
import 'package:mallxx_app/app/models/my_order_model.dart';
import 'package:mallxx_app/app/models/order_detail_model.dart';
import 'package:mallxx_app/app/models/refund_order_detail_model.dart';
import 'package:mallxx_app/app/models/splash.dart';
import 'package:mallxx_app/app/providers/base_provider.dart';
import 'package:mallxx_app/app/providers/login_provider.dart';

import '/app/models/cart_list_model.dart';
import '/app/models/response_model.dart';

class CartProvider extends BaseProvider {
  static const String getCartListUrl = "/api/member_cart_list";
  static const String getGoodsCountInCartUrl =
      "api/get_card_number"; // 获取购物车商品数量
  static const String addGoodsToCartUrl = "api/add_member_cart"; // 商品加入购物车
  static const String changeGoodsCountInCartUrl =
      "api/change_cart_num"; // 修改购物车数量
  static const String deleteGoodsInCartUrl = "/api/member_cart_del";
  static const String calcCartGoodsTotalPriceUrl = "/api/imputed_price";
  static const String delCartGoodsUrl = "/api/member_cart_del";
  static const String nowBuyUrl = "api/now_go_buy"; // 立即购买
  static const String myOrderUrl = "api/new_order_list"; // 我的订单列表
  static const String cancelOrderUrl = "api/cancel_order"; // 取消订单
  static const String delOrderUrl = 'api/del_order'; // 删除订单
  static const String confirmReceiptUrl = 'api/confirm_receipt'; // 确认收货
  static const String orderDetailUrl = 'api/order_detail'; // 订单详情
  static const String orderRefundUrl = 'api/apprefund'; // 退款
  static const String appraiseUrl = 'apitest/app_discuss'; // 评价
  static const String splashImageUrl = 'api/launch_image'; //
  static const String refundOrderDetailUrl =
      'api/member_refund_detail'; // 退款的订单详情

  final LoginProvider loginProvider = Get.find<LoginProvider>();

  @override
  void onInit() {
    super.onInit();
  }

  Future<CartListRootModel> getCartList({required String address}) async {
    final response = await post(getCartListUrl, {"address": address});
    return CartListRootModel.fromJson(response.body);
  }

  Future<ResponseData> modifyQuantity(
      {required int id, required int quantity}) async {
    var data = {"goods_id": id, "goods_num": quantity};
    final response = await post(changeGoodsCountInCartUrl, data);
    return ResponseData.fromJson(response.body);
  }

  Future<ResponseData> deleteCart(List<int> ids) async {
    String delId = "";
    for (int i = 0; i < ids.length; i++) {
      if (i == 0) {
        delId = delId + ids[i].toString();
      } else {
        delId = delId + ',' + ids[i].toString();
      }
    }
    final response =
        await post(deleteGoodsInCartUrl, {"member_cart_ids": delId});
    print(response.body);
    return ResponseData.fromJson(response.body);
  }

  Future<ResponseData> addGoodsToCart(int goodsId, int goodsCount) async {
    final response = await post(addGoodsToCartUrl, {
      "goods_id": goodsId,
      "goods_num": goodsCount,
    });
    return ResponseData.fromJson(response.body);
  }

  Future<GoodsCountInCartRootModel> queryGoodsCountInCart() async {
    final response = await post(getGoodsCountInCartUrl, {});
    return GoodsCountInCartRootModel.fromJson(response.body);
  }

  Future<CalcCartTotalPriceRootModel> queryCartGoodsTotalPrice(String cartIds,
      {String? address}) async {
    final response = await post(
        calcCartGoodsTotalPriceUrl, {'cart_ids': cartIds, 'address': address});
    return CalcCartTotalPriceRootModel.fromJson(response.body);
  }

  Future<ResponseData> queryDelCartGoods(
    String cartIds,
  ) async {
    final response = await post(delCartGoodsUrl, {'member_cart_ids': cartIds});
    return ResponseData.fromJson(response.body);
  }

  // 立即购买
  Future<ResponseData> nowBuy(int goodsId, int goodsNum,
      {String? address}) async {
    final response = await post(nowBuyUrl,
        {'goods_id': goodsId, 'goods_num': goodsNum, 'address': address});
    return ResponseData.fromJson(response.body);
  }

  // 我的订单列表
  // 订单列表:type 1=全部,2=待付款,3=待发货,4=待收货,5=待评价
  //         page 1
  Future<MyOrderRootModel> queryMyOrderList(int type, int page) async {
    final response = await post(myOrderUrl, {
      'type': type,
      'page': page,
    });
    return MyOrderRootModel.fromJson(response.body);
  }

  // 取消订单
  // payment_num 支付单号
  Future<ResponseData> cancelOrder(String payment_num) async {
    final response = await post(cancelOrderUrl, {'payment_num': payment_num});
    return ResponseData.fromJson(response.body);
  }

  // 删除订单
  Future<ResponseData> delOrder(int order_id) async {
    final response = await post(delOrderUrl, {'order_id': order_id});
    return ResponseData.fromJson(response.body);
  }

  // 确认收货
  Future<ResponseData> confirmReceipt(int order_id) async {
    final response = await post(confirmReceiptUrl, {'order_id': order_id});
    return ResponseData.fromJson(response.body);
  }

  // 订单详情
  Future<OrderDetailRootModel> orderDetail(int order_id) async {
    final response = await post(orderDetailUrl, {'order_id': order_id});
    return OrderDetailRootModel.fromJson(response.body);
  }

  // 退款的订单详情
  Future<RefundOrderDetailRootModel> refundOrderDetail(int order_id) async {
    final response = await post(refundOrderDetailUrl, {'order_id': order_id});
    return RefundOrderDetailRootModel.fromJson(response.body);
  }

  //
  Future<SplashImageRootModel> querySplashImage() async {
    final response = await post(splashImageUrl, {});
    return SplashImageRootModel.fromJson(response.body);
  }

  // 申请退款
  Future<ResponseData> orderRefund(String payment_num, String reason) async {
    final response = await post(orderRefundUrl, {
      'payment_num': payment_num,
      'reason': reason,
    });
    return ResponseData.fromJson(response.body);
  }

  // 去评价
  Future<ResponseData> appraise(
      {required int order_id,
      required int goods_id,
      required double grade,
      required String image_urls,
      required String contents}) async {
    final response = await post(appraiseUrl, {
      'order_id': order_id,
      'goods_id': goods_id,
      'grade': grade,
      'image_urls': image_urls,
      'contents': contents,
    });
    return ResponseData.fromJson(response.body);
  }

// 购物车提交订单
// Future<CartCommitOrderRootModel> cartCommitOrder(
//   String cartIds,
//   int shippingAddressId, {
//   int? couponId,
//   String? remark,
// }) async {
//   final response = await post(cartCommitOrderUrl, {
//     'cart_ids': cartIds,
//     'address_id': shippingAddressId,
//     'remark': remark,
//     'member_voucher_id': couponId,
//   });
//   return CartCommitOrderRootModel.fromJson(response.body);
// }
}
