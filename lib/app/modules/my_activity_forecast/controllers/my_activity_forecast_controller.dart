import 'package:better_video_player/better_video_player.dart';
import 'package:fluwx/fluwx.dart';
import 'package:get/get.dart';
import 'package:mallxx_app/app/models/ad_model.dart';
import 'package:mallxx_app/app/modules/root/providers/cart_provider.dart';
import 'package:mallxx_app/app/modules/root/providers/find_provider.dart';
import 'package:mallxx_app/app/modules/root/providers/member_provider.dart';
import 'package:mallxx_app/app/routes/app_pages.dart';
import 'package:oktoast/oktoast.dart';

class MyActivityForecastController extends GetxController
    with StateMixin<ADDataModel> {
  int adId = 0;
  final MemberProvider _memberProvider = Get.find<MemberProvider>();
  final FindProvider _findProvider = Get.find<FindProvider>();
  final CartProvider cartProvider = Get.find<CartProvider>();

  ADDataModel data = ADDataModel();
  late final BetterVideoPlayerController videoController;

  @override
  void onInit() {
    adId = Get.arguments['adId'];
    // 发现列表type是3是吃货模式，和广告详情一样，所以复用这个页面
    if (Get.arguments['type'] == 0) {
      getAdDetail();
    } else if (Get.arguments['type'] == 1) {
      getSwiperAdDetail();
    } else if (Get.arguments['type'] == 3) {
      getFoodieDetail();
    }
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    videoController = BetterVideoPlayerController();
  }

  @override
  void onClose() {
    super.onClose();
    videoController.dispose();
  }

  Future<void> addGoods(int goodsId) async {
    final res = await cartProvider.addGoodsToCart(goodsId, 1);
    if (res.code == 200) {
      showToast(res.msg);
    }
  }

  Future<void> getAdDetail() async {
    change(null, status: RxStatus.loading());
    final res = await _memberProvider.queryAdDetail(adId);
    if (res.code == 200 && res.data != null) {
      change(res.data, status: RxStatus.success());
      data = res.data!;
    } else {
      change(null, status: RxStatus.error(res.msg));
    }
  }

  // 获取吃货模式详情
  Future<void> getFoodieDetail() async {
    change(null, status: RxStatus.loading());
    final res = await _findProvider.queryFindFoodieDetail(adId);
    if (res.code == 200 && res.data != null) {
      change(res.data, status: RxStatus.success());
      data = res.data!;
    } else {
      change(null, status: RxStatus.error(res.msg));
    }
  }

  Future<void> onReceiveVoucher(int id) async {
    final res = await _memberProvider.receiveVoucher(id);
    if (res.code == 200) {
      showToast(res.msg);
    }
  }

  Future<void> getSwiperAdDetail() async {
    change(null, status: RxStatus.loading());
    final res = await _memberProvider.querySwiperAdDetailUrl(adId);
    if (res.code == 200 && res.data != null) {
      change(res.data, status: RxStatus.success());
      data = res.data!;
    } else {
      change(null, status: RxStatus.error(res.msg));
    }
  }

  Future<void> onShare() async {
    await shareToWeChat(WeChatShareWebPageModel(
      data.shareUrl!,
      thumbnail: WeChatImage.network(data.shareImage!),
      title: data.shareTitle!,
      description: data.shareExplain!,
    ));
  }

  void onToDetail(int goodsId) {
    Get.toNamed(Routes.GOODS_DETAIL, arguments: goodsId);
  }
}
