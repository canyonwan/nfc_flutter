import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluwx/fluwx.dart' as fluwx;
import 'package:get/get.dart';
import 'package:mallxx_app/app/models/pay_model.dart';
import 'package:mallxx_app/app/modules/root/providers/pay_provider.dart';
import 'package:mallxx_app/app/routes/app_pages.dart';
import 'package:mallxx_app/const/colors.dart';
import 'package:mallxx_app/const/resource.dart';
import 'package:mallxx_app/utils/enums.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';
import 'package:tobias/tobias.dart' as tobias;

class OrderPaymentController extends GetxController {
  final PayProvider _payProvider = Get.find<PayProvider>();
  String payPrice = '';
  String orderCode = ''; // 订单号
  String paymentNum = ''; // 支付号
  late PayTypeEnum payType;
  RxString timeRemaining = ''.obs;

  String currentWay = '1';
  int if_set = 0;

  List<PayWayModel> ways = [
    PayWayModel('1', R.ASSETS_IMAGES_WECHAT_PAYMENT_PNG),
    PayWayModel('2', R.ASSETS_IMAGES_ALIPAY_PAYMENT_PNG),
    PayWayModel('3', R.ASSETS_IMAGES_YU_E_PAYMENT_PNG),
  ];
  late final Timer timer;
  double nowUnixTime = 7200;
  String payPassword = ''; // 支付密码

  @override
  void onInit() {
    payPrice = Get.arguments['payPrice'];
    payType = Get.arguments['payType']; //  支付类型
    orderCode = Get.arguments['orderCode'] ?? ''; // 订单号
    paymentNum = Get.arguments['paymentNum'] ?? ''; // 支付号
    if (payType == PayTypeEnum.remaining) {
      ways = ways.sublist(0, 2);
    }
    launchTimer();
    super.onInit();
  }

  @override
  void onReady() {
    fluwx.weChatResponseEventHandler.listen((res) {
      if (res is fluwx.WeChatPaymentResponse) {
        if (res.isSuccessful) {
          Get.back();
          Get.offAllNamed(Routes.ORDER_SUCCESS);
        } else {
          EasyLoading.showError('支付失败');
        }
      }
    });
    super.onReady();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  void launchTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (value) {
      nowUnixTime--;
      if (nowUnixTime == 0) {
        timer.cancel();
      }
      parseTime(nowUnixTime);
    });
  }

  void parseTime(double difference) {
    int hour = difference ~/ 3600;
    int minute = difference % 3600 ~/ 60;
    int sec = (difference % 60).toInt();
    timeRemaining.value = '支付剩余时间 ${hour}小时${minute}分钟${sec}秒';
  }

  void onSelectWay(String way) {
    currentWay = way;
    update();
  }

  Future<void> onSubmitPay({bool judgePaymentWay = true}) async {
    if (judgePaymentWay) {
      if (currentWay == '3') {
        remainingPay();
        return;
      }
    }

    // payType 取决于你从哪来
    switch (payType) {
      case PayTypeEnum.goods:
        callGoodsAndCartPayApi();
        return;
      case PayTypeEnum.cart:
        callGoodsAndCartPayApi();
        return;
      case PayTypeEnum.fieldClaim:
        fieldClaimPayApi();
        return;
      case PayTypeEnum.fieldDecision:
        fieldDecisionPayApi();
        return;
      case PayTypeEnum.granary:
        granaryProcessPayApi();
        return;
      case PayTypeEnum.special:
        specialGoodsCardPayApi();
        return;
      // 调用余额充值的接口 要给余额充钱
      case PayTypeEnum.remaining:
        remainingPayApi();
        return;
      default:
        break;
    }

    // await callPayApi();
  }

  // 为购物车和集市商品支付
  Future<void> callGoodsAndCartPayApi() async {
    EasyLoading.show();
    final res = await _payProvider.goodsAndCartPay(
      payment_code: currentWay,
      order_sn: orderCode,
      payment_num: paymentNum,
      pay_pass: currentWay == '3' ? payPassword : '',
    );
    await callThirdPartyPayment(res);
  }

  // 田地认领支付
  Future<void> fieldClaimPayApi() async {
    EasyLoading.show();
    final res = await _payProvider.fieldClaimPay(
      payment_code: currentWay,
      order_sn: orderCode,
      pay_pass: currentWay == '3' ? payPassword : '',
    );
    await callThirdPartyPayment(res);
  }

  // 田地决策支付
  Future<void> fieldDecisionPayApi() async {
    EasyLoading.show();
    final res = await _payProvider.fieldDecisionPay(
      payment_code: currentWay,
      order_sn: orderCode,
      pay_pass: currentWay == '3' ? payPassword : '',
    );
    await callThirdPartyPayment(res);
  }

  // 粮仓加工支付
  Future<void> granaryProcessPayApi() async {
    EasyLoading.show();
    final res = await _payProvider.granaryProcessPay(
      orderCode,
      payment_code: currentWay,
      pay_pass: currentWay == '3' ? payPassword : '',
    );
    await callThirdPartyPayment(res);
  }

  // 优源专享卡支付
  Future<void> specialGoodsCardPayApi({String? payPwd}) async {
    EasyLoading.show();
    final res = await _payProvider.specialGoodsCardPay(
      type: currentWay,
      pay_pass: currentWay == '3' ? payPassword : '',
    );
    await callThirdPartyPayment(res);
  }

  Future<void> callWechatPay(PayDataModel res) async {
    await fluwx.payWithWeChat(
      appId: res.appid!,
      partnerId: res.partnerid!,
      prepayId: res.prepayid!,
      packageValue: res.package!,
      nonceStr: res.noncestr!,
      timeStamp: res.timestamp!,
      sign: res.sign!,
    );
  }

