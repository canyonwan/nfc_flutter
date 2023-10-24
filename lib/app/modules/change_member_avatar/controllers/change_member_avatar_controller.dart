import 'dart:io';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mallxx_app/app/api/common_api.dart';

class ChangeMemberAvatarController extends GetxController {
  int current = 1;

  List<WayModel> ways = [WayModel(1, '男'), WayModel(2, '女')];

  final CommonProvider commonProvider =
      Get.put<CommonProvider>(CommonProvider());

  String avatar = '';

  @override
  void onInit() {
    avatar = Get.arguments;
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  final ImagePicker _picker = ImagePicker();

  // 上传图片
  Future<void> onUploadImage() async {
    final XFile? result = await _picker.pickImage(
      source: ImageSource.gallery,
    );
    if (result != null) {
      var fileTemp = await result.path;
      File file = File(fileTemp);
      EasyLoading.show();
      final res = await commonProvider.changeAvatar(file);
      if (res.code == 200 && res.data != null) {
        avatar = res.data!.imgpath!;
        update();
        EasyLoading.dismiss();
      }
    }
  }

  void onSelectWay(int way) {
    current = way;
    update();
  }
}

class WayModel {
  final int type;
  final String name;

  WayModel(this.type, this.name);
}
