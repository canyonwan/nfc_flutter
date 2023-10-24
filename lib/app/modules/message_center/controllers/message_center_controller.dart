import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:mallxx_app/app/models/notice_list_model.dart';
import 'package:mallxx_app/app/modules/root/providers/member_provider.dart';
import 'package:mallxx_app/app/providers/login_provider.dart';
import 'package:mallxx_app/app/routes/app_pages.dart';
import 'package:meiqia_sdk_flutter/meiqia_sdk_flutter.dart';
import 'package:oktoast/oktoast.dart';
import 'package:fluwx/fluwx.dart' as fluwx;

class MessageCenterController extends GetxController
    with StateMixin<NoticeDatatModel> {
  final MemberProvider _memberProvider = Get.find<MemberProvider>();
  LoginProvider _loginProvider = Get.find<LoginProvider>();
  final EasyRefreshController easyRefreshController = EasyRefreshController(
    controlFinishLoad: true,
    controlFinishRefresh: true,
  );
  int page = 1;
  int totalPage = 0;

  NoticeDatatModel messageData = NoticeDatatModel();
  List<NoticeItemModel> messageList = [];

  @override
  void onInit() {
    queryNoticeList();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  Future<void> queryNoticeList() async {
    change(null, status: RxStatus.loading());
    final res = await _memberProvider.queryNoticeList(page);
    if (res.code == 200 && res.data != null) {
      messageData = res.data!;
      totalPage = res.data!.maxpage!;
      change(res.data, status: RxStatus.success());
      if (res.data!.noticeList!.isNotEmpty) {
        messageList.addAll(res.data!.noticeList!);
      }
    } else {
      change(null, status: RxStatus.error(res.msg));
    }
  }

  Future<void> onRefresh() async {
    page = 1;
    if (messageList.isNotEmpty) {
      messageList.clear();
    }
    await queryNoticeList();
    easyRefreshController.finishRefresh();
  }

  Future<void> onLoadMore() async {
    if (page < totalPage) {
      page++;
      await queryNoticeList();
      easyRefreshController.finishLoad();
    } else {
      easyRefreshController.finishLoad(IndicatorResult.noMore);
    }
  }

  Future<void> onClearMessage() async {
    EasyLoading.show();
    final res = await _memberProvider.clearMessage();
    easyRefreshController.callRefresh();
    EasyLoading.dismiss();
    showToast(res.msg);
  }

  // 0 查看系统通知列表
  // 1 查看交易物流列表
  void onViewSystemNotice(int type) {
    Get.toNamed(Routes.MY_NOTICE_LIST, arguments: type);
  }

  /// 配置聊天页面 UI 样式
  void  callChat() async {
    /// 美洽
   /* Style style = Style(
      navBarBackgroundColor: '#8BBF37', // 设置导航栏的背景色
      navBarTitleTxtColor: '#ffffff', // 设置导航栏上的 title 的颜色
      enableShowClientAvatar: true, // 是否支持当前用户头像的显示
      enableSendVoiceMessage: true, // 是否支持发送语音消息
    );
    if (_loginProvider.isLogin()) {
      var userInfoModel = _loginProvider.getMember();
      if (userInfoModel != null && userInfoModel.id != null) {
        var res2 = MQManager.instance.show(
            style: style,
            customizedId: userInfoModel.id!.toString(),
            scheduledGroup: '32c284ffbb9c8f4023b3ea6cbc0401a9');
        debugPrint('美洽customizedId：$res2');
      }
    }*/
    /// 微信客服

    ///是否安装微信
    bool isInstalled = await fluwx.isWeChatInstalled;
    if (!isInstalled) {
      showToast("请先安装微信");
      return;
    }
    fluwx.openWeChatCustomerServiceChat(url:"https://work.weixin.qq.com/kfid/kfc293acb0f76407da6",corpId: "wwc87db53db4eb95bb");
  }
}
