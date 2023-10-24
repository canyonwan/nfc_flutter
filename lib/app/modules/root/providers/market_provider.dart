import 'package:mallxx_app/app/models/goods_detail_model.dart';
import 'package:mallxx_app/app/modules/root/controllers/market_controller.dart';

import '/app/models/goods_model.dart';
import '/app/providers/base_provider.dart';

//import '/app/models/product_model.dart';
// 集市
class MarketProvider extends BaseProvider {
  static const productListUrl = "/apitest/new_goods_list";
  static const goodsDetailUrl = "apitest/goods_details";
  static const goodsShowListUrl = "api/goods_show_list";
  static const goodsCommentUrl = "apitest/new_member_comment";
  static const markLikeUrl = "api/member_appetite"; // 标记为喜欢

  @override
  void onInit() {
    super.onInit();
  }

  Future<GoodsListRootModel> queryGoodsList(GoodsListSearchModel model) async {
    final response = await post(productListUrl, model.toJson());
    return GoodsListRootModel.fromJson(response.body);
  }

  Future<GoodsDetailRootModel> queryGoodsDetail(
      int goodsId, String mergename) async {
    final response = await post(
        goodsDetailUrl, {'goods_id': goodsId, 'mergename': mergename});

    return GoodsDetailRootModel.fromJson(response.body);
  }

  Future<CookbookEvaluateRootModel> queryGoodsCookbooks(int goodsId,
      {int? page, int? num}) async {
    final response = await post(
        goodsShowListUrl, {'goods_id': goodsId, 'page': page, 'num': num});

    return CookbookEvaluateRootModel.fromJson(response.body);
  }

  Future<GoodsCommentRootModel> queryGoodsComments(int goodsId,
      {int? page, int? num}) async {
    final response = await post(
        goodsCommentUrl, {'goods_id': goodsId, 'page': page, 'num': num});

    return GoodsCommentRootModel.fromJson(response.body);
  }

  // 1=标记为不喜欢,2=取消不喜欢,3=标记为喜欢,4=取消喜欢
  Future<GoodsCommentRootModel> queryGoodsDetailLike(
      {required int type, required int goodsId}) async {
    final response =
        await post(markLikeUrl, {'type': type, 'goods_id': goodsId});

    return GoodsCommentRootModel.fromJson(response.body);
  }
}
