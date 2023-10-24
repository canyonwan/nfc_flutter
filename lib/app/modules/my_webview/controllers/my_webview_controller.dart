import 'dart:async';
import 'dart:io';

import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MyWebviewController extends GetxController {
  final Completer<WebViewController> webviewController =
      Completer<WebViewController>();

  int type = 0; // 监控/直播
  String url = '';
  String first = '';
  String second = ''; // 监控token / 田地id

  @override
  void onInit() {
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
    type = Get.arguments['type']; //
    first = Get.arguments['first'] ?? ''; // 监控地址/直播地址
    second = Get.arguments['second'] ?? ''; // 监控地址/直播地址

    super.onInit();
  }

  @override
  void onReady() {
    setUrl();
    super.onReady();
  }

  // 0 监控  1 直播 2 其他
  void setUrl() {
    if (type == 0) {
      url =
          'https://www.nongfucang.com/jianK?url=${first}&accessToken=${second}';
    } else if (type == 1) {
      url = 'https://www.nongfucang.com/zhiB?url=${first}&ids=${second}';
    } else if (type == 2) {
      url = first;
    }
    update();
    print('url: $url');
  }

  @override
  void onClose() {
    super.onClose();
  }
}
