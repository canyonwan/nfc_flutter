import 'package:easy_refresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:mallxx_app/app/models/integral_list_model.dart';
import 'package:mallxx_app/app/modules/root/providers/member_provider.dart';

class MyIntegralController extends GetxController
    with StateMixin<IntegralDataModel> {
  final EasyRefreshController easyRefreshController = EasyRefreshController(
      controlFinishRefresh: true, controlFinishLoad: true);
  MemberProvider _memberProvider = Get.find<MemberProvider>();

  int page = 1;
  int totalPage = 0;
  List<IntegralItemModel> list = [];
  late IntegralDataModel data;

  @override
  void onInit() {
    getList();
    super.onInit();
  }

  Future<void> getList() async {
    final res = await _memberProvider.queryIntegralList(page);
    if (res.code == 200 && res.data != null) {
      change(res.data, status: RxStatus.success());
      data = res.data!;
      totalPage = res.data!.maxpage ?? 0;
      if (res.data!.integralListInfo!.isNotEmpty) {
        list.addAll(res.data!.integralListInfo!);
      } else {
        list = [];
      }
    } else {
      change(null, status: RxStatus.error(res.msg));
    }
  }

  Future<void> onRefresh() async {
    if (list.isNotEmpty) {
      list.clear();
    }
    page = 1;
    await getList();
    easyRefreshController.finishRefresh();
    easyRefreshController.resetFooter();
  }

  Future<void> onLoadMore() async {
    if (totalPage == page) {
      easyRefreshController.finishLoad(IndicatorResult.noMore);
      return;
    }
    page++;
    await getList();
    easyRefreshController.finishLoad(
        page == totalPage ? IndicatorResult.noMore : IndicatorResult.success);
  }
}
