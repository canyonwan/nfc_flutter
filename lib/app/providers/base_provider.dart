import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:mallxx_app/app/models/response_model.dart';
import 'package:mallxx_app/app/providers/login_provider.dart';
import 'package:mallxx_app/app/routes/app_pages.dart';
import 'package:oktoast/oktoast.dart';

//const String BASE_URL = "http://api.mallxx.com";
const String BASE_URL = "http://api.nongfucang.cn/home/";

class BaseProvider extends GetConnect {
  final LoginProvider loginProvider = Get.find<LoginProvider>();
  @override
  void onInit() {
    httpClient.baseUrl = BASE_URL;
    httpClient.timeout = Duration(seconds: 20);
    httpClient.addRequestModifier<dynamic>((request) {
      String language = "zh-CN";
      String? localLanguage;

      if (Get.locale != null) {
        localLanguage =
            Get.locale!.languageCode; //+ "-" + Get.locale!.countryCode!;
        if (Get.locale!.countryCode != null) {
          localLanguage += "-" + Get.locale!.countryCode!;
        }
      }

      if (localLanguage != null) {
        language = localLanguage;
      }

      request.headers["Accept-Language"] = language;
      request.headers["token"] = loginProvider.getToken() ?? "";
      print('header:  ${request.headers}');

      return request;
    });

    // 响应拦截
    httpClient.addResponseModifier((request, response) async {
      EasyLoading.dismiss();
      final res = ResponseData.fromJson(response.body as Map<String, dynamic>);
      // if (res.code == 202 || res.msg == 'token不能为空') {
      if ([202, 203].contains(res.code) || res.msg == 'token不能为空') {
        await Get.toNamed(Routes.LOGIN);
      } else if (res.code != 200) {
        showToast(res.msg);
      }
      return response;
    });

    super.onInit();
  }
}