//  调用支付宝
  Future<void> callAlipayPay(PayDataModel model) async {
    final res = await tobias.aliPay(model.alipay!);
    EasyLoading.dismiss();
    if (res['resultStatus'] != '9000') {
      print("支付宝支付失败: $res");
    } else {
      Get.back();
      Get.toNamed(Routes.ORDER_SUCCESS);
    }
  }

  // 余额充值
  Future<void> remainingPayApi() async {
    final res =
        await _payProvider.remainingSumPay(orderCode, payment_code: currentWay);
    await callThirdPartyPayment(res);
  }

  // 调用第三方
  Future<void> callThirdPartyPayment(PayRootModel res) async {
    if (res.code == 200) {
      if (currentWay == '1') {
        callWechatPay(res.data!);
        return;
      }
      if (currentWay == '2') {
        callAlipayPay(res.data!);
        return;
      }
      EasyLoading.showSuccess(res.msg);
      Get.back();
      Get.offAllNamed(Routes.ORDER_SUCCESS);
    } else {
      EasyLoading.showError('${res.msg}');
    }
  }

// 余额支付
  void remainingPay() {
    //调取判断是否设置了支付密码接口
    judgePayCode();

    Get.bottomSheet(
      Container(
        child: Column(
          children: [
            Text(
              '请输入支付密码',
              style: TextStyle(fontSize: 20.sp),
            ).paddingSymmetric(vertical: 14.w),
            PinInputTextField(
              pinLength: 6,
              decoration: BoxTightDecoration(
                strokeColor: Colors.grey,
                obscureStyle: ObscureStyle(isTextObscure: true),
              ),
              autoFocus: true,
              textInputAction: TextInputAction.go,
              enabled: true,
              keyboardType: TextInputType.number,
              textCapitalization: TextCapitalization.characters,
              onChanged: (pin) {
                if (pin.length == 6) {
                  payPassword = pin;
                  // callPayApi(payPwd: pin);
                  // remainingPayApi();
                  onSubmitPay(judgePaymentWay: false);
                }
              },
              enableInteractiveSelection: false,
              cursor: Cursor(
                width: 2,
                color: Colors.grey,
                radius: Radius.circular(1),
                enabled: true,
              ),
            ).paddingSymmetric(horizontal: 10.w),
          ],
        ),
      ),
      backgroundColor: KWhiteColor,
    );
  }
  Future<void>judgePayCode(

    ) async {
    final res = await _payProvider.judgePaymentCode();
    if (res.data != null) {
    if(res.data!.ifSet == 1 ){

    }else{
      Get.toNamed(Routes.SET_PAY_PWD);
    };

}
}
}

class PayWayModel {
  final String type;
  final String icon;

  PayWayModel(this.type, this.icon);
}
