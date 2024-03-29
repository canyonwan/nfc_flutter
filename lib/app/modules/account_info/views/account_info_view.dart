import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mallxx_app/app/modules/account_info/views/remove_account_view.dart';
import 'package:mallxx_app/app/routes/app_pages.dart';
import 'package:mallxx_app/const/colors.dart';

import '../controllers/account_info_controller.dart';

class AccountInfoView extends GetView<AccountInfoController> {
  const AccountInfoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KWhiteColor,
      appBar: AppBar(title: const Text('个人信息'), centerTitle: true),
      body: controller.obx(
        (m) => ListView(
          children: [
            _buildItem(
              label: m!.memberImg!,
              info: '更换头像',
              type: 1,
              onTap: () => controller.changeAvatar(m.memberImg!),
            ),
            _buildItem(
              label: '昵称',
              info: m.memberName,
              onTap: () => controller.changeMemberInfo(m.memberName!),
            ),
            _buildItem(
              label: '性别',
              info: m.sex == 1 ? '男' : '女',
              onTap: () => controller.changeGender(m.sex!),
            ),
            _buildItem(
              label: '我的手机号',
              info: m.phone,
              onTap: () => controller.changePhone(m.phone!),
            ),
            _buildItem(
              label: '帐号登录密码',
              hasDivider: false,
              info: '',
              onTap: controller.changePwd,
            ),
            _buildItem(
              label: '注销帐号',
              hasDivider: false,
              info: '',
              onTap: () {
                Get.to(() => RemoveAccountView());
                controller.getRemoveAccountInfo();
              },
            ),
            Container(height: 10.w, color: kBgGreyColor),
            _buildItem(
                label: '健康管家',
                info: m.restaurant,
                onTap: () =>
                    Get.toNamed(Routes.HEALTH_BUTLER, arguments: m.restaurant)),
            _buildItem(
              label: '我的收货地址',
              hasDivider: false,
              info: '',
              onTap: () => Get.toNamed(Routes.ADDRESS_BOOK),
            ),
          ],
        ),
        onLoading: BrnPageLoading(),
      ),
    );
  }

  Widget _buildItem(
      {required String label,
      String? info,
      VoidCallback? onTap,
      int? type = 0,
      bool? hasDivider = true}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: Get.width,
        padding: EdgeInsets.symmetric(vertical: 12.w, horizontal: 10.w),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (type == 1)
                  CircleAvatar(
                      backgroundImage: NetworkImage(label), radius: 30.w),
                if (type == 0) Text(label),
                Row(
                  children: [
                    Text('$info'),
                    Icon(Icons.keyboard_arrow_right_sharp, color: kBgGreyColor)
                  ],
                )
              ],
            ).paddingOnly(bottom: 4.w),
            if (hasDivider == true) Divider()
          ],
        ),
      ),
    );
  }
}
