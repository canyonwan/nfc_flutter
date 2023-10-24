import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mallxx_app/app/routes/app_pages.dart';
import 'package:mallxx_app/const/colors.dart';

import '../controllers/order_success_controller.dart';

class OrderSuccessView extends GetView<OrderSuccessController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBgGreyColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('order_pay_success'.tr),
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: () {
              Get.offAllNamed(Routes.ROOT);
              // Get.back();
              // Get.back();
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              alignment: Alignment.center,
              child: Text(
                "完成",
                style: TextStyle(color: Colors.white, fontSize: 14.sp),
              ),
            ),
          )
        ],
      ),
      body: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(top: 50),
        child: Column(
          children: [
            Image.asset("assets/icons/success.png", width: 80.w),
            SizedBox(height: 10),
            Text(
              "订单支付成功",
              style: TextStyle(fontSize: 20.sp),
            ),
            SizedBox(height: 20.w),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // GestureDetector(
                //   onTap: controller.onToOrderList,
                //   child: Container(
                //     padding:
                //         EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.w),
                //     alignment: Alignment.center,
                //     margin: EdgeInsets.only(right: 5),
                //     decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(10),
                //       color: KWhiteColor,
                //       border: Border.all(
                //         color: kAppSubGrey99Color,
                //         width: 1,
                //       ),
                //     ),
                //     child: Text(
                //       "查看订单".tr,
                //       style: TextStyle(
                //         color: kAppSubGrey99Color,
                //         fontSize: 14.sp,
                //       ),
                //     ),
                //   ),
                // ),
                GestureDetector(
                  onTap: controller.onToRootPage,
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.w),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: KWhiteColor,
                      border: Border.all(color: kAppColor, width: 1),
                    ),
                    child: Text(
                      "回到首页".tr,
                      style: TextStyle(fontSize: 14.sp, color: kAppColor),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
