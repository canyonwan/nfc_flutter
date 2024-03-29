import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluwx/fluwx.dart' as fluwx;
import 'package:get/get.dart';
import 'package:mallxx_app/app/modules/root/controllers/field_controller.dart';
import 'package:mallxx_app/app/modules/root/controllers/granary_controller.dart';
import 'package:mallxx_app/app/modules/root/controllers/root_controller.dart';
import 'package:mallxx_app/app/modules/root/providers/cart_provider.dart';
import 'package:mallxx_app/app/modules/root/providers/member_provider.dart';
import 'package:mallxx_app/app/modules/shop_cart/controllers/shop_cart_controller.dart';
import 'package:mallxx_app/app/routes/app_pages.dart';
import 'package:mallxx_app/utils/utils.dart';
import 'package:oktoast/oktoast.dart';

import '/app/modules/root/controllers/account_controller.dart';
import '/app/providers/login_provider.dart';

///
///
class LoginController extends GetxController {
  late TextEditingController usernameController = TextEditingController();
  late TextEditingController passwordController = TextEditingController();
  late TextEditingController codeController = TextEditingController();
  final LoginProvider loginProvider = Get.find<LoginProvider>();
  final MemberProvider memberProvider = Get.find<MemberProvider>();
  final CartProvider cartProvider = Get.find<CartProvider>();
  final AccountController accountController = Get.find<AccountController>();
  final FieldController _fieldController = Get.find<FieldController>();
  final ShopCartController _shopCartController = Get.put(ShopCartController());
  final GranaryController _granaryController = Get.find<GranaryController>();
  final RootController _rootController = Get.find<RootController>();

  // final FieldController _fieldController = Get.find<FieldController>();

  final agreeCheckBox = true.obs;

  final isLogingIn = false.obs;

  RxBool useCodeLogin = false.obs; // 验证码登录

  late Timer _timer;
  RxInt countdownTime = 60.obs;
  RxString countText = '获取验证码'.obs;
  String code = '';

  void oncheckBoxChanged() {
    agreeCheckBox.toggle();
  }

  void onChangeLoginWay() {
    useCodeLogin.toggle();
  }

  void onLogin() async {
    if (agreeCheckBox.isFalse) {
      showToast(
        "please_tick_agree_login".tr,
      );
      return;
    }

    String username = usernameController.text;
    String password = passwordController.text;

    if (username == "") {
      showToast(
        "enter_username".tr,
      );
      return;
    }

    if (password == "") {
      showToast(
        "enter_password".tr,
      );
      return;
    }
    isLogingIn.value = true;
    var result =
        await memberProvider.login(username: username, password: password);

    if (result.code != null) {
      if (result.code == 200) {
        loginProvider.saveLogin(result.data!);
        Get.back(result: "OK");
        accountController.getAccountInfo();
        _shopCartController.getCarts();
        _shopCartController.getCartCounts();
        accountController.setMember();
        _granaryController.getGranaryList();
        _fieldController.getCategory(changeMenu: true, removeListId: true);
        isLogingIn.value = false;
      } else {
        showToast(
          result.msg!,
        );
        isLogingIn.value = false;
      }
    }
  }

  @override
  void onInit() {
    super.onInit();
    fluwx.weChatResponseEventHandler
        .distinct((a, b) => a == b)
        .listen((res) async {
      if (res is fluwx.WeChatAuthResponse) {
        int errCode = res.errCode;
        //MyLogUtil.d('微信登录返回值：ErrCode :$errCode  code:${res.code}');
        if (errCode == 0) {
          String? code = res.code;
          //把微信登录返回的code传给后台，剩下的事就交给后台处理
          // _presenter.getWeChatAccessToken(code);
          if (code != null) {
            final res = await memberProvider.wxLogin(code: code);
            if (res.code == 200 && res.data != null) {
              loginProvider.saveLogin(res.data!);
              final dd = res.data?.phone;
              if (dd == null) {
                print('dd:$dd');
              }
              if (res.data?.phone == null || res.data?.phone == "") {
                // print('返回值dd：$res.data?.phone');

                Get.toNamed(Routes.BINDTEL);
              } else {
                Get.back(result: "OK");
              }
              accountController.getAccountInfo();
              _shopCartController.getCarts();
              _shopCartController.getCartCounts();
              _granaryController.getGranaryList();
              _fieldController.getCategory(
                  changeMenu: true, removeListId: true);
            }
          }
          showToast(
            "用户同意授权成功",
          );
        } else if (errCode == -4) {
          showToast(
            "用户拒绝授权",
          );
        } else if (errCode == -2) {
          showToast(
            "用户取消授权",
          );
        }
      }
    });
  }

  @override
  void onClose() {
    super.onClose();
    _timer.cancel();
  }

  Future<void> getSmsCode() async {
    String base64Username = SharedUtil.encodeBase64(usernameController.text);
    String nongfucang = "nongfucang";
    String addnongfucangUsername = base64Username + nongfucang;
    String newBase64Username = SharedUtil.encodeBase64(addnongfucangUsername);
    var res = await memberProvider.getVerification(username: newBase64Username);
    if (res.code == 200) {
      showToast(res.msg);
    }
  }

  void startCountdownTimer() {
    if (usernameController.text.length == 11) {
      getSmsCode();
      _timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
        if (countdownTime.value == 0) {
          countText.value = '重新获取';
          _timer.cancel();
          countdownTime.value = 60;
        } else {
          countdownTime.value--;
          countText.value = '${countdownTime.value}s后获取';
        }
      });
    } else {
      showToast('请正确输入手机号');
    }
  }

  void onWxLogin() {
    fluwx
        .sendWeChatAuth(scope: "snsapi_userinfo", state: "wechat_sdk_demo_test")
        .then((data) {
      if (!data) {
        showToast("没有安装微信，请安装微信后使用该功能");
      }
      showToast("微信登录");
      print('微信登录：$data');
    });
  }

  Future<void> codeLogin() async {
    final res = await memberProvider.codeLogin(
        phone: usernameController.text, code: codeController.text);
    if (res.code == 200 && res.data != null) {
      loginProvider.saveLogin(res.data!);
      accountController.getAccountInfo();
      _shopCartController.getCarts();
      _shopCartController.getCartCounts();
      _granaryController.getGranaryList();
      _fieldController.getCategory(changeMenu: true);
      if (res.data?.phone == null) {
        Get.toNamed(Routes.BINDTEL);
      } else {
        Get.back(result: "OK");
      }
    }
  }

//   跳转到农场页
  void toFarm() {
    Get.back();
    _rootController.jumpPage(0);
    _fieldController.getCategory(changeMenu: true);
  }
}
