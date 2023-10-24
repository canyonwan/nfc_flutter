import '/app/models/product_model.dart';
import '/app/providers/base_provider.dart';

class ProductProvider extends BaseProvider {
  static const recommendListUrl = "/product/recommend/api/list";

  @override
  void onInit() {
    super.onInit();
  }

  Future<ProductList?> getRecommendProductList(
      {int pageNum = 1, int pageSize = 20}) async {
    final response = await get(recommendListUrl, query: {
      "page_num": pageNum.toString(),
      "page_size": pageSize.toString(),
    });

    return ProductList.fromJson(response.body);
  }
}
