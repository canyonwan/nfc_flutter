import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:mallxx_app/const/colors.dart';

class DetailHtmlView extends GetView {
  final String content;

  const DetailHtmlView(this.content, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KWhiteColor,
      body: content.isNotEmpty
          ? SingleChildScrollView(child: HtmlWidget(content))
          : Center(
              child: Text('暂无详情', style: TextStyle()),
            ),
    );
  }
}
