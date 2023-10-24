import 'package:get/get.dart';
import 'package:mallxx_app/app/api/granary_api.dart';
import 'package:mallxx_app/app/modules/root/controllers/field_controller.dart';
import 'package:mallxx_app/app/modules/root/controllers/market_controller.dart';
import 'package:mallxx_app/app/modules/root/providers/field_provider.dart';
import 'package:mallxx_app/app/modules/root/providers/market_provider.dart';
import 'package:mallxx_app/app/modules/root/providers/member_provider.dart';
import 'package:mallxx_app/app/modules/root/providers/pay_provider.dart';
import 'package:mallxx_app/app/providers/login_provider.dart';

import '/app/modules/root/controllers/account_controller.dart';
import '/app/modules/root/controllers/root_controller.dart';
import '../controllers/find_controller.dart';
import '../controllers/granary_controller.dart';
import '../controllers/home_controller.dart';
import '../providers/cart_provider.dart';
import '../providers/find_provider.dart';

class RootBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RootController>(() => RootController());

    // 田地
    Get.lazyPut<FieldController>(() => FieldController());

    // 粮
    Get.lazyPut<GranaryController>(() => GranaryController());
    // Get.put(GranaryController());

    // 集市
    Get.lazyPut<MarketController>(() => MarketController());
    // Get.lazyPut<MarketProvider>(() => MarketProvider());

    Get.lazyPut<AccountController>(() => AccountController());
    // Get.lazyPut<LoginProvider>(() => LoginProvider());
    // Get.lazyPut<MemberProvider>(() => MemberProvider());

    // 购物车
    // Get.lazyPut<ShopCartController>(() => ShopCartController());
    // Get.put(ShopCartController());
    // Get.lazyPut<CartProvider>(() => CartProvider());

    //发现
    Get.lazyPut<FindController>(() => FindController());

    Get.lazyPut<HomeController>(() => HomeController());

    // Get.put(());

    Get.put(LoginProvider());
    Get.put(FieldProvider());
    Get.put(GranaryProvider());
    Get.put(MemberProvider());
    Get.put(FieldProvider());
    // Get.put(AdvertisementProvider());
    // Get.put(ProductProvider());
    Get.put(CartProvider());
    Get.put(FindProvider());
    Get.put(MarketProvider());
    Get.put(PayProvider());
  }
}
