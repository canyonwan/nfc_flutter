import 'package:mallxx_app/app/models/cart_create_order_model.dart';
import 'package:mallxx_app/app/models/choose_coupon_list_model.dart';
import 'package:mallxx_app/app/models/commit_order_model.dart';
import 'package:mallxx_app/app/models/response_model.dart';

import '/app/models/address_model.dart';
import '../../../providers/base_provider.dart';

class OrderConfirmProvider extends BaseProvider {
  static const String defaultAddressUrl = "/member/address/info";
  static const String orderConfirmUrl = "/order/confirm";

  static const String goodsCreateOrderUrl =
      "api/detail_create_order"; // 商品页生成订单
  static const String goodsCommitOrderUrl =
      "api/detail_commit_order"; // 商品页提交订单
  static const String couponListUrl = "api/order_voucher_list"; // 购物车生成订单的优惠券列表

  static const String createGiftCardOrderUrl = "api/go_use_gift"; // 礼品卡生成订单
  static const String commitGiftCardOrderUrl =
      "api/create_gift_order"; // 礼品卡提交订单
  static const String cartCreateOrderUrl = "api/create_order"; // 购物车生成订单
  static const String cartCommitOrderUrl = "api/commit_order"; // 购物车提交订单

  @override
  void onInit() {
    super.onInit();
  }

  // 购物车生成订单
  Future<CartCreateOrderRootModel> createCartOrder(
    String cartIds,
    String address, {
    int? shippingAddressId,
    int? couponId,
  }) async {
    final response = await post(cartCreateOrderUrl, {
      "cart_ids": cartIds,
      'address': address,
      'address_id': shippingAddressId,
      'member_voucher_id': couponId,
    });
    return CartCreateOrderRootModel.fromJson(response.body);
  }

  // 礼品卡生成订单
  Future<CartCreateOrderRootModel> createGiftCardOrder({
    required String card_number,
    String? address,
    int? shippingAddressId,
  }) async {
    final response = await post(createGiftCardOrderUrl, {
      "card_number": card_number,
      'address': address,
      'address_id': shippingAddressId,
    });
    return CartCreateOrderRootModel.fromJson(response.body);
  }

  // 礼品卡提交订单
  Future<ResponseData> commitGiftCardOrder({
    required String cardNumber,
    int? shippingAddressId,
  }) async {
    final response = await post(commitGiftCardOrderUrl, {
      "card_number": cardNumber,
      'address_id': shippingAddressId,
    });
    return ResponseData.fromJson(response.body);
  }

  // 商品页生成订单
  Future<CartCreateOrderRootModel> createGoodsOrder(
    int goods_id,
    int goods_num, {
    int? shippingAddressId,
    String? address,
    int? couponId,
  }) async {
    final response = await post(goodsCreateOrderUrl, {
      "goods_id": goods_id,
      "goods_num": goods_num,
      'address': address,
      'address_id': shippingAddressId,
      'member_voucher_id': couponId,
    });
    return CartCreateOrderRootModel.fromJson(response.body);
  }

  //default Address
  Future<MyAddressItem> getDefaultAddress() async {
    final response = await get(defaultAddressUrl, query: {"id": "-1"});
    return MyAddressItem.fromJson(response.body);
  }

  // 优惠券列表
  Future<ChooseCouponListRootModel> queryChooseCouponList(String price) async {
    final response = await post(couponListUrl, {"price": price});
    return ChooseCouponListRootModel.fromJson(response.body);
  }

  // 购物车提交订单
  Future<CartCommitOrderRootModel> cartCommitOrder(
    String cartIds,
    int shippingAddressId, {
    int? couponId,
    String? remark,
  }) async {
    final response = await post(cartCommitOrderUrl, {
      'cart_ids': cartIds,
      'address_id': shippingAddressId,
      'remark': remark,
      'member_voucher_id': couponId,
    });
    return CartCommitOrderRootModel.fromJson(response.body);
  }

  // 商品页提交订单
  Future<CartCommitOrderRootModel> goodsCommitOrder(
    int goodsId,
    int goodsNum, {
    int? shippingAddressId,
    int? couponId,
    String? remark,
  }) async {
    final response = await post(goodsCommitOrderUrl, {
      "goods_id": goodsId,
      "goods_num": goodsNum,
      'address_id': shippingAddressId,
      'remark': remark,
      'member_voucher_id': couponId,
    });
    return CartCommitOrderRootModel.fromJson(response.body);
  }
}
