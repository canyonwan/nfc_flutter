import 'package:get/get.dart';

import '/app/models/advertisement_model.dart';
import '/app/providers/base_provider.dart';

class AdvertisementProvider extends BaseProvider {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return AdvertisementList.fromJson(map);
      if (map is List)
        return map.map((item) => AdvertisementList.fromJson(item)).toList();
    };
    super.onInit();
  }

  Future<AdvertisementList?> getAdvertise(int pos,
      {int category_id = 0}) async {
    final response =
        await get('/advertise/api/list/?pos=$pos&category_id=$category_id');
    print(response.body);
    print("object");
    return response.body;
  }

  Future<Response<AdvertisementList>> postAdvertise(
          Advertisement advertisement) async =>
      await post('advertisement', advertisement);

  Future<Response> deleteAdvertisement(int id) async =>
      await delete('advertisement/$id');
}
