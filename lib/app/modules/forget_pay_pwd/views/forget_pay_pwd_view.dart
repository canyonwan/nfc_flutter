import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:mallxx_app/const/colors.dart';

import '../controllers/forget_pay_pwd_controller.dart';

class ForgetPayPwdView extends GetView<ForgetPayPwdController> {
  const ForgetPayPwdView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KWhiteColor,
      appBar: AppBar(title: const Text('忘记支付密码'), centerTitle: true),
      body: Column(
        children: [
          GFButton(
            onPressed: controller.onSendSms,
            blockButton: true,
            shape: GFButtonShape.pills,
            text: '点击获取验证码',
            color: kAppColor,
          ).paddingAll(30.w),
          Container(
            decoration: BoxDecoration(
              color: kBgGreyColor,
              borderRadius: BorderRadius.circular(7.w),
            ),
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.w),
            child: TextField(
              onChanged: (String value) {
                controller.code = value;
              },
              decoration: InputDecoration(
                hintText: '短信验证码',
                border: InputBorder.none,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: kBgGreyColor,
              borderRadius: BorderRadius.circular(7.w),
            ),
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.w),
            child: TextField(
              onChanged: (String value) {
                controller.payPwd = value;
              },
              decoration: InputDecoration(
                hintText: '请输入新支付密码(6位数字)',
                border: InputBorder.none,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: kBgGreyColor,
              borderRadius: BorderRadius.circular(7.w),
            ),
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.w),
            child: TextField(
              onChanged: (String value) {
                controller.rePayPwd = value;
              },
              decoration: InputDecoration(
                hintText: '请再次输入支付密码(6位数字)',
                border: InputBorder.none,
              ),
            ),
          ),
          GFButton(
            onPressed: controller.onSubmit,
            blockButton: true,
            shape: GFButtonShape.pills,
            size: GFSize.LARGE,
            text: '确认',
            color: kAppColor,
          ).paddingAll(30.w),
        ],
      ),
    );
  }
}
