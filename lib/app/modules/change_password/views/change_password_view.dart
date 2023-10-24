import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:mallxx_app/const/colors.dart';

import '../controllers/change_password_controller.dart';

class ChangePasswordView extends GetView<ChangePasswordController> {
  const ChangePasswordView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KWhiteColor,
      appBar: AppBar(title: const Text('修改密码'), centerTitle: true),
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
            child: TextField(
              controller: controller.currentTextEditingController,
              decoration: InputDecoration(
                hintText: '请输入当前登录密码',
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
            onPressed: controller.onChangePwd,
            text: '确认',
          ).paddingSymmetric(horizontal: 12.w),
        ],
      ),
    );
  }
}
