import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jpush_flutter/jpush_flutter.dart';
import 'package:mallxx_app/app/models/cart_model.dart';
import 'package:mallxx_app/app/modules/root/controllers/account_controller.dart';
import 'package:mallxx_app/app/modules/root/controllers/field_controller.dart';
import 'package:mallxx_app/app/modules/root/controllers/granary_controller.dart';
import 'package:mallxx_app/app/modules/root/providers/cart_provider.dart';
import 'package:mallxx_app/app/modules/root/views/account_view.dart';
import 'package:mallxx_app/app/modules/root/views/field_view.dart';
import 'package:mallxx_app/app/modules/root/views/find_view.dart';
import 'package:mallxx_app/app/modules/root/views/granary_view.dart';
import 'package:mallxx_app/app/modules/root/views/market_view.dart';
import 'package:mallxx_app/app/providers/login_provider.dart';

class RootController extends GetxController {
  final routeData = Get.arguments;
  late PageController pageController;

  final FieldController _fieldController = Get.find<FieldController>();
  final AccountController _accountController = Get.find<AccountController>();
  final GranaryController _granaryController = Get.find<GranaryController>();
  // final FindController _findController = Get.find<FindController>();

  CartProvider cartProvider = Get.find<CartProvider>();
  LoginProvider _loginProvider = Get.find<LoginProvider>();
  final JPush jPush = new JPush();

  List<Widget> pages = [
    FieldView(), // 田地
    GranaryView(), // 粮仓
    MarketView(), // 集市
    //ShopCartView(),
    FindView(), //发现
    AccountView(),
  ];

  int currentIndex = 0;
  int cartGoodsCount = 0;
  RxString img = ''.obs;

  late Timer _timer;
  RxInt countdownTime = 3.obs;
  RxBool showSplash = true.obs;

  @override
  void onInit() {
    if (Get.arguments == null) {
      showSplash.value = true;
    } else {
      showSplash.value = Get.arguments['showSplash'] ?? true;
    }
    super.onInit();
    getSplashImg();
    // getCartGoodsCount();
    initOther();
    pageController = new PageController(initialPage: currentIndex);
  }

  @override
  void onClose() {
    super.onClose();
    _timer.cancel();
  }

  void setCurrentIndex(int index) {
    currentIndex = index;
    update();
  }

  Future<void> initOther() async {
    if (_loginProvider.isLogin()) {
      var userInfoModel = _loginProvider.getMember();
      if (userInfoModel != null && userInfoModel.id != null) {
        await jPush.setAlias(userInfoModel.id!.toString());
      }
    }
  }

  Future<void> getSplashImg() async {
    final res = await cartProvider.querySplashImage();
    if (res.code == 200) {
      img.value = res.data.image;
      launchTimer();
    }
  }

  void launchTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      if (countdownTime.value == 0) {
        _timer.cancel();
      } else {
        countdownTime.value--;
      }
    });
  }

  void jumpPage(int index) {
    currentIndex = index;
    if (currentIndex == 3) {
      // _findController.getFindList(loadFindList: true);
      //_shopCartController.getCarts();
      _fieldController.getCityData();
    }
    if (currentIndex == 1) {
      getCartGoodsCount();
      _granaryController.getGranaryList();
    }
    if (currentIndex == 4) {
      _accountController.getAccountInfo();
    }
    if (currentIndex == 0) {
      _fieldController.getCategory(changeMenu: true);
    }
    pageController.jumpToPage(currentIndex);
    update();
  }

  Future<void> getCartGoodsCount() async {
    GoodsCountInCartRootModel res = await cartProvider.queryGoodsCountInCart();
    if (res.code == 200) {
      cartGoodsCount = res.data!.kucunNum;
      update();
    }
  }
}
