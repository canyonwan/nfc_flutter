import 'package:easy_refresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:mallxx_app/app/models/balance_model.dart';
import 'package:mallxx_app/app/modules/root/providers/member_provider.dart';
import 'package:mallxx_app/app/routes/app_pages.dart';
import 'package:mallxx_app/utils/enums.dart';

class MyBalanceController extends GetxController
    with StateMixin<BalanceDataModel> {
  final EasyRefreshController easyRefreshController = EasyRefreshController(
      controlFinishRefresh: true, controlFinishLoad: true);
  MemberProvider _memberProvider = Get.find<MemberProvider>();

  int page = 1;
  int totalPage = 0;
  String price = '0.01'; // 充值的金额

  List<BalanceItemModel> list = [];
  late BalanceDataModel data;

  @override
  void onInit() {
    getList();
    super.onInit();
  }

  Future<void> getList() async {
    final res = await _memberProvider.queryBalanceList(page);
    if (res.code == 200) {
      change(res.data, status: RxStatus.success());
      if (res.data != null) {
        data = res.data!;
        totalPage = res.data!.maxpage ?? 0;
        if (res.data!.list!.isNotEmpty) {
          list.addAll(res.data!.list!);
          return;
        }
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
  }

  Future<void> onLoadMore() async {
    print('page: $page');
    if (page < totalPage) {
      page++;
      await getList();
      easyRefreshController.finishLoad();
    } else {
      easyRefreshController.finishLoad(IndicatorResult.noMore);
    }
  }

  void onChanged(value) {
    price = value;
  }

  Future<void> generateBalanceOrder() async {
    final res = await _memberProvider.createBalanceOrder(price);
    await Get.toNamed(Routes.ORDER_PAYMENT, arguments: {
      'payPrice': price,
      'payType': PayTypeEnum.remaining,
      'orderCode': res.data!.orderSn!
    });
    easyRefreshController.callRefresh();
  }
}
