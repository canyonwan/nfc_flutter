import 'package:mallxx_app/app/models/ad_model.dart';
import 'package:mallxx_app/app/models/city_data_model.dart';
import 'package:mallxx_app/app/models/find_dynamic_detail_model.dart';
import 'package:mallxx_app/app/models/find_model_entity.dart';
import 'package:mallxx_app/app/models/find_videodetail_model.dart';
import 'package:mallxx_app/app/models/foodie_article_list_model.dart';
import 'package:mallxx_app/app/models/foodie_article_menu_model.dart';
import 'package:mallxx_app/app/models/response_model.dart';
import 'package:mallxx_app/app/models/share_foodie_model.dart';

import '/app/providers/base_provider.dart';

class FindProvider extends BaseProvider {
  static const String cityPickerDataUrl = "apisj/get_area";
  static const String findListDataUrl = "apitest/discover";
  static const String findCollectUrl = "apitest/discover_collect";
  static const String findFoodieDetailUrl = "api/html_foodie_article";
  static const String findVideoDetailUrl = '/apizhibo/video_detail'; //发现的视频详情
  static const String findDynamicDetailUrl =
      'apipartner/partner_notice_detail'; //公告动态详情

  static const String foodieArticleMenuUrl = '/api/foodie_category'; //吃货分类
  static const String foodieArticleListUrl = '/api/foodie_list'; //吃货文章列表
  static const String shareFoodieUrl = '/api/foodie_share'; // 吃货模式分享

  @override
  void onInit() {
    // httpClient.defaultDecoder = (map) {
    //   if (map is Map<String, dynamic>) return newcategory.fromJson(map);
    // };
    super.onInit();
  }

  // 省市区三级列表
  Future<CityDataRootModel> queryCityPickerData() async {
    final response = await post(cityPickerDataUrl, {});
    return CityDataRootModel.fromJson(response.body);
  }

  // 发现列表
  Future<FindRootModel> queryFindList(
      {int? page = 1, String? mergename}) async {
    final response =
        await post(findListDataUrl, {'page': page, 'mergename': mergename});
    return FindRootModel.fromJson(response.body);
  }

  // 发现详细页面-短视频详情
  Future<FindVideoDetailRootModel> queryFindShortVideoDetail(int id) async {
    final resp = await post(findVideoDetailUrl, {'id': id});
    return FindVideoDetailRootModel.fromJson(resp.body);
  }

  // 发现详细页面-公告动态详情
  Future<FindDynamicDetailRootModel> queryFindDynamicDetailUrl(int id) async {
    final resp = await post(findDynamicDetailUrl, {'id': id});
    return FindDynamicDetailRootModel.fromJson(resp.body);
  }

  // 发现详细页面-吃货模式详情
  Future<ADRootModel> queryFindFoodieDetail(int articleId) async {
    final resp = await post(findFoodieDetailUrl, {'article_id': articleId});
    return ADRootModel.fromJson(resp.body);
  }

  // 发现详细页面-收藏
  Future<ResponseData> findCollect(
      {required int id, required int status, required int type}) async {
    final resp =
        await post(findCollectUrl, {'id': id, 'status': status, 'type': type});
    return ResponseData.fromJson(resp.body);
  }

  // 吃货分类
  Future<FoodieArticleMenuRootModel> queryFoodieArticleMenus() async {
    final resp = await post(foodieArticleMenuUrl, {});
    return FoodieArticleMenuRootModel.fromJson(resp.body);
  }

  // 吃货文章列表
  Future<FoodieArticleListRootModel> queryFoodieArticleList(
      {required int listId, required int page}) async {
    final resp =
        await post(foodieArticleListUrl, {'list_id': listId, 'page': page});
    return FoodieArticleListRootModel.fromJson(resp.body);
  }

  // 吃货模式分享
  Future<ShareFoodieRootModel> shareFoodie() async {
    final resp = await post(shareFoodieUrl, {});
    return ShareFoodieRootModel.fromJson(resp.body);
  }
}
