import 'package:mallxx_app/app/models/pay_model.dart';
import 'package:mallxx_app/app/models/judge_paycode_model.dart';
import '../../../providers/base_provider.dart';

class PayProvider extends BaseProvider {
  // 商品/购物车订单支付
  static const String goodsAndCartPayUrl = 'apitest/new_pay_order';

  // 田地认领支付
  static const String fieldClaimPayUrl = 'api/app_claim_payment';

  // 田地决策支付
  static const String fieldDecisionPayUrl = 'api/app_decision_payment';

  // 粮仓加工支付
  static const String granaryProcessPayUrl = 'api/app_granary_payment';

  // 余额充值支付
  static const String remainingSumPayUrl = 'api/new_member_recharge';

  // 优源专享卡支付
  static const String specialGoodsCardPayUrl = 'api/new_open_special_card';

  //判断是否设置了支付密码
  static const String judgePaymentCodeUrl = 'api/balance_check';

  // 购物车生成订单
  // payment_code 支付方式（1=微信，2=支付宝，3=余额）
  // order_sn 订单号和支付号只能传一个值，如果是直接支付，就传订单号
  // payment_num 支付号（订单号和支付号只传一个，如果是订单列表去支付，就传支付号）
  Future<PayRootModel> goodsAndCartPay({
    String? payment_code,
    String? order_sn,
    String? payment_num,
    String? pay_pass,
  }) async {
    final response = await post(goodsAndCartPayUrl, {
      "order_sn": order_sn,
      'payment_num': payment_num,
      'payment_code': payment_code,
      'pay_pass': pay_pass,
    });
    return PayRootModel.fromJson(response.body);
  }

  // 田地认领支付
  Future<PayRootModel> fieldClaimPay({
    required String? order_sn,
    String? payment_code,
    String? pay_pass,
  }) async {
    final response = await post(fieldClaimPayUrl, {
      "order_sn": order_sn,
      'payment_code': payment_code,
      'pay_pass': pay_pass,
    });
    return PayRootModel.fromJson(response.body);
  }

  // 田地决策支付
  Future<PayRootModel> fieldDecisionPay({
    required String? order_sn,
    required String? payment_code,
    String? pay_pass,
  }) async {
    final response = await post(fieldDecisionPayUrl, {
      "order_sn": order_sn,
      'payment_code': payment_code,
      'pay_pass': pay_pass,
    });
    return PayRootModel.fromJson(response.body);
  }

  // 粮仓加工支付
  Future<PayRootModel> granaryProcessPay(
    String order_sn, {
    String? payment_code,
    String? pay_pass,
  }) async {
    final response = await post(granaryProcessPayUrl, {
      "order_sn": order_sn,
      'payment_code': payment_code,
      'pay_pass': pay_pass,
    });
    return PayRootModel.fromJson(response.body);
  }

  // 余额充值支付
  // 支付方式（1=微信，2=支付宝），这个没有余额支付
  Future<PayRootModel> remainingSumPay(
    String order_sn, {
    String? payment_code,
  }) async {
    final response = await post(remainingSumPayUrl, {
      "order_sn": order_sn,
      'payment_code': payment_code,
    });
    return PayRootModel.fromJson(response.body);
  }

  // 优源专享卡支付
  Future<PayRootModel> specialGoodsCardPay({
    required String? type,
    String? pay_pass,
  }) async {
    final response = await post(specialGoodsCardPayUrl, {
      "type": type,
      'pay_pass': pay_pass,
    });
    return PayRootModel.fromJson(response.body);
  }
  // 判断是否设置了支付密码
  Future<JudgePayCodeModel> judgePaymentCode() async {
    final response = await post(judgePaymentCodeUrl, null);
    return JudgePayCodeModel.fromJson(response.body);
  }
}
