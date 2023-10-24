import 'package:easy_refresh/easy_refresh.dart';
import 'package:get/get.dart';

import '../providers/advertisement_provider.dart';
import '../providers/product_provider.dart';
import '/app/models/advertisement_model.dart';
import '/app/models/product_model.dart';

// 粮仓
class HomeController extends GetxController {
  final AdvertisementProvider advertisemenProvider =
      Get.find<AdvertisementProvider>();

  final ProductProvider productProvider = Get.find<ProductProvider>();

  final adList = RxList<Advertisement>();
  final promotionAdList = RxList<Advertisement>();
  final productList = RxList<Product>();

  final isLoading = true.obs;

  int requestCount = 3;
  int currentRequestCount = 0;

  final EasyRefreshController easyRefreshController = EasyRefreshController(
    controlFinishRefresh: true,
    controlFinishLoad: true,
  );
  int pageNum = 1;
  int pageSize = 20;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    getPageAd();
    getPromotionAd();
    getRecommendProduct();
  }

  void getPageAd() async {
    var data = await getAdList(pos: 2);
    if (data != null) {
      adList.addAll(data);
    }
  }

  void getPromotionAd() async {
    var data = await getAdList(pos: 1);
    if (data != null) {
      promotionAdList.addAll(data);
    }
  }

  Future<List<Advertisement>?> getAdList(
      {required int pos, int categoryId = 0}) async {
    final AdvertisementList? res =
        await advertisemenProvider.getAdvertise(pos, category_id: categoryId);

    currentRequestCount++;
    if (currentRequestCount >= requestCount) {
      isLoading.value = false;
    }

    if (res != null) {
      if (res.code == 200) {
        print(res.data);
        return res.data;
      } else {
        Get.snackbar("title", res.detail!);
        return null;
      }
    }
  }

  void getRecommendProduct({int pageNum = 1, int pageSize = 20}) async {
    this.pageNum = pageNum;
    var res = await productProvider.getRecommendProductList();
    currentRequestCount++;
    if (currentRequestCount >= requestCount) {
      isLoading.value = false;
    }

    if (res != null) {
      if (res.code == 200) {
        if (res.product != null) {
          productList.value = res.product!;
        }
      } else {
        Get.snackbar("title", res.detail!);
      }
    }
    easyRefreshController.finishRefresh(IndicatorResult.success);
  }

  void onLoadMore() async {
    pageNum++;
    var res = await productProvider.getRecommendProductList(
        pageNum: pageNum, pageSize: pageSize);

    if (res != null) {
      if (res.code == 200) {
        if (res.product != null) {
          productList.addAll(res.product!);
        } else {
          easyRefreshController.finishLoad(IndicatorResult.noMore);
          return;
        }
      } else {
        Get.snackbar("title", res.detail!);
      }
      easyRefreshController.finishLoad(IndicatorResult.noMore);
    }
  }

  @override
  void onClose() {
    super.onClose();
    easyRefreshController.dispose();
  }
}
