import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mallxx_app/app/routes/app_pages.dart';

class VrUploadView extends GetView {
  const VrUploadView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('实景上传')),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 20.w),
        child: Row(
          children: [
            Expanded(
              child: Container(
                margin: EdgeInsets.only(right: 10.w),
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6.w),
                ),
                child: GestureDetector(
                    onTap: () {
                      Get.toNamed(Routes.VIDEO_UPLOAD, arguments: {
                        'articleId': Get.arguments['articleId'],
                      });
                    },
                    child: Image.asset('assets/images/short_video_icon.png',
                        width: 50.w, height: 50.w)),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6.w),
                ),
                child: GestureDetector(
                    onTap: () {
                      // Get.to(() => VrUploadView(),
                      //     arguments: {'articleId': c.fieldId});
                      Get.toNamed(Routes.IMAGE_TEXT_UPLOAD, arguments: {
                        'articleId': Get.arguments['articleId'],
                      });
                    },
                    child: Image.asset('assets/images/photo_article_icon.png',
                        width: 50.w, height: 50.w)),
              ),
            ),
          ],
        ).paddingSymmetric(horizontal: 10.w),
      ),
    );
  }
}
