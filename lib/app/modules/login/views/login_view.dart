import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:mallxx_app/app/routes/app_pages.dart';
import 'package:mallxx_app/const/colors.dart';
import 'package:mallxx_app/const/resource.dart';
import 'package:oktoast/oktoast.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Get.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(R.ASSETS_IMAGES_LAUNCH_IMAGE_PNG),
            fit: BoxFit.fill,
          ),
        ),
        child: Container(
          color: Color(0xff000000).withOpacity(.8),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              _buildAppbar,
              Container(
                child: Padding(
                  padding: EdgeInsets.all(30.w),
                  child: Obx(
                    () => Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset(R.ASSETS_ICONS_LOGIN_LOGO_PNG, width: 54.w),
                        _buildPhone.paddingSymmetric(vertical: 20.w),
                        controller.useCodeLogin.isFalse
                            ? _buildPwd
                            : _buildCode,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                                onTap: () => Get.toNamed(Routes.FORGOT_PWD),
                                child: Text('忘记密码?',
                                    style: TextStyle(color: KWhiteColor))),
                            GestureDetector(
                                onTap: controller.onChangeLoginWay,
                                child: Text(
                                    controller.useCodeLogin.isFalse
                                        ? '验证码登录'
                                        : '账号密码登录',
                                    style: TextStyle(color: KWhiteColor))),
                          ],
                        ).paddingSymmetric(vertical: 10.w),
                        _buildUserAgreement.paddingSymmetric(vertical: 10.w),
                        _buildLoginBtn,
                        // LoginWithView(),
                        _buildThirdParty,
                        // Align(
                        //   alignment: Alignment.bottomRight,
                        //   child: GestureDetector(
                        //     child: Text('随便看看 >',
                        //         style: TextStyle(color: KWhiteColor)),
                        //     onTap: controller.toFarm,
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row get _buildThirdParty {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: controller.onWxLogin,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 5),
            width: 30,
            height: 30,
            child: Image.asset(R.ASSETS_ICONS_WEICHAT_PNG),
          ),
        ),
        if (Platform.isIOS)
          GestureDetector(
            onTap: () {
              showToast('暂不支付苹果登录');
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 5),
              width: 30,
              height: 30,
              child: Image.asset(R.ASSETS_ICONS_IC_APPLE_ROUND_PNG, scale: 0.5),
            ),
          ),
      ],
    );
  }

  GestureDetector get _buildLoginBtn {
    return GestureDetector(
      onTap: () {
        if (controller.isLogingIn.isFalse) {
          controller.useCodeLogin.isFalse
              ? controller.onLogin()
              : controller.codeLogin();
        }
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 20.w, top: 10.w),
        padding: EdgeInsets.symmetric(
          vertical: 8.w,
          horizontal: 40.w,
        ),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: kAppColor,
          borderRadius: BorderRadius.circular(4.w),
        ),
        child: Obx(
          () => controller.isLogingIn.isFalse
              ? SizedBox(
                  height: 25,
                  child: Text(
                    "login".tr,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: KWhiteColor,
                    ),
                  ),
                )
              : SizedBox(
                  width: 25,
                  height: 25,
                  child: CircularProgressIndicator(
                    color: KWhiteColor,
                    strokeWidth: 2,
                  ),
                ),
        ),
      ),
    );
  }

  Container get _buildUserAgreement {
    return Container(
      alignment: Alignment.center,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        textDirection: TextDirection.ltr,
        children: [
          Obx(
            () => SizedBox(
              width: 20,
              height: 10,
              child: Checkbox(
                tristate: true,
                shape: const CircleBorder(),
                activeColor: kAppColor,
                checkColor: KWhiteColor,
                hoverColor: KWhiteColor,
                focusColor: kAppColor,
                value: controller.agreeCheckBox.value,
                onChanged: (value) {
                  controller.oncheckBoxChanged();
                },
              ),
            ),
          ),
          Text(
            "read_and_ageree".tr,
            style: TextStyle(color: KWhiteColor, fontSize: 12.sp),
          ).paddingOnly(left: 4.w),
          Expanded(
            child: InkWell(
              onTap: () => {
                Get.toNamed(Routes.MY_WEBVIEW, arguments: {
                  'type': 2,
                  'first': 'https://api.nongfucang.cn/home/apipartner/protocol',
                })
              },
              child: Text(
                "service_agreement".tr,
                softWrap: true,
                maxLines: 100,
                style: TextStyle(
                  color: kAppColor,
                  fontSize: 12.sp,
                ),
                // textAlign: ,
              ),
            ),
          ),
        ],
      ),
    );
  }

  TextField get _buildPwd {
    return TextField(
      controller: controller.passwordController,
      maxLines: 1,
      cursorWidth: 1,
      cursorColor: Colors.red,
      keyboardAppearance: Brightness.dark,
      obscureText: true,
      style: TextStyle(color: KWhiteColor),
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        hintText: "请输入密码",
        labelText: "enter_password".tr,
        focusColor: Colors.grey,
        labelStyle: TextStyle(color: kAppColor),
        hintStyle: TextStyle(color: KWhiteColor),
        fillColor: Colors.grey,
        border: const UnderlineInputBorder(
          borderSide: BorderSide(width: 0.1),
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            width: 0.1,
            color: Colors.grey,
          ),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            width: 0.1,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }

  TextField get _buildCode {
    return TextField(
      controller: controller.codeController,
      maxLines: 1,
      cursorWidth: 1,
      cursorColor: Colors.red,
      keyboardAppearance: Brightness.dark,
      obscureText: true,
      style: TextStyle(color: KWhiteColor),
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        hintText: "短信验证码",
        labelText: "短信验证码",
        focusColor: Colors.grey,
        labelStyle: TextStyle(color: kAppColor),
        hintStyle: TextStyle(color: KWhiteColor),
        fillColor: Colors.grey,
        border: const UnderlineInputBorder(
          borderSide: BorderSide(width: 0.1),
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            width: 0.1,
            color: Colors.grey,
          ),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            width: 0.1,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }

  Widget get _buildPhone {
    return Row(
      children: [
        Expanded(
          child: TextField(
            keyboardAppearance: Brightness.dark,
            controller: controller.usernameController,
            maxLines: 1,
            style: TextStyle(color: KWhiteColor),
            decoration: InputDecoration(
              hintText: '请输入手机号',
              border: InputBorder.none,
              hintStyle: TextStyle(color: KWhiteColor),
              labelText: "enter_username".tr,
              labelStyle: TextStyle(color: kAppColor),
            ),
          ),
        ),
        Obx(
          () => controller.useCodeLogin.isTrue
              ? GFButton(
                  onPressed: controller.startCountdownTimer,
                  shape: GFButtonShape.pills,
                  text: controller.countText.value,
                  padding: EdgeInsets.symmetric(horizontal: 14.w),
                  color: kAppColor,
                )
              : SizedBox(),
        ),
      ],
    );
  }

  Padding get _buildAppbar {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 40.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: controller.toFarm,
            icon: Icon(Icons.close, size: 30.w, color: KWhiteColor),
          ),
          GestureDetector(
            onTap: () => Get.toNamed(Routes.REGISTER),
            child: Container(
              child: Text(
                "注册",
                style: TextStyle(
                  color: KWhiteColor,
                  fontSize: 18.sp,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
