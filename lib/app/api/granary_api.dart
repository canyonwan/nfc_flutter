import 'package:mallxx_app/app/models/calc_process_production_model.dart';
import 'package:mallxx_app/app/models/granary_list_model.dart';
import 'package:mallxx_app/app/models/granary_operation_records_model.dart';
import 'package:mallxx_app/app/models/granary_submit_order_model.dart';
import 'package:mallxx_app/app/models/process_production_model.dart';
import 'package:mallxx_app/app/models/response_model.dart';
import 'package:mallxx_app/app/providers/base_provider.dart';

class GranaryProvider extends BaseProvider {
  static const granaryListUrl = 'api/granary_list';
  static const granaryRecycleUrl = 'api/granary_recycle'; // 粮仓回收
  static const granaryDonateUrl = 'api/granary_donate'; // 粮仓捐赠
  static const granaryOperationRecordsUrl = 'api/granary_record'; // 操作记录
  static const granaryCanProcessedProductionsUrl =
      'api/granary_info'; // 可被加工的产品列表
  static const granaryCalcProcessedProductionsUrl =
      'api/granary_compute'; // 加工页计算价格
  static const granarySubmitOrderUrl = 'api/granary_order'; // 加工页提交订单
  static const granaryPaymentOrderUrl = 'api/granary_payment'; // 加工页订单支付

  // 粮仓列表
  Future<GranaryListRootModel> queryGranaryList(
      {required int page, int? article_id}) async {
    final resp =
        await post(granaryListUrl, {'page': page, 'article_id': article_id});
    return GranaryListRootModel.fromJson(resp.body);
  }

  // 粮仓回收
  Future<ResponseData> granaryRecycle(
      {required int granary_id, required String num}) async {
    final resp =
        await post(granaryRecycleUrl, {'granary_id': granary_id, 'num': num});
    return ResponseData.fromJson(resp.body);
  }

  // 粮仓捐赠
  Future<ResponseData> granaryDonate(
      {required int granary_id, required String num}) async {
    final resp =
        await post(granaryDonateUrl, {'granary_id': granary_id, 'num': num});
    return ResponseData.fromJson(resp.body);
  }

  // 操作记录
  Future<GranaryOperationRecordsRootModel> granaryOperationRecords(
      {required int granary_id, int? page = 1}) async {
    final resp = await post(
        granaryOperationRecordsUrl, {'granary_id': granary_id, 'page': page});
    return GranaryOperationRecordsRootModel.fromJson(resp.body);
  }

  // 可被加工的产品列表
  Future<CanProcessedProductionRootModel> granaryCanProcessedProductions(
      int granary_id) async {
    final resp = await post(
        granaryCanProcessedProductionsUrl, {'granary_id': granary_id});
    return CanProcessedProductionRootModel.fromJson(resp.body);
  }

  //  加工页计算价格
  Future<CalcProcessProductionRootModel> granaryCalcProcessProduction(
    int granaryId,
    String goodsIds,
    String addressId,
  ) async {
    final resp = await post(granaryCalcProcessedProductionsUrl, {
      'granary_id': granaryId,
      'goods_info': goodsIds,
      'address_id': addressId,
    });
    return CalcProcessProductionRootModel.fromJson(resp.body);
  }

  //  加工页提交订单
  Future<GranarySubmitOrderRootModel> granarySubmitOrder(
      int granaryId, String goodsIds, String addressId) async {
    final resp = await post(granarySubmitOrderUrl, {
      'granary_id': granaryId,
      'goods_info': goodsIds,
      'address_id': addressId,
    });
    return GranarySubmitOrderRootModel.fromJson(resp.body);
  }

  //  加工页订单支付
  //  paymentType: 1=微信浏览器，2=其他浏览器，3=支付宝，4=余额
  Future<ResponseData> granaryPaymentOrder(String orderCode, String paymentType,
      {String? paymentPwd}) async {
    final resp = await post(granaryPaymentOrderUrl, {
      'order_sn': orderCode,
      'payment_code': paymentType,
      'pay_pass': paymentPwd,
    });
    return ResponseData.fromJson(resp.body);
  }
}
