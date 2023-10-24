import 'package:easy_refresh/easy_refresh.dart';
import 'package:get/get.dart';

import 'package:mallxx_app/app/api/granary_api.dart';
import 'package:mallxx_app/app/models/granary_operation_records_model.dart';

class OperationRecordsController extends GetxController
    with StateMixin<GranaryOperationRecordsDataModel> {
  late int granaryId;
  final GranaryProvider pro = Get.find<GranaryProvider>();
  GranaryOperationRecordsDataModel recordData =
      GranaryOperationRecordsDataModel();
  final EasyRefreshController easyRefreshController = EasyRefreshController(
    controlFinishRefresh: true,
    controlFinishLoad: true,
  );

  int page = 1;
  int totalPage = 1;

  @override
  void onInit() {
    granaryId = Get.arguments;

    getOperationRecords();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  Future<void> getOperationRecords() async {
    var res = await pro.granaryOperationRecords(granary_id: granaryId);
    if (res.code == 200) {
      recordData = res.data!;
      totalPage = res.data!.totalPage!;
      change(recordData, status: RxStatus.success());
      return;
    }
    change(recordData, status: RxStatus.error());
  }

  Future<void> onRefresh() async {
    if (recordData.recordList!.length > 0) {
      recordData.recordList!.clear();
    }
    await Future.delayed(Duration(milliseconds: 500), () {
      page = 1;
      getOperationRecords();
      easyRefreshController.finishRefresh();
    });
  }

  Future<void> onLoadMore() async {
    if (totalPage == page) {
      easyRefreshController.finishLoad(IndicatorResult.noMore);
      return;
    }
    page++;
    await getOperationRecords();
    easyRefreshController.finishLoad(
        page == totalPage ? IndicatorResult.noMore : IndicatorResult.success);
  }

  @override
  void onClose() {
    easyRefreshController.dispose();
    super.onClose();
  }
}
