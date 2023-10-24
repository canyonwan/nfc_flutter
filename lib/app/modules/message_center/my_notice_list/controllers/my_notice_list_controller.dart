import 'package:easy_refresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:mallxx_app/app/models/notice_list_model.dart';
import 'package:mallxx_app/app/modules/root/providers/member_provider.dart';

class MyNoticeListController extends GetxController
    with StateMixin<NoticeDatatModel> {
  int type = 0;

  final MemberProvider memberProvider = Get.find<MemberProvider>();
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
    type = Get.arguments;
    if (type != null) {
      queryMessageList();
    }
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  Future<void> queryMessageList() async {
    change(null, status: RxStatus.loading());
    final res = await memberProvider.queryMessageList(page, type);
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
    await queryMessageList();
    easyRefreshController.finishRefresh();
  }

  Future<void> onLoadMore() async {
    if (page < totalPage) {
      page++;
      await queryMessageList();
      easyRefreshController.finishLoad();
    } else {
      easyRefreshController.finishLoad(IndicatorResult.noMore);
    }
  }
}
