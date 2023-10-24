import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oktoast/oktoast.dart';

import '/app/models/product_model.dart';
import '/app/models/useinfo_model.dart';
import '/app/providers/login_provider.dart';
import '/app/routes/app_pages.dart';
import '../../shop_cart/controllers/shop_cart_controller.dart';
import '../providers/product_info_provider.dart';

class ProductInfoController extends GetxController {
  final ProductInfoProvider productInfoProvider =
      Get.find<ProductInfoProvider>();
  final LoginProvider loginProvider = Get.find<LoginProvider>();

  final ShopCartController shopCartController = Get.find<ShopCartController>();

  final isLoading = false.obs;

  final List<Tab> tabs = [
    Tab(
      text: "tab_goods".tr,
    ),
    Tab(
      text: "tab_evaluate".tr,
    ),
    Tab(
      text: "tab_detail".tr,
    ),
  ];

  final TabController tabController =
      TabController(initialIndex: 0, length: 3, vsync: ScrollableState());

  final double goodsHeight = Platform.isIOS ? 88 : 50;

  final double goodsDescHeight = 760;

  static double DEFAULT_SCROLLER = 100;

  GlobalKey goodsKey = GlobalKey();

  ScrollController scrollController = ScrollController();

  final toolbarOpacity = 0.0.obs;
  final productInfo = Product().obs;

  final buyCount = 1.obs;
  final defaultSku = SkuStock().obs;

  final selectSpecText = "".obs;
  final defaultPrice = 0.0.obs;

  final last_click = 0.obs; //1, click add cart , 2, click buy now
  int productId = 0;

  @override
  void onInit() {
    productId = Get.arguments["id"] ?? 0;
    if (productId <= 0) {
      Get.back();
    }

    scrollController.addListener(() {
      if (!scrollController.hasClients) {
        return;
      }

      double t = scrollController.offset / DEFAULT_SCROLLER;
      if (t < 0.0) {
        t = 0.0;
      } else if (t > 1) {
        t = 1.0;
      }

      toolbarOpacity.value = t;
      if (scrollController.offset < goodsHeight) {
        tabController.animateTo(0);
      } else if (scrollController.offset >= goodsHeight &&
          scrollController.offset <= goodsDescHeight) {
        tabController.animateTo(1);
      } else if (scrollController.offset >= goodsDescHeight) {
        tabController.animateTo(2);
      }
    });

    getProductInfo();
    super.onInit();
  }

  void setDefaultPrice(double price) {
    defaultPrice.value = price;
  }

  void getProductInfo() async {
    var res = await productInfoProvider.getProductInfo(productId);
    if (res.code == 200) {
      productInfo.value = res.product!;
      defaultPrice.value = productInfo.value.price!;
      if (res.product?.skuStock != null) {
        setDefaultSku(productInfo.value.skuStock![0]);
      }
    }
  }

  void onFinish() {
    if (last_click.value == 1) {
      onAddCart();
    } else if (last_click.value == 2) {
      onBuyNow();
    }
  }

  bool onAddCart() {
    if (defaultSku.value.id == null) {
      last_click.value = 1;
      return false;
    }

    if (!loginProvider.isLogin()) {
      Get.toNamed(Routes.LOGIN);
    } else {
      UserInfoModel? member = loginProvider.getMember();
      if (member == null) {
        Get.toNamed(Routes.LOGIN);
      } else {
        Map data = {
          "product_id": productInfo.value.id,
          "sku_id": defaultSku.value.id,
          "quantity": buyCount.value,
          "member_id": member.id,
          "member_nickname": member.memberName,
        };

        productInfoProvider.addCart(data).then((value) {
          if (value.code == 403) {
            Get.toNamed(Routes.LOGIN);
          } else if (value.code == 200) {
            shopCartController.getCarts();
            showToast("add_success".tr);
          } else {
            showToast(value.msg);
          }
        });
      }
    }
    return true;
  }

  bool onBuyNow() {
    if (defaultSku.value.id == null) {
      last_click.value = 2;
      return false;
    }

    Map data = {
      "type": "product",
      "product_id": productInfo.value.id,
      "sku_id": defaultSku.value.id,
      "quantity": buyCount.value,
    };
    Get.toNamed(Routes.ORDER_CONFIRM, arguments: data);
    return true;
  }

  void setDefaultSku(SkuStock? sku) {
    if (sku != null) {
      defaultSku.value = sku;
      setDefaultPrice(defaultSku.value.price!);
      setSelectSpectText();
    } else {
      defaultSku.value = SkuStock();
      setDefaultPrice(productInfo.value.price!);
    }
  }

  void setSelectSpectText() {
    if (defaultSku.value.spData != null) {
      List data = jsonDecode(defaultSku.value.spData!);
      for (var map in data) {
        selectSpecText.value += map["key"] + " " + map["value"];
      }
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    productInfoProvider.dispose();
  }
}
