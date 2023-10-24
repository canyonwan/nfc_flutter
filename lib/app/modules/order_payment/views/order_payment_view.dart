import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mallxx_app/const/colors.dart';

import '../controllers/order_payment_controller.dart';

class OrderPaymentView extends GetView<OrderPaymentController> {
  const OrderPaymentView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('支付订单'), centerTitle: true),
      body: GetBuilder<OrderPaymentController>(builder: (c) {
        return Container(
          width: Get.width,
          margin: EdgeInsets.symmetric(horizontal: 10.w),
          padding: EdgeInsets.only(top: 40.5.h),
          child: Column(
            children: [
              Text.rich(
                TextSpan(
                  text: '¥',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  children: [
                    TextSpan(
                      text: '${c.payPrice}',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 30.sp,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
              Obx(() => Text(
                    '${controller.timeRemaining.value}',
                    style: TextStyle(color: kAppGrey66Color, fontSize: 12.sp),
                  )),
              SizedBox(height: 23.5.h),
              Container(
                padding: EdgeInsets.fromLTRB(9.5.w, 28.h, 9.5.w, 15.h),
                decoration: BoxDecoration(
                  color: KWhiteColor,
                  borderRadius: BorderRadius.circular(10.w),
                ),
                child: Column(
                  children: [
                    ListView(
                      shrinkWrap: true,
                      children: controller.ways
                          .map((e) => _buildPaymentWay(e.type, e.icon))
                          .toList(),
                    ),
                    Text('暂不支持其他付款方式',
                        style: TextStyle(color: kAppSubGrey99Color))
                  ],
                ),
              ),
              GestureDetector(
                onTap: controller.onSubmitPay,
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 40.h),
                  padding: EdgeInsets.symmetric(vertical: 10.w),
                  width: Get.width,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: kAppColor,
                    borderRadius: BorderRadius.circular(40.w),
                  ),
                  child: Text('确认支付',
                      style: TextStyle(color: KWhiteColor, fontSize: 18.sp)),
                ),
              )
            ],
          ),
        );
      }),
    );
  }

  Padding _buildPaymentWay(String type, String icon) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 14.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(icon, width: 100.w),
          SizedBox(
            width: 30.w,
            height: 30.w,
            child: Checkbox(
              tristate: true,
              shape: const CircleBorder(),
              activeColor: kAppColor,
              checkColor: KWhiteColor,
              hoverColor: KWhiteColor,
              focusColor: kAppColor,
              side: const BorderSide(color: Colors.grey, width: 1),
              value: type == controller.currentWay,
              onChanged: (bool? value) => controller.onSelectWay(type),
            ),
          ),
        ],
      ),
    );
  }
}
