import 'dart:async';

import 'package:bruno/bruno.dart';
import 'package:common_utils/common_utils.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluwx/fluwx.dart';
import 'package:get/get.dart';
import 'package:mallxx_app/app/models/goods_detail_model.dart';
import 'package:mallxx_app/app/modules/root/controllers/field_controller.dart';
import 'package:mallxx_app/app/modules/root/providers/cart_provider.dart';
import 'package:mallxx_app/app/modules/root/providers/market_provider.dart';
import 'package:mallxx_app/app/routes/app_pages.dart';
import 'package:mallxx_app/const/colors.dart';
import 'package:mallxx_app/const/resource.dart';
import 'package:oktoast/oktoast.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../field_detail/controllers/timer.dart';

class GoodsDetailController extends GetxController
    with GetTickerProviderStateMixin, StateMixin<GoodsDetailDataModel> {
  final provider = Get.find<MarketProvider>();
  final cartProvider = Get.find<CartProvider>();
  final fieldController = Get.find<FieldController>();
  final tabs = <BadgeTab>[
    BadgeTab(text: '评价'),
    BadgeTab(text: '商品详情'),
    BadgeTab(text: '食谱秀评'),
  ];

  late TabController tabController;
  GoodsDetailDataModel dataModel = GoodsDetailDataModel();
  late int goodsId;
  late TimerUtil mCountDownTimerUtil;
  RxInt countdownTime = 0.obs;

  @override
  void onInit() {
    goodsId = Get.arguments;
    tabController =
        TabController(length: tabs.length, initialIndex: 1, vsync: this);
    getDetail();
    getCookbooks();
    getGoodsComments();
    getGoodsCount();
    showPreSellDialogStatus();
    super.onInit();
  }

  int nowUnixTime = 86400;
  RxString timeRemaining = ''.obs;

  // 如果库存是0，显示“已售罄”；如果库存数量在1~10，显示“仅剩（库存数量）件”；如果库存数量在11~19，显示“库存：（库存数量）件”；如果库存数量大于等于20，显示“库存充足”；
  String getStockStatus() {
    var text = '';
    if (dataModel.inventory == 0) {
      text = '已售罄';
    } else if (dataModel.inventory! > 0 && dataModel.inventory! < 10) {
      text = '仅剩${dataModel.inventory}件';
    } else if (dataModel.inventory! >= 10 && dataModel.inventory! < 20) {
      text = '库存：${dataModel.inventory}件';
    } else {
      text = '库存充足';
    }
    return text;
  }

  void launchTimer() {
    int totalSeconds = DateTime.fromMillisecondsSinceEpoch(dataModel.lastTime!)
        .difference(DateTime.now())
        .inSeconds;

    Countdown(totalSeconds, (time) {
      timeRemaining.value = time;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  void showPreSellDialogStatus() {
    if (dataModel.isPresell == 1) {
      if ([2, 3].contains(dataModel.presellType)) {
        Future.delayed(
          Duration.zero,
          () => Get.dialog(Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 31.5.w),
                  width: Get.width,
                  height: 200.h,
                  decoration: BoxDecoration(
                    color: KWhiteColor,
                    borderRadius: BorderRadius.circular(20.w),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                          dataModel.presellType == 3
                              ? R.ASSETS_ICONS_MARKET_PRESALE_SUCCESS_ICON_PNG
                              : R.ASSETS_ICONS_MARKET_PRESALE_FAIL_ICON_PNG,
                          width: 54.w,
                          fit: BoxFit.cover),
                      Padding(
                        padding: EdgeInsets.only(top: 9.5.h, bottom: 20.h),
                        child: Text(
                          dataModel.presellType == 3
                              ? '合买成功'
                              : '截止时间到人数未满则合买失败',
                          style: TextStyle(
                              fontSize: 18.sp, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 18.w),
                        padding: EdgeInsets.symmetric(
                            horizontal: 12.w, vertical: 16.w),
                        width: Get.width,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: dataModel.presellType == 3
                              ? kAppColor
                              : kAppSubGrey99Color,
                          borderRadius: BorderRadius.circular(40.w),
                        ),
                        child: Text(
                          dataModel.presellType == 3 ? '查看订单' : '合买失败',
                          style: TextStyle(fontSize: 14.sp, color: KWhiteColor),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 14.h),
                  child: GestureDetector(
                    onTap: () => Get.back(),
                    child: Image.asset(
                      R.ASSETS_ICONS_MARKET_PRESALE_CLOSE_ICON_PNG,
                      width: 35.w,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          )),
        );
      }
    }
  }

  Future<void> getDetail() async {
    change(null, status: RxStatus.loading());
    final res = await provider.queryGoodsDetail(
        goodsId, fieldController.searchModel.mergename ?? '');
    if (res.code == 200) {
      change(null, status: RxStatus.success());
      dataModel = res.data!;
      launchTimer();
      update();
    } else {
      change(null, status: RxStatus.error(res.msg));
    }
  }

  String constructTime(int seconds) {
    int hour = seconds ~/ 3600;
    int minute = seconds % 3600 ~/ 60;
    int second = seconds % 60;
    return ' ' +
        formatTime(hour) +
        "    " +
        formatTime(minute) +
        "   " +
        formatTime(second);
  }

  String formatTime(int timeNum) {
    return timeNum < 10 ? "0" + timeNum.toString() : timeNum.toString();
  }

  // 获取食谱秀评
  int cookbooksPage = 1;
  int cookbooksTotalPage = 0;
  List<CookbookEvaluateItemModel> cookbookList = [];
  EasyRefreshController cookEasyRefreshController = EasyRefreshController(
    controlFinishLoad: true,
    controlFinishRefresh: true,
  );
  CookbookEvaluateDataModel cookbookEvaluateDataModel =
      CookbookEvaluateDataModel();

  Future<void> getCookbooks() async {
    final res =
        await provider.queryGoodsCookbooks(goodsId, page: cookbooksPage);
    if (res.code == 200) {
      cookbookEvaluateDataModel = res.data!;
      cookbooksTotalPage = res.data!.totalPage!;
      if (res.data!.list!.isNotEmpty) {
        cookbookList.addAll(res.data!.list!);
      }
      update();
    }
  }

  Future<void> onCookbookLoadMore() async {
    if (cookbooksPage == cookbooksTotalPage) {
      cookEasyRefreshController.finishLoad(IndicatorResult.noMore);
      return;
    }
    cookbooksPage++;
    await getCookbooks();
    cookEasyRefreshController.finishLoad(cookbooksPage == cookbooksTotalPage
        ? IndicatorResult.noMore
        : IndicatorResult.success);
  }

  // 获取评价列表
  int commentPage = 1;
  int commentTotalPage = 0;
  List<GoodsCommentItemModel> commentList = [];
  EasyRefreshController commentEasyRefreshController = EasyRefreshController(
    controlFinishLoad: true,
    controlFinishRefresh: true,
  );
  GoodsCommentDataModel commentDataModel = GoodsCommentDataModel();

  Future<void> getGoodsComments() async {
    final res = await provider.queryGoodsComments(goodsId, page: cookbooksPage);
    if (res.code == 200) {
      if (res.data != null) {
        commentDataModel = res.data!;
        commentTotalPage = res.data!.maxpage!;
        if (res.data!.goodsComment!.isNotEmpty) {
          commentList.addAll(res.data!.goodsComment!);
        } else {
          commentList = [];
        }
      }

      update();
    }
  }

  Future<void> onGoodsCommentLoadMore() async {
    if (commentPage == commentTotalPage) {
      commentEasyRefreshController.finishLoad(IndicatorResult.noMore);
      return;
    }
    commentPage++;
    await getGoodsComments();
    commentEasyRefreshController.finishLoad(commentPage == commentTotalPage
        ? IndicatorResult.noMore
        : IndicatorResult.success);
  }

  Future<void> onLaunchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw 'Could not launch $url';
    }
  }

  //1=标记为不喜欢,2=取消不喜欢,3=标记为喜欢,4=取消喜欢
  //0=标记，1=未标记
  Future<void> onMarkUnlike(GoodsDetailDataModel model) async {
    int typeTemp = model.goodsNotLike == 0 ? 2 : 1;
    final res =
        await provider.queryGoodsDetailLike(type: typeTemp, goodsId: goodsId);
    if (res.code == 200) {
      model.goodsNotLike = typeTemp == 1 ? 0 : 1;
      showToast(res.msg);
    }
    update();
  }

  Future<void> onMarkLike(GoodsDetailDataModel model) async {
    int typeTemp = model.goodsLike == 0 ? 4 : 3;
    final res =
        await provider.queryGoodsDetailLike(type: typeTemp, goodsId: goodsId);
    if (res.code == 200) {
      model.goodsLike = typeTemp == 3 ? 0 : 1;
      showToast(res.msg);
    }
    update();
  }

  void onLookVR() {
    Get.toNamed(Routes.FIELD_DETAIL, arguments: {"id": dataModel.articleId});
  }

  ///  加入购物车
  int buyCount = 1;
  int goodsCountInCart = 0;

  Future<void> getGoodsCount() async {
    final res = await cartProvider.queryGoodsCountInCart();
    if (res.data != null) {
      goodsCountInCart = res.data!.cardNumber;
      update();
    }
  }

  // 加入购物车
  Future<void> onAddToCart() async {
    final res = await cartProvider.addGoodsToCart(goodsId, buyCount);
    if (res.code == 200) {
      //添加成功刷新购物车数量
      showToast(res.msg);
      Get.back();
      update();
    }
  }

  void onToCart() async {
    Get.toNamed(Routes.SHOP_CART);
  }

  // 立即购买
  Future<void> onBuyNow() async {
    final res = await cartProvider.nowBuy(goodsId, buyCount);
    if (res.code == 200) {
      Get.toNamed(Routes.ORDER_CONFIRM, arguments: {
        'goodsMap': {
          'goodsId': goodsId,
          'goodsNum': buyCount,
          'orderSourceType': 0
        },
      });
      update();
    }
  }

  Future<void> shareToSession() async {
    await shareToWeChat(WeChatShareWebPageModel(
      dataModel.shareurl!,
      thumbnail: WeChatImage.network(dataModel.goodsImage!),
      title: dataModel.goodsName!,
      description: dataModel.goodsRemark!,
    ));
  }

  Future onSelectAddress() async {
    await fieldController.onSelectAddress(false, changeCarts: getDetail);
  }
}
