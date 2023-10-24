import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mallxx_app/const/colors.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../controllers/my_webview_controller.dart';

class MyWebviewView extends GetView<MyWebviewController> {
  const MyWebviewView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kAppBlackColor,
      body: GetBuilder<MyWebviewController>(builder: (c) {
        return c.url == ''
            ? BrnPageLoading()
            : WebView(
                initialUrl: c.url,
                javascriptMode: JavascriptMode.unrestricted,
                onWebViewCreated: (WebViewController webViewController) {
                  c.webviewController.complete(webViewController);
                },
              );
      }),
    );
  }
}
