import 'dart:async';
import 'dart:io';

import 'package:better_video_player/better_video_player.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart'
    hide ImageSource;
import 'package:fluwx/fluwx.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mallxx_app/app/api/common_api.dart';
import 'package:mallxx_app/app/models/field_detail_button_status_model.dart';
import 'package:mallxx_app/app/models/field_detail_model.dart';
import 'package:mallxx_app/app/models/label_list_model.dart';
import 'package:mallxx_app/app/models/response_model.dart';
import 'package:mallxx_app/app/modules/field_detail/views/components/views/field_claim_view.dart';
import 'package:mallxx_app/app/modules/order_confirm/providers/order_confirm_provider.dart';
import 'package:mallxx_app/app/modules/root/controllers/field_controller.dart';
import 'package:mallxx_app/app/modules/root/providers/cart_provider.dart';
import 'package:mallxx_app/app/modules/root/providers/field_provider.dart';
import 'package:mallxx_app/app/routes/app_pages.dart';
import 'package:mallxx_app/utils/enums.dart';
import 'package:oktoast/oktoast.dart';
import 'package:url_launcher/url_launcher.dart';

import 'timer.dart';

class FieldDetailController extends GetxController
    with GetSingleTickerProviderStateMixin, StateMixin {
  final FieldProvider fieldProvider = Get.find<FieldProvider>();
  final CommonProvider commonProvider =
      Get.put<CommonProvider>(CommonProvider());
  FieldController fieldController = Get.find<FieldController>();
  final CartProvider cartProvider = Get.find<CartProvider>();
  final OrderConfirmProvider orderConfirmProvider =
      Get.put<OrderConfirmProvider>(OrderConfirmProvider());
  ScrollController scrollController = ScrollController();

  final EasyRefreshController liveActionEasyRefreshController =
      EasyRefreshController(
    controlFinishRefresh: true,
    controlFinishLoad: true,
  );

  String labelId = '';

  FieldDetailDataModel dataModel = FieldDetailDataModel(
    claimList: [],
    recordList: [],
    chippedList: [],
    decisionList: [],
    goodsList: [],
  );

  bool showShareEditInput = false;

  String inputText = ''; // 评论输入框内容

  int totalPage = 1; // 实景记录分页
  List<LiveActionItemModel> recordList = []; // 实景记录分页

  late final BetterVideoPlayerController videoController;
  ClaimFieldDataModel claimFieldData = ClaimFieldDataModel();

  bool isAgree = false;
  int? claimId;
  late int fieldId; // 田地
  int currentSelectedOptionId = 0; // 决策管理选中的选项
  int goodsCount = 0; // 商品数量
  int orderCount = 0; // 订单数量

  // List<BadgeTab> tabs = <BadgeTab>[
  //   BadgeTab(text: '实景记录'),
  //   BadgeTab(text: '决策管理'),
  //   BadgeTab(text: '田地资料'),
  //   BadgeTab(text: '认领购买'),
  // ];
  List tabs = <String>[];
  String part1 = '';
  String part2 = '';
  String part3 = '';
  String part4 = '';
  int part1Badge = 0;
  int part2Badge = 0;

  late TabController tabController;
  FieldDetailButtonStatusDataModel buttonStatusDataModel =
      FieldDetailButtonStatusDataModel();

  RxInt count = 1.obs;
  RxString claimPrice = "0.00".obs;
  int sort = 1;

  String shareSettingExplain = '';

  // 认领提交订单的入参
  String claimName = '';
  String claimPhone = '';
  String claimAddressId = '';
  String claimAddress = '';

  @override
  void onInit() {
    fieldId = Get.arguments['id'];

    getFieldDetail(onlyChangeLive: false);
    getDetailButtonStatusUrl();
    getGoodsCount();
    getLabelList();
    videoController = BetterVideoPlayerController();
    super.onInit();
  }

  @override
  void onReady() {
    // onIncrement(count.value);
    tabController.addListener(() {
      //   如果tabController.index == 1并且tabs[index].text == '决策管理'，则调用getDetailButtonStatusUrl
      if (tabController.index == 1 && tabs[tabController.index].text == part2) {
        onMarkReadForVRAndDecision(2);
        return;
      } else if (tabController.index == 0 &&
          tabs[tabController.index].text == part1) {
        onMarkReadForVRAndDecision(1);
        return;
      }
    });
    super.onReady();
  }

  @override
  void dispose() {
    super.dispose();
    videoController.dispose();
    cancelTimer();
  }

  void onSortRecord(int value) {
    sort = value == 1 ? 2 : 1;
    update(['updateFieldDetail']);
    getFieldDetail();
  }

  Future<void> onSaveShareSettingInput() async {
    showShareEditInput = false;
    update(['updateFieldDetail']);
    var res = await fieldProvider.onEditFieldDetailAndExplain(fieldId,
        shareExplain: shareSettingExplain);
    getFieldDetail();
    // showToast(res.msg);
  }

  List<LabelModel> labelList = [];

  // 获取标签列表
  Future<void> getLabelList() async {
    var res = await fieldProvider.queryLabelList(fieldId);
    if (res.code == 200) {
      labelList = res.data;
      if (labelList.isNotEmpty) {
        labelId = labelList.first.id.toString();
      }
      update(['updateFieldDetail']);
    }
  }

  // 标为已读
  // 1=实景，2=决策
  Future<void> onMarkReadForVRAndDecision(int part) async {
    var res = await fieldProvider.markReadForVRAndDecision(fieldId, part);
    print('mark read:${res}');
    if (res.code == 200) {
      getFieldDetail();
    }
  }

  // 删除实景记录
  Future<void> onDeleteRecord(LiveActionItemModel item) async {
    var res = await fieldProvider.delRecord(
        recordId: item.id, articleId: fieldId, type: item.type);
    if (res.code == 200) {
      showToast(res.msg);
      getFieldDetail();
    }
  }

  // 编辑实景记录 2视频 1图文
  Future<void> onEditRecord(LiveActionItemModel item) async {
    if (item.type == 2) {
      await Get.toNamed(Routes.VIDEO_UPLOAD, arguments: {
        'id': item.id,
        'articleId': fieldId,
      });
      getFieldDetail();
    } else if (item.type == 1) {
      await Get.toNamed(Routes.IMAGE_TEXT_UPLOAD, arguments: {
        'id': item.id,
        'articleId': fieldId,
      });
      getFieldDetail();
    }
  }

  // 筛选实景记录列表
  void onFilterRecordList(int id) {
    EasyLoading.show();
    labelId = id.toString();
    getFieldDetail();
    update(['updateFieldDetail']);
  }

  // 获取输入的分享说明
  void onInputShareSetting(String value) {
    shareSettingExplain = value;
  }

  void onChangeShareEdit() {
    showShareEditInput = true;
    update(['updateFieldDetail']);
  }

  void editFieldContent() async {
    await Get.toNamed(Routes.SHARE_DETAIL,
        arguments: {'id': fieldId, 'detail': dataModel.content});
    getFieldDetail();
  }

  Future<void> getFieldDetail(
      {int page = 1, bool onlyChangeLive = false}) async {
    // change(null, status: RxStatus.loading());
    var res = await fieldProvider.queryFieldDetail(fieldId,
        mergename: Get.arguments['mergename'],
        page: page,
        sort: sort,
        vlabel_ids: labelId);
    if (res.code == 200) {
      EasyLoading.dismiss();
      // 如果加载更多 就只走这里
      if (onlyChangeLive) {
        recordList.addAll(res.data!.recordList!);
      } else {
        recordList = res.data!.recordList!;
        totalPage = res.data!.totalPage!;
        dataModel = res.data!;
        if (dataModel.ifRecord == 1) {
          tabs.add(dataModel.part1);
          part1 = dataModel.part1!;
          part1Badge = dataModel.part1Num ?? 0;
          // tabs.add(
          //   BadgeTab(
          //     text: dataModel.part1,
          //     badgeNum: dataModel.part1Num,
          //     showRedBadge: dataModel.part1Num! > 0,
          //   ),
          // );
        }
        if (dataModel.ifDecision == 1) {
          tabs.add(dataModel.part2);
          part2 = dataModel.part2!;
          part2Badge = dataModel.part2Num ?? 0;
          // tabs.add(BadgeTab(
          //   text: dataModel.part2,
          //   badgeNum: dataModel.part2Num,
          //   showRedBadge: dataModel.part2Num! > 0,
          // ));
        }
        if (dataModel.ifContent == 1) {
          // tabs.add(BadgeTab(text: dataModel.part3));
          tabs.add(dataModel.part3);
          part3 = dataModel.part3!;
        }
        if (dataModel.ifProduct == 1) {
          // tabs.add(BadgeTab(text: dataModel.part4));
          tabs.add(dataModel.part4);
          part4 = dataModel.part4!;
        }
      }
      change(dataModel, status: RxStatus.success());
      update(['updateFieldDetail']);
      tabController = TabController(length: tabs.length, vsync: this);
      if (tabs[0].text == part1) {
        onMarkReadForVRAndDecision(1);
      } else if (tabs[0].text == part2) {
        onMarkReadForVRAndDecision(2);
      }
    } else {
      change(dataModel, status: RxStatus.error());
    }
  }

  Future<void> onCollectField(FieldDetailDataModel model) async {
    ResponseData res;
    if (model.ifLike == 0) {
      res = await fieldProvider.collectField(fieldId);
      if (res.code == 200) model.ifLike = 1;
    } else {
      res = await fieldProvider.canCelCollectField(fieldId);
      if (res.code == 200) model.ifLike = 0;
    }
    showToast(res.msg);
    update(['updateFieldDetail']);
  }

  Future<void> shareToSession(FieldDetailDataModel model) async {
    await shareToWeChat(WeChatShareWebPageModel(
      model.shareUrl!,
      thumbnail: WeChatImage.network(model.shareImage!),
      title: model.shareTitle!,
      description: model.shareExplain,
    ));
  }

  // 我要投诉
  void onComplaint() {
    Get.toNamed(Routes.COMPLAINT_VIEW, arguments: fieldId);
  }

  // 进入直播间
  Future<void> onEnterLive(String liveAddress) async {
    await fieldProvider.changeLiveNum(fieldId, 1);
    await Get.toNamed(Routes.LIVE_STREAMING,
        arguments: {'liveUrl': liveAddress});
    await fieldProvider.changeLiveNum(fieldId, 2);
  }

  // 获取要认领的田地详情
  Future<void> jumpToFieldClaim(int id) async {
    claimId = id;
    final res = await fieldProvider.queryClaimFieldDetail(id);
    if (res.code == 200) {
      onIncrement(count.value);
      Get.to(() => FieldClaimView(), arguments: res.data!);
    }
  }

  // 获取要认领协议
  Future<void> getClaimAgreement() async {
    final res = await fieldProvider.queryClaimAgreement();
    if (res.code == 200) {
      Get.defaultDialog(title: '', content: HtmlWidget(res.data!.content!));
    }
  }

  Future<void> onIncrement(int value) async {
    count.value = value;
    final res =
        await fieldProvider.queryClaimFieldDetail(claimId!, num: count.value);
    if (res.code == 200) {
      claimFieldData = res.data!;
      update(['calcPrice']);
    } else {
      showToast(res.msg!);
    }
  }

  // 确认支付
  Future<void> onSubmitPay() async {
    if (!isAgree) {
      showToast('请先同意认领协议');
      return;
    }
    print('name: ${fieldController.searchModel.mergename}');
    // fieldController.searchModel.mergename转为数组 不要第一个
    var arr = fieldController.searchModel.mergename!.split(',');
    arr.removeAt(0);
    var mergename = arr.join(',');
    final res = await fieldProvider.createFieldClaimOrder(
        claimId!, count.value, claimName, claimPhone, mergename, claimAddress);
    if (res.code == 200) {
      Get.toNamed(Routes.ORDER_PAYMENT, arguments: {
        'payPrice': res.data!.totalPrice.toString(),
        'orderCode': res.data!.orderSn!,
        'payType': PayTypeEnum.fieldClaim
      });
    } else {
      if (res.msg == '请先绑定手机号') {
        Get.toNamed(Routes.BINDTEL);
      }
    }
  }

  Future<void> onChangeAddress() async {
    await fieldController.onSelectAddress(false);
  }

  // 决策管理 选项选中
  void onSelectOption(OptionItemModel item, DecisionItemModel m) {
    for (var i = 0; i < m.optionList!.length; i++) {
      if (item.id != m.optionList![i].id) {
        m.optionList![i].ifCheck = 0;
      } else {
        m.memberChoose = m.optionList![i].id;
        m.ifContent = m.optionList![i].ifContent;
        m.ifImage = m.optionList![i].ifImage;
        m.ifCheck = m.optionList![i].ifCheck;
        m.optionPrice = m.optionList![i].price;
        m.optionList![i].ifCheck = 1;
      }
    }
    update();
  }

  File? fileTemp;
  final ImagePicker _picker = ImagePicker();

  // 上传图片
  Future<void> onUploadImage(DecisionItemModel m) async {
    final XFile? result = await _picker.pickImage(
      source: ImageSource.gallery,
    );
    if (result != null) {
      var fileTemps = await result.path;
      File file = File(fileTemps);
      fileTemp = file;
      m.ifContent = 0;
      update(['uploadImage']);
    }
  }

  //  提交决策订单
  Future<void> onPayAndSubmit(DecisionItemModel m) async {
    EasyLoading.show(status: '提交中..');
    int optionId = 0;
    String image = '';
    for (var i = 0; i < m.optionList!.length; i++) {
      if (m.optionList![i].ifCheck == 1) {
        optionId = m.optionList![i].id!;
      }
    }
    if (fileTemp != null) {
      final res = await commonProvider.uploadImage(fileTemp!);
      if (res.code == 200) {
        image = res.data!.imageUrl!;
      }
    }
    var orderRes = await fieldProvider.submitDecision(
      m.id!,
      optionId,
      m.content,
      image,
    );
    // 提交成功
    if (orderRes.code == 200) {
      m.image = image;
      m.totalPrice = orderRes.data!.totalPrice!;
      m.status = 0;
      EasyLoading.dismiss();
      if (orderRes.data!.ifPay == 1) {
        Get.toNamed(Routes.ORDER_PAYMENT, arguments: {
          'payPrice': orderRes.data!.totalPrice.toString(),
          'orderCode': orderRes.data!.orderSn,
          'payType': PayTypeEnum.fieldDecision,
        });
      }
      getFieldDetail();
      update();
    }
  }

  Future<void> getDetailButtonStatusUrl() async {
    final res = await fieldProvider.queryDetailButtonStatusUrl(fieldId);
    if (res.code == 200) {
      buttonStatusDataModel = res.data!;
      update();
    }
  }

  Future<void> getGoodsCount() async {
    final res = await cartProvider.queryGoodsCountInCart();
    if (res.data != null) {
      goodsCount = res.data!.cardNumber;
      orderCount = res.data!.orderNum;
      update(['update_goods_count']);
    }
  }

  Future<void> addGoods(int goodsId) async {
    final res = await cartProvider.addGoodsToCart(goodsId, 1);
    if (res.code == 200) {
      showToast(res.msg);
      await getGoodsCount();
      update(['update_goods_count']);
    }
  }

  void onJumpToGoodsDetail(int goodsId) {
    Get.toNamed(Routes.GOODS_DETAIL, arguments: goodsId);
  }

  late Timer timer;
  int nowUnixTime = 86400;
  RxString timeRemaining = ''.obs;
  RxInt time = 0.obs;

  void receiveTimeValue(int value) {
    time.value = value;
    launchTimer();
  }

  void launchTimer() {
    int days = DateTime.fromMillisecondsSinceEpoch(time.value)
        .difference(DateTime.now())
        .inDays;
    Countdown(days, (time) {
      timeRemaining.value = time;
      print(time);
    });
    // timer = Timer.periodic(Duration(seconds: 1), (value) {
    //   nowUnixTime--;
    //   if (nowUnixTime == 0) {
    //     timer.cancel();
    //   }
    //   timeRemaining.value = '${days}天   ${constructTime(nowUnixTime)}';
    // });
  }

  Future<void> onCallPhone(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  Future<void> onClipPhone(String phoneNumber) async {
    await Clipboard.setData(ClipboardData(text: phoneNumber));
    showToast('复制成功');
  }

  Future<void> onLaunchInBrowser(String url) async {
    if (!await launchUrl(
      Uri.parse(url),
      mode: LaunchMode.externalNonBrowserApplication,
    )) {
      showToast('Could not launch $url');
      throw Exception('Could not launch $url');
    }
  }

  void cancelTimer() {
    if (timer != null) {
      timer.cancel();
    }
  }

  String constructTime(int seconds) {
    int hour = seconds ~/ 3600;
    int minute = seconds % 3600 ~/ 60;
    int second = seconds % 60;
    return ' ' +
        formatTime(hour) +
        "  : " +
        formatTime(minute) +
        " : " +
        formatTime(second);
  }

  String formatTime(int timeNum) {
    return timeNum < 10 ? "0" + timeNum.toString() : timeNum.toString();
  }
}
