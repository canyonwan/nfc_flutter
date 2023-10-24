import 'dart:io';

import 'package:get/get.dart';
import 'package:mallxx_app/app/models/response_model.dart';
import 'package:mallxx_app/app/providers/base_provider.dart';

class CommonProvider extends BaseProvider {
  static const uploadImageUrl = 'api/upload_image';
  static const changeAvatarUrl = 'apitest/member_upload_img';

  // 上传图片
  Future<UploadImageRootModel> uploadImage(File image) async {
    final form = FormData({
      'image': MultipartFile(image, filename: 'image.png'),
    });
    final resp = await post(uploadImageUrl, form);
    return UploadImageRootModel.fromJson(resp.body);
  }

  // 用户修改头像
  Future<ChangeAvatarRootModel> changeAvatar(File image) async {
    final form = FormData({
      'image': MultipartFile(image, filename: 'image.png'),
    });
    final resp = await post(changeAvatarUrl, form);
    return ChangeAvatarRootModel.fromJson(resp.body);
  }
}
