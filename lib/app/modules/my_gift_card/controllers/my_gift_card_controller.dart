import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:mallxx_app/app/models/gift_card_list_model.dart';
import 'package:mallxx_app/app/models/voucher_list_model.dart';
import 'package:mallxx_app/app/modules/root/controllers/root_controller.dart';
import 'package:mallxx_app/app/modules/root/providers/member_provider.dart';
import 'package:mallxx_app/app/routes/app_pages.dart';
import 'package:oktoast/oktoast.dart';

class MyGiftCardController extends GetxController
    with GetTickerProviderStateMixin {
  int currentBottomType = 1;
  final MemberProvider _memberProvider = Get.find<MemberProvider>();
  final RootController _rootController = Get.find<RootController>();

  List<VoucherItemModel> unusedVouchersList = [];
  List<VoucherItemModel> alreadyUsedVouchersList = [];
  List<VoucherItemModel> expiredList = [];

  List<GiftCardItemModel> unusedGiftList = []; // 未使用
  List<GiftCardItemModel> usedGiftList = []; // 已使用
  List<GiftCardItemModel> expiredGiftList = []; // 已过期

  List<BadgeTab> tabs = [];

  late TabController vouchersTabController;
  late TabController giftTabController;

  String cardNumber = '';
  String rechargeCardNumber = '';

  @override
  void onInit() {
    currentBottomType = Get.arguments['type'];
    if (currentBottomType == 1) {
      tabs = [
        BadgeTab(text: '未使用'),
        BadgeTab(text: '已使用'),
        BadgeTab(text: '已过期')
      ];
      vouchersTabController = TabController(length: tabs.length, vsync: this);
      getVoucherList(0);
      getVoucherList(1);
      getVoucherList(2);

      getGiftList(0);
      getGiftList(1);
    } else if (currentBottomType == 0) {
      tabs = [
        BadgeTab(text: '未使用'),
        BadgeTab(text: '已使用'),
        BadgeTab(text: '已过期')
      ];
      giftTabController = TabController(length: tabs.length, vsync: this);
      getGiftList(0);
      getGiftList(1);
      getGiftList(2);
    }
    super.onInit();
  }

  void onSelectBottom(int value) {
    currentBottomType = value;
    print('$currentBottomType');
    if (currentBottomType == 1) {
      tabs = [
        BadgeTab(text: '未使用'),
        BadgeTab(text: '已使用'),
        BadgeTab(text: '已过期'),
      ];
      vouchersTabController = TabController(length: tabs.length, vsync: this);
      getVoucherList(0);
      getVoucherList(1);
      getVoucherList(2);
    } else if (currentBottomType == 0) {
      tabs = [
        BadgeTab(text: '未使用'),
        BadgeTab(text: '已使用'),
        BadgeTab(text: '已过期'),
      ];
      giftTabController = TabController(length: tabs.length, vsync: this);
      // getGiftList(0);
    }
    update();
  }

  Future<void> onRecharge() async {
    final res =
        await _memberProvider.queryUseBalanceCardUrl(rechargeCardNumber);
    showToast(res.msg);
    Get.back();
  }

  Future<void> getVoucherList(int index) async {
    final res = await _memberProvider.queryVoucherList(index + 1);
    if (res.code == 200) {
      if (res.data!.voucherDetail!.isNotEmpty) {
        if (index == 0) {
          unusedVouchersList = res.data!.voucherDetail!;
          print('$index: ${unusedVouchersList.length}');
        } else if (index == 1) {
          alreadyUsedVouchersList = res.data!.voucherDetail!;
          print('$index: ${alreadyUsedVouchersList.length}');
        } else if (index == 2) {
          expiredList = res.data!.voucherDetail!;
          print('$index: ${expiredList.length}');
        }
        update();
      }
    }
  }

  // 1是未使用,2是已使用,3是已过期
  Future<void> getGiftList(int index) async {
    final res = await _memberProvider.queryGiftCardList(index + 1);
    if (res.code == 200) {
      if (res.data!.list!.isNotEmpty) {
        if (index == 0) {
          unusedGiftList = res.data!.list!;
          print('未使用$index: $unusedGiftList');
        } else if (index == 1) {
          usedGiftList = res.data!.list!;
          print('已使用$index: $usedGiftList');
        } else if (index == 2) {
          expiredGiftList = res.data!.list!;
          print('已过期$index: $expiredGiftList');
        }
        update();
      }
    }
  }

  void onExchange() {
    Get.back();
    _rootController.setCurrentIndex(2);
    _rootController.jumpPage(2);
  }

  void onChanged(String value) {
    cardNumber = value;
    update();
  }

  void onRechargeChanged(String value) {
    rechargeCardNumber = value;
    update();
  }

  Future<void> onAddGiftCard() async {
    EasyLoading.show();
    final res = await _memberProvider.queryBindGiftCard(cardNumber);
    Get.back();
    getGiftList(0);
    EasyLoading.showSuccess(res.msg);
  }

  Future<void> onUseGiftCard(String number) async {
    Get.toNamed(Routes.ORDER_CONFIRM, arguments: {
      'goodsMap': {'cardNumber': number, 'orderSourceType': 2},
    });
  }
}
