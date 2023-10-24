import 'package:easy_refresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:mallxx_app/app/models/my_footprint_model.dart';
import 'package:mallxx_app/app/modules/root/providers/cart_provider.dart';
import 'package:mallxx_app/app/modules/root/providers/member_provider.dart';
import 'package:oktoast/oktoast.dart';

class MyFootprintController extends GetxController
    with StateMixin<MyFootprintDataModel> {
  final MemberProvider memberProvider = Get.find<MemberProvider>();
  final CartProvider cartProvider = Get.find<CartProvider>();

  final EasyRefreshController easyRefreshController = EasyRefreshController(
    controlFinishLoad: true,
    controlFinishRefresh: true,
  );

  MyFootprintDataModel data = MyFootprintDataModel();
  List<MyFootprintItemModel> list = [];
  int totalPage = 0;
  int page = 1;

  @override
  void onInit() {
    getList();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  Future<void> getList() async {
    final res = await memberProvider.queryFootprintList(page);
    if (res.code == 200 && res.data != null) {
      change(res.data, status: RxStatus.success());
      data = res.data!;
      totalPage = res.data!.totalPage ?? 0;
      if (res.data!.list!.isNotEmpty) {
        list.addAll(res.data!.list!);
      } else {
        list = [];
      }
    } else {
      change(null, status: RxStatus.error(res.msg));
    }
  }

  Future<void> onRefresh() async {
    page = 1;
    if (list.isNotEmpty) {
      list.clear();
    }
    await getList();
    easyRefreshController.finishRefresh();
  }

  Future<void> onLoadMore() async {
    if (page < totalPage) {
      page++;
      await getList();
      easyRefreshController.finishLoad();
    } else {
      easyRefreshController.finishLoad(IndicatorResult.noMore);
    }
  }

  Future<void> addGoodsToCart(int goodsId) async {
    final res = await cartProvider.addGoodsToCart(goodsId, 1);
    if (res.code == 200) {
      showToast(res.msg);
      update(['update_goods_count']);
    }
  }

  @override
  void onClose() {
    super.onClose();
    easyRefreshController.dispose();
  }
}
