import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mallxx_app/app/models/field_detail_button_status_model.dart';
import 'package:mallxx_app/app/routes/app_pages.dart';
import 'package:mallxx_app/const/colors.dart';

import '../controllers/real_time_list_controller.dart';

class RealTimeListView extends GetView<RealTimeListController> {
  const RealTimeListView({Key? key}) : super(key: key);

  Widget _buildItem(MonitorModel model) {
    return GestureDetector(
      // type: 0: 监控  1: 直播
      onTap: () => Get.toNamed(Routes.MY_WEBVIEW, arguments: {
        'first': model.url,
        'second': controller.token,
        'type': 0
      }),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: KWhiteColor,
          borderRadius: BorderRadius.circular(7.5.w),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              clipBehavior: Clip.hardEdge,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(7.5.w)),
              child: Image(
                image: NetworkImage(model.image!),
                height: 200.0,
                width: double.infinity,
                fit: BoxFit.fill,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 6.w, horizontal: 10.w),
              child: Text(
                '${model.name}',
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(
                    color: kAppBlackColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('实时画面'), centerTitle: true),
      body: GetBuilder<RealTimeListController>(builder: (c) {
        return ListView.builder(
          itemCount: c.list.length,
          itemBuilder: (_, int idx) => _buildItem(c.list[idx]),
        );
      }),
    );
  }
}
