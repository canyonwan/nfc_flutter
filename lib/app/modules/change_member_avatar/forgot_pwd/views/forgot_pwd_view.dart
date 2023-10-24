import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:mallxx_app/const/colors.dart';

import '../controllers/forgot_pwd_controller.dart';

class ForgotPwdView extends GetView<ForgotPwdController> {
  const ForgotPwdView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KWhiteColor,
      appBar: AppBar(title: const Text('设置新密码'), centerTitle: true),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.w),
            margin: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: kBgGreyColor,
              borderRadius: BorderRadius.circular(7.w),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller.phoneTextEditingController,
                    decoration: InputDecoration(
                      hintText: '手机号',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                Obx(() => GFButton(
                      onPressed: controller.startCountdownTimer,
                      shape: GFButtonShape.pills,
                      text: controller.countText.value,
                      padding: EdgeInsets.symmetric(horizontal: 14.w),
                      color: kAppColor,
                    )),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.w),
            margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.w),
            decoration: BoxDecoration(
              color: kBgGreyColor,
              borderRadius: BorderRadius.circular(7.w),
            ),
            child: TextField(
              controller: controller.codeTextEditingController,
              decoration: InputDecoration(
                hintText: '短信验证码',
                border: InputBorder.none,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.w),
            margin: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: kBgGreyColor,
              borderRadius: BorderRadius.circular(7.w),
            ),
            child: TextField(
              controller: controller.newTextEditingController,
              decoration: InputDecoration(
                hintText: '请输入新密码',
                border: InputBorder.none,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(12.w),
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.w),
            decoration: BoxDecoration(
              color: kBgGreyColor,
              borderRadius: BorderRadius.circular(7.w),
            ),
            child: TextField(
              controller: controller.confirmTextEditingController,
              decoration: InputDecoration(
                hintText: '确认新密码',
                border: InputBorder.none,
              ),
            ),
          ),
          Text('必须是6-20个字母, 数字或符号', style: TextStyle(color: kAppSubGrey99Color))
              .paddingAll(12.w),
          GFButton(
            shape: GFButtonShape.pills,
            size: GFSize.LARGE,
            color: kAppColor,
            fullWidthButton: true,
            onPressed: controller.onSubmit,
            text: '确认',
          ).paddingSymmetric(horizontal: 12.w),
        ],
      ),
    );
  }
}
