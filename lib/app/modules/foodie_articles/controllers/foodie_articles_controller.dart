import 'package:easy_refresh/easy_refresh.dart';
import 'package:fluwx/fluwx.dart';
import 'package:get/get.dart';
import 'package:mallxx_app/app/models/foodie_article_list_model.dart';
import 'package:mallxx_app/app/models/foodie_article_menu_model.dart';
import 'package:mallxx_app/app/modules/root/providers/find_provider.dart';
import 'package:mallxx_app/app/routes/app_pages.dart';

class FoodieArticlesController extends GetxController {
  final FindProvider findProvider = Get.find<FindProvider>();

  final EasyRefreshController easyRefreshController = EasyRefreshController(
      controlFinishRefresh: true, controlFinishLoad: true);

  int page = 1;
  int totalPage = 0;
  int listId = 0;
  bool menuLoading = false;
  bool articleLoading = false;

  List<FoodieArticleMenuItemModel> menus = [];
  List<FoodieArticleItemModel> articles = [];

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    getFoodieArticlesCategoryList();
    super.onReady();
  }

  Future<void> onRefresh() async {
    page = 1;
    await getFoodieArticlesList();
    easyRefreshController.finishRefresh();
  }

  // 加载更多
  Future<void> onLoadMore() async {
    if (page == totalPage) {
      easyRefreshController.finishLoad(IndicatorResult.noMore);
      return;
    }
    page++;
    await getFoodieArticlesList();
    easyRefreshController.finishLoad();
  }

  void onToDetail(int id) {
    Get.toNamed(Routes.MY_ACTIVITY_FORECAST,
        arguments: {'adId': id, 'type': 3});
  }

  // 获取吃货文章菜单列表
  Future<void> getFoodieArticlesCategoryList() async {
    menuLoading = true;
    var res = await findProvider.queryFoodieArticleMenus();
    if (res.code == 200) {
      menus = res.data!;
      menuLoading = false;
      if (menus.length > 0) {
        listId = menus[0].id;
        await getFoodieArticlesList();
      }
      update(['menus']);
    }
  }

  // 获取吃货文章列表
  Future<void> getFoodieArticlesList() async {
    articleLoading = true;
    var res =
        await findProvider.queryFoodieArticleList(listId: listId, page: page);
    if (res.code == 200) {
      totalPage = res.data!.totalPage;
      if (res.data != null && res.data!.list.length > 0) {
        articles.addAll(res.data!.list);
      } else {
        articles = [];
      }
      articleLoading = false;
      update(['articles']);
    }
  }

  Future<void> onMenuTap(int id) async {
    listId = id;
    page = 1;
    articles.clear();
    update(['menuTap']);
    await getFoodieArticlesList();
  }

  Future<void> onShareFoodie() async {
    var res = await findProvider.shareFoodie();
    if (res.code == 200 && res.data != null) {
      await shareToWeChat(WeChatShareWebPageModel(
        res.data!.enjoyUrl!,
        thumbnail: WeChatImage.network(res.data!.image!),
        title: res.data!.title!,
        description: res.data!.content,
      ));
    }
  }

  @override
  void onClose() {
    easyRefreshController.dispose();
    super.onClose();
  }
}
