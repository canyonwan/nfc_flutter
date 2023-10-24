import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:mallxx_app/app/api/granary_api.dart';
import 'package:mallxx_app/app/models/granary_list_model.dart';
import 'package:mallxx_app/app/routes/app_pages.dart';
import 'package:oktoast/oktoast.dart';

class GranaryController extends GetxController
    with StateMixin<GranaryListDataModel> {
  final GranaryProvider pro = Get.find<GranaryProvider>();
  final EasyRefreshController easyRefreshController = EasyRefreshController(
      controlFinishRefresh: true, controlFinishLoad: true);

  TextEditingController textEditingController = TextEditingController();
  ScrollController scrollController = new ScrollController();

  int page = 1;
  int totalPage = 0;
  RxInt count = 1.obs;
  String totalPrice = '';
  int currentFieldOffset = 0;
  GranaryListDataModel granary = GranaryListDataModel();

  @override
  void onInit() {
    getGranaryList();
    textEditingController.text = count.value.toString();
    scrollController.addListener(() {
      currentFieldOffset = scrollController.position.pixels.toInt();
      update(['onFieldOffsetChange']);
      print("滑动距离$currentFieldOffset ");
    });

    super.onInit();
  }

  // void onFieldOffsetChange(double offset) {
  //   currentFieldOffset = offset.ceilToDouble();
  //   print('offset: ${offset} | currentFieldOffset: ${currentFieldOffset}');
  //   update(['onFieldOffsetChange']);
  // }

  void getCurrentPrice(String price) {
    count.value = 1;
    textEditingController.text = count.value.toString();
    totalPrice = (double.parse(price) * count.value).toStringAsFixed(2);
    update();
  }

  Future<void> getGranaryList({int? fieldId}) async {
    change(null, status: RxStatus.loading());
    var res = await pro.queryGranaryList(page: page, article_id: fieldId);
    if (res.code == 200) {
      granary = res.data!;
      totalPage = res.data!.totalPage!;
      if (granary.articleList!.isEmpty) {
        change(null, status: RxStatus.empty());
      } else {
        change(res.data, status: RxStatus.success());
        update();
      }
    } else {
      change(null, status: RxStatus.error('${res.msg}, 点击刷新'));
    }
  }

  Future<void> onRefresh() async {
    if (granary.granaryList!.length > 0) {
      granary.granaryList!.clear();
    }
    // if (granary.articleList!.length > 0) {
    //   granary.articleList!.clear();
    // }
    page = 1;
    await getGranaryList();
    easyRefreshController.finishRefresh();
  }

  Future<void> onLoadMore() async {
    if (totalPage == page) {
      easyRefreshController.finishLoad(IndicatorResult.noMore);
      return;
    }
    page++;
    await getGranaryList();
    easyRefreshController.finishLoad(
        page == totalPage ? IndicatorResult.noMore : IndicatorResult.success);
  }

  // 增加计数
  void onIncrement(String price) {
    count.value++;
    textEditingController.text = count.value.toString();
    totalPrice = (double.parse(price) * count.value).toStringAsFixed(2);
    print('on increment: $totalPrice');
    update();
  }

  // 减少计数
  void onDecrement(String price) {
    if (count.value == 1) {
      showToast('不能再减了');
      return;
    }
    count.value--;
    textEditingController.text = count.value.toString();
    totalPrice = (double.parse(price) * count.value).toStringAsFixed(2);
    update();
  }

  void forwardOperationRecords(int granaryId) {
    Get.toNamed(Routes.OPERATION_RECORDS, arguments: granaryId);
  }

  // 确定回收
  Future<void> onRecycle(int id) async {
    var res = await pro.granaryRecycle(granary_id: id, num: count.toString());
    if (res.code == 200) {
      showToast('操作成功');
      Get.back();
      easyRefreshController.callRefresh();
    } else {
      showToast('操作失败');
    }
  }

  // 确定捐赠
  Future<void> onDonate(int id) async {
    var res = await pro.granaryDonate(granary_id: id, num: count.toString());
    if (res.code == 200) {
      showToast('${res.msg}');
      Get.back();
      easyRefreshController.callRefresh();
    } else {
      showToast('${res.msg}');
    }
  }

  // 去加工
  void onProcess(int granaryId) {
    Get.toNamed(Routes.PROCESS, arguments: granaryId);
  }

  @override
  void onClose() {
    easyRefreshController.dispose();
    scrollController.dispose();
  }
}
