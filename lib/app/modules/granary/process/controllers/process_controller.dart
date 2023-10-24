import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mallxx_app/app/api/granary_api.dart';
import 'package:mallxx_app/app/models/address_model.dart';
import 'package:mallxx_app/app/models/calc_process_production_model.dart';
import 'package:mallxx_app/app/models/process_production_model.dart';
import 'package:mallxx_app/app/routes/app_pages.dart';
import 'package:mallxx_app/utils/enums.dart';
import 'package:oktoast/oktoast.dart';

class ProcessController extends GetxController
    with StateMixin<List<CanProcessedProductionModel>> {
  final GranaryProvider pro = Get.find<GranaryProvider>();
  TextEditingController textEditingController = TextEditingController();

  late int granaryId;
  List i = [];
  String goodsIds = '';

  String addressId = '';

  RxBool calcLoading = false.obs;
  MyAddressItem useAddress = MyAddressItem();
  CalcProcessProductionDataModel calcResult = CalcProcessProductionDataModel();

  RxInt count = 0.obs;
  List<CanProcessedProductionModel> data = [];

  @override
  void onInit() {
    granaryId = Get.arguments;
    getCanProcessProductList();
    super.onInit();
  }

  Future<void> getCanProcessProductList() async {
    change(null, status: RxStatus.loading());
    var res = await pro.granaryCanProcessedProductions(granaryId);
    if (res.code == 200) {
      data = res.data ?? [];
      change(res.data, status: RxStatus.success());
    } else {
      change(null, status: RxStatus.error());
    }
    update();
  }

  // 增加/减少计数
  Future<void> onIncrement(int val, CanProcessedProductionModel model) async {
    i.add('${model.goodsId}, $val');
    if (i.length > 1) {
      i.removeWhere((e) {
        List<String> a = e.split(',');
        return a[0] == model.goodsId.toString();
      });
      if (val > 0) i.add('${model.goodsId}, $val');
    }
    goodsIds = i.join(';');
    // count.value = val;
    model.count = val;
    if (goodsIds.length > 0 && addressId.length > 0) {
      await onCalc();
    }
  }

  Future<void> onCalc() async {
    calcLoading.value = true;
    var res =
        await pro.granaryCalcProcessProduction(granaryId, goodsIds, addressId);
    if (res.code == 200) {
      calcResult = res.data!;
    } else {
      showToast('${res.msg ?? '价格计算失败!'}');
    }
    update();
    calcLoading.value = false;
  }

  Future onSelectAddress() async {
    useAddress = await Get.toNamed(Routes.ADDRESS_BOOK);
    if (useAddress.id != null) addressId = useAddress.id.toString();
    update(['useAddress']);
    if (goodsIds.length > 0 && addressId.length > 0) {
      await onCalc();
    }
  }

  String wayCode = '';

  Future<void> onSubmitOrder() async {
    var res = await pro.granarySubmitOrder(granaryId, goodsIds, addressId);
    if (res.code == 200) {
      Get.toNamed(Routes.ORDER_PAYMENT, arguments: {
        'payPrice': res.data!.totalPrice.toString(),
        'orderCode': res.data!.orderSn,
        'payType': PayTypeEnum.granary
      });
      //  订单提交成功
      // Get.to(() => PaymentWays(
      //       wayCode: wayCode,
      //       onChooseWay: (String wayCode) async {
      //         wayCode = wayCode;
      //         //  开始支付
      //         var payRes =
      //             await pro.granaryPaymentOrder(res.data!.orderSn!, wayCode);
      //         if (payRes.code == 200) {
      //           Get.back();
      //         } else {
      //           showToast('${res.msg ?? '系统内部错误'}');
      //         }
      //       },
      //     ));
    } else {
      showToast('${res.msg ?? '系统内部错误'}');
    }
  }

  @override
  void onClose() {
    super.onClose();
  }
}
