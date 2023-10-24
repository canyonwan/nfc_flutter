import 'package:easy_refresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:mallxx_app/app/models/guess_like_model.dart';
import 'package:mallxx_app/app/modules/root/providers/cart_provider.dart';
import 'package:mallxx_app/app/modules/root/providers/member_provider.dart';
import 'package:oktoast/oktoast.dart';

class MyLikesController extends GetxController
    with StateMixin<GuessLikeDataModel> {
  final MemberProvider memberProvider = Get.find<MemberProvider>();
  final CartProvider cartProvider = Get.find<CartProvider>();

  final EasyRefreshController easyRefreshController = EasyRefreshController(
    controlFinishLoad: true,
    controlFinishRefresh: true,
  );

  GuessLikeDataModel data = GuessLikeDataModel();
  List<GuessGoodsModel> list = [];
  int totalPage = 0;
  int page = 1;
  bool showTags = false;

  // 1=全部，2=仅看有货
  int currentTag = 1;
  List<Map<String, dynamic>> tags = [
    {
      'label': '全部',
      'value': 1,
    },
    {
      'label': '仅看有货',
      'value': 2,
    }
  ];

  // type 1 喜欢  2 足迹  3 猜你喜欢
  int type = 1;

  @override
  void onInit() {
    getList();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  void onSelectTag(int tag) {
    currentTag = tag;
    update();
    easyRefreshController.callRefresh();
  }

  Future<void> getList() async {
    change(null, status: RxStatus.loading());
    final res = await memberProvider.queryLikeList(page, currentTag);
    if (res.code == 200) {
      if (res.data != null) {
        change(res.data, status: RxStatus.success());
        data = res.data!;
        totalPage = res.data!.totalPage!;
        if (res.data!.goodsList!.isNotEmpty) {
          list.addAll(res.data!.goodsList!);
        }
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
