import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:mallxx_app/app/models/goods_model.dart';
import 'package:mallxx_app/app/modules/root/providers/market_provider.dart';
import 'package:mallxx_app/app/modules/root/controllers/field_controller.dart';
import 'package:mallxx_app/app/routes/app_pages.dart';
import 'package:mallxx_app/const/resource.dart';
import 'package:fluwx/fluwx.dart';
import '../../../models/goods_detail_model.dart';
import 'package:mallxx_app/app/modules/root/providers/cart_provider.dart';

class MarketController extends GetxController {
  final MarketProvider _provider = Get.find<MarketProvider>();
  final fieldController = Get.find<FieldController>();
  final EasyRefreshController easyRefreshController = EasyRefreshController(
      controlFinishRefresh: true, controlFinishLoad: true);
  final CartProvider cartProvider = Get.find<CartProvider>();
  ScrollController scrollController = ScrollController();

  List<GoodsItemModel> goodsList = [];
  List<SelectionModel> selectionOptions = [
    SelectionModel(0, '默认', '', 0),
    // 0
    SelectionModel(1, '价格', R.ASSETS_ICONS_MARKET_SORT_DEFAULT_PNG, 1),
    // 1,2
    SelectionModel(2, '销量', R.ASSETS_ICONS_MARKET_SORT_DEFAULT_PNG, 3),
    // 3, 4
    SelectionModel(3, '评价数', R.ASSETS_ICONS_MARKET_SORT_DEFAULT_PNG, 5)
    // 5,6
  ];
  GoodsListDataModel goodsListDataModel = GoodsListDataModel();
  GoodsListSearchModel searchModel =
      GoodsListSearchModel(1, num: 6, type: 0, keyword: '');
  int totalPage = 0;
  bool browserLayout = true; // true: 浏览 1: 双排
  int goodsCount = 0; // 商品数量
  int orderCount = 0; // 订单数量

  @override
  void onInit() {
    getGoodsList();
    getGoodsCount();
    super.onInit();
  }

  Future<void> getGoodsList() async {
    final res = await _provider.queryGoodsList(searchModel);
    if (res.code == 200) {
      goodsListDataModel = res.data!;
      totalPage = res.data!.maxpage!;
      if (res.data!.list!.isNotEmpty) {
        goodsList.addAll(res.data!.list!);
      } else {
        goodsList = [];
      }
      update();
    }
  }

  void switchLayout() {
    browserLayout = !browserLayout;
    update();
  }

  String iconPath = '${R.ASSETS_ICONS_MARKET_SORT_DEFAULT_PNG}';

  Future<void> onSwitchSelection(SelectionModel e) async {
    goodsList.clear();
    if (searchModel.type != e.type) {
      searchModel.type = e.type;
      selectionOptions[e.id].type = e.type;
      return;
    }
    switch (e.type) {
      case 1:
        searchModel.type = 2;
        selectionOptions[e.id].type = 2;
        selectionOptions[e.id].icon = R.ASSETS_ICONS_MARKET_SORT_DOWN_PNG;
        break;

      case 2:
        searchModel.type = 1;
        selectionOptions[e.id].type = 1;
        selectionOptions[e.id].icon = R.ASSETS_ICONS_MARKET_SORT_UP_PNG;
        break;
      case 3:
        searchModel.type = 4;
        selectionOptions[e.id].type = 4;
        selectionOptions[e.id].icon = R.ASSETS_ICONS_MARKET_SORT_DOWN_PNG;
        break;

      case 4:
        searchModel.type = 3;
        selectionOptions[e.id].type = 3;
        selectionOptions[e.id].icon = R.ASSETS_ICONS_MARKET_SORT_UP_PNG;
        break;
      case 5:
        searchModel.type = 6;
        selectionOptions[e.id].type = 6;
        selectionOptions[e.id].icon = R.ASSETS_ICONS_MARKET_SORT_DOWN_PNG;
        break;

      case 6:
        searchModel.type = 5;
        selectionOptions[e.id].type = 5;
        selectionOptions[e.id].icon = R.ASSETS_ICONS_MARKET_SORT_UP_PNG;
        break;
    }
    searchModel.page = 1;
    update();
    await getGoodsList();
  }

  void onBackToTop() {
    scrollController.animateTo(0.0,
        duration: Duration(milliseconds: 500), curve: Curves.linearToEaseOut);
  }
  Future<void> getGoodsCount() async {
    final res = await cartProvider.queryGoodsCountInCart();
    if (res.data != null) {
      goodsCount = res.data!.cardNumber;
      orderCount = res.data!.orderNum;
      update(['update_goods_count']);
    }
  }
  Future<void> onRefresh() async {
    if (goodsList.isNotEmpty) goodsList.clear();
    searchModel.page = 1;
    await getGoodsList();
    easyRefreshController.finishRefresh();
  }

  Future<void> onSearch() async {
    final res =
        await Get.toNamed(Routes.SEARCH_VIEW, arguments: searchModel.keyword);
    searchModel.keyword = res ?? '';
    await onRefresh();
  }
  Future<void> shareToSession() async {
    await shareToWeChat(WeChatShareWebPageModel(
      goodsListDataModel.enjoy!.enjoyUrl!,
      thumbnail: WeChatImage.network(goodsListDataModel.enjoy!.image!),
      title: goodsListDataModel.enjoy!.title!,
      description: goodsListDataModel.enjoy!.content,
    ));
  }

  void onToDetail(int goodsId) {
    Get.toNamed(Routes.GOODS_DETAIL, arguments: goodsId);
  }

  Future<void> onLoadMore() async {
    if (totalPage == searchModel.page) {
      easyRefreshController.finishLoad(IndicatorResult.noMore);
      return;
    }
    searchModel.page++;
    await getGoodsList();
    easyRefreshController.finishLoad(
      searchModel.page == totalPage
          ? IndicatorResult.noMore
          : IndicatorResult.success,
    );
  }
  Future<void> onChangeAddress() async {
    await fieldController.onSelectAddress(false, changeCarts: getGoodsList);
  }
}

class GoodsListSearchModel {
  int page;
  int? num;
  int? type;
  String? keyword;
  String? address;

  GoodsListSearchModel(this.page,
      {this.num, this.type, this.keyword, this.address});

  Map<String, dynamic> toJson() => <String, dynamic>{
        'page': page,
        'num': num,
        'type': type,
        'keyword': keyword,
        'address': address,
      };
}

class SelectionModel {
  final int id;
  final String? name;
  String? icon;
  int type;

  SelectionModel(this.id, this.name, this.icon, this.type);
}
