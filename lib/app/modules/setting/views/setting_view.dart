import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:mallxx_app/const/colors.dart';

import '../controllers/setting_controller.dart';

class SettingView extends GetView<SettingController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("setting".tr), centerTitle: true),
        body: Column(
          children: [
            ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              separatorBuilder: (context, index) {
                return Divider(height: 1, color: Colors.black12);
              },
              itemCount: controller.settingsTitle.length,
              itemBuilder: (context, index) {
                return Container(
                  color: KWhiteColor,
                  child: ListTile(
                    title: Text(
                      controller.settingsTitle[index]["name"],
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    onTap: () {
                      controller.onClick(index);
                    },
                    trailing: Icon(Icons.keyboard_arrow_right),
                  ),
                );
              },
            ),
            if (controller.loginProvider.isLogin())
              GFButton(
                onPressed: controller.onSignOut,
                text: '退出登录',
                color: kAppColor,
                blockButton: true,
                size: GFSize.LARGE,
              ),
          ],
        ));
  }
}
