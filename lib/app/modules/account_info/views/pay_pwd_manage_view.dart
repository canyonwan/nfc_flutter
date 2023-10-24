import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mallxx_app/app/routes/app_pages.dart';
import 'package:mallxx_app/const/colors.dart';

class PayPwdManageView extends GetView {
  const PayPwdManageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('支付密码管理'), centerTitle: true),
      body: Padding(
        padding: EdgeInsets.all(12.w),
        child: Column(
          children: [
            GestureDetector(
              onTap: () => Get.toNamed(Routes.RESET_PAY_PWD),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                decoration: BoxDecoration(
                  color: KWhiteColor,
                  borderRadius: BorderRadius.circular(10.w),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '重置支付密码',
                      style: TextStyle(color: kAppBlackColor, fontSize: 14.sp),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.keyboard_arrow_right_outlined,
                          color: Colors.grey),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 8.w),
            GestureDetector(
              onTap: () => Get.toNamed(Routes.FORGET_PAY_PWD),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                decoration: BoxDecoration(
                  color: KWhiteColor,
                  borderRadius: BorderRadius.circular(10.w),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '忘记支付密码',
                      style: TextStyle(color: kAppBlackColor, fontSize: 14.sp),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.keyboard_arrow_right_outlined,
                          color: Colors.grey),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
