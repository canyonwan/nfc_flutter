import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:mallxx_app/const/colors.dart';

import '../controllers/change_member_avatar_controller.dart';

class ChangeMemberAvatarView extends GetView<ChangeMemberAvatarController> {
  const ChangeMemberAvatarView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('修改头像'), centerTitle: true),
      body: GetBuilder<ChangeMemberAvatarController>(builder: (c) {
        return Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GFAvatar(
                radius: 50.w,
                backgroundImage: NetworkImage(c.avatar),
              ),
              SizedBox(height: 20.w),
              GFButton(
                color: kAppColor,
                onPressed: c.onUploadImage,
                child: Text('修改头像', style: TextStyle()),
              ),
            ],
          ).paddingOnly(top: 50.w),
        );
      }),
    );
  }
}
