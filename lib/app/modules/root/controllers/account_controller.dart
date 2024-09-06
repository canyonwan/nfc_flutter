import 'dart:async';

import 'package:easy_refresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:mallxx_app/app/models/account_info_model.dart';
import 'package:mallxx_app/app/models/guess_like_model.dart';
import 'package:mallxx_app/app/models/qr_code_model.dart';
import 'package:mallxx_app/app/modules/root/providers/member_provider.dart';
import 'package:mallxx_app/app/modules/views/my_qrcode_view.dart';
import 'package:mallxx_app/app/routes/app_pages.dart';
import 'package:oktoast/oktoast.dart';
import 'package:url_launcher/url_launcher.dart';

import '/app/models/product_model.dart';
import '/app/providers/login_provider.dart';

class AccountController extends GetxController
    with StateMixin<AccountInfoDataModel> {
  final EasyRefreshController easyRefreshController = EasyRefreshController(
    controlFinishLoad: true,
    controlFinishRefresh: true,
  );

  final LoginProvider loginProvider = Get.find<LoginProvider>();
  final MemberProvider memberProvider = Get.find<MemberProvider>();

  final productList = RxList<Product>();

  // final isLoding = true.obs;

  // final member = UserInfoModel().obs;
  AccountInfoDataModel info = AccountInfoDataModel();

  // 猜你喜欢列表
  GuessLikeDataModel guessLikeData = GuessLikeDataModel();

  @override
  void onInit() {
    // setMember();
    getAccountInfo();
    super.onInit();
  }

  Future<void> getAccountInfo() async {
    // change(null, status: RxStatus.loading());
    final res = await memberProvider.queryAccountInfo();
    if (res.code == 200) {
      change(res.data, status: RxStatus.success());
      info = res.data!;
      update();
    } else {
      change(null, status: RxStatus.error(res.msg));
    }
  }

  Future<void> onLaunchInBrowser() async {
    var url = 'https://work.weixin.qq.com/kfid/kfc293acb0f76407da6';
    if (!await launchUrl(
      Uri.parse(url),
      mode: LaunchMode.externalNonBrowserApplication,
    )) {
      showToast('Could not launch $url');
      throw Exception('Could not launch $url');
    }
  }

  late final Timer timer;
  int nowUnixTime = 3600;
  RxString timeRemaining = ''.obs;

  Future<void> toSettings() async {
    await Get.toNamed(Routes.SETTING);
    getAccountInfo();
  }

  void launchTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (value) {
      nowUnixTime--;
      if (nowUnixTime == 0) {
        timer.cancel();
      }
      // parseTime(nowUnixTime);
      timeRemaining.value = '支付时间剩余时间: ${constructTime(3600)}';
    });
  }

  void cancelTimer() {
    if (timer != null) {
      timer.cancel();
    }
  }

  Future<void> onRefresh() async {
    await getAccountInfo();
    easyRefreshController.finishRefresh();
  }

  // 1h = 60m  1h = 60*60 = 3600s
  // 1m = 60s   1m = 60s*
  String constructTime(int seconds) {
    int hour = seconds ~/ 3600;
    int minute = seconds % 3600 ~/ 60;
    int second = seconds % 60;
    return formatTime(hour) +
        ":" +
        formatTime(minute) +
        ":" +
        formatTime(second);
  }

  String formatTime(int timeNum) {
    return timeNum < 10 ? "0" + timeNum.toString() : timeNum.toString();
  }

  void parseTime(double difference) {
    int hour = difference ~/ 60;
    int minute = difference ~/ 60;
    int sec = (difference % 60).toInt();
    timeRemaining.value = '支付剩余时间 ${hour}小时${minute}分钟${sec}秒';
  }

  void setMember() {
    if (loginProvider.getMember() != null) {
      // member.value = loginProvider.getMember()!;
    } else {
      // member.value = UserInfoModel(); //设置成空
    }
    update();
  }

  void onSelectItem(AdItemModel m) {
    Get.toNamed(Routes.MY_ACTIVITY_FORECAST,
        arguments: {'adId': m.id, 'type': 0});
  }

  void onTapItem(SwiperItemModel m) {
    Get.toNamed(Routes.MY_ACTIVITY_FORECAST,
        arguments: {'adId': m.id, 'type': 1});
  }

  void openVip() {
    Get.toNamed(Routes.MY_VIP);
  }

  Future<void> onEditNickname() async {
    final res = await Get.toNamed(Routes.CHANGE_MEMBER_NAME,
        arguments: info.memberName);
    info.memberName = res ?? info.memberName;
    update();
  }

  MyQRCodeDataModel qrCodeDataModel = MyQRCodeDataModel();

  Future<void> getMyQrCode() async {
    final res = await memberProvider.queryMyQrCode();
    if (res.code == 200) {
      qrCodeDataModel = res.data!;
      update();
    }
  }

  Future<void> onViewQRCode() async {
    await getMyQrCode();
    Get.to(() => MyQrcodeView(qrCodeDataModel));
  }

  void onViewBluetooth(){
    Get.toNamed(Routes.BLUETOOTH_LIST);
  }

  @override
  void onClose() {
    easyRefreshController.dispose();
    cancelTimer();
    super.onClose();
  }
}
