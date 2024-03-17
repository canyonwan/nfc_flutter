import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mallxx_app/app/models/label_list_model.dart';
import 'package:mallxx_app/app/models/picture_article_detail_model.dart';
import 'package:mallxx_app/app/models/save_article_model.dart';
import 'package:mallxx_app/app/modules/root/providers/field_provider.dart';
import 'package:oktoast/oktoast.dart';

class ImageTextUploadController extends GetxController {
  List<File> fileTemps = [];
  final ImagePicker _picker = ImagePicker();
  final FieldProvider fieldProvider = Get.find<FieldProvider>();

  final SaveArticleRootModel params = SaveArticleRootModel(
    id: 0,
    articleId:
        Get.arguments['articleId'] != null ? Get.arguments['articleId'] : 0,
    title: '',
    shareExplain: '',
    content: '',
    images: '',
    vlabelIds: '',
    ifPrivate: 1,
  );
  late PictureArticleDataModel data;

  int maxUpload = 9;

  @override
  void onInit() {
    getLabelList();
    if (Get.arguments['id'] != null) {
      getImageTextDetail();
    }
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  // 图文详情
  Future<void> getImageTextDetail() async {
    var res = await fieldProvider.pictureArticleDetail(Get.arguments['id']);
    if (res.code == 200) {
      data = res.data;
      params.id = data.id;
      params.title = data.title;
      params.shareExplain = data.shareExplain;
      params.content = data.content;
      params.images = data.images.join(',');
      params.vlabelIds = data.vlabelIds.join(',');
      params.ifPrivate = data.ifPrivate;
      tagList = data.vlabelIds.map((e) => int.parse(e)).toList();
      imageList = data.images;
      print('images: ${params.images}');
      update();
    }
  }

  // radio change
  void onRadioChange(int index) {
    params.ifPrivate = index;
    update();
  }

  List<String> imageList = [];

  void onRemoveImage(int index) {
    imageList.removeAt(index);
    update();
  }

  List<LabelModel> labelList = [];
  List<int> tagList = [];

  // 获取标签列表
  Future<void> getLabelList() async {
    var res = await fieldProvider
        .queryLiveRecordLabelList(Get.arguments['articleId']);
    if (res.code == 200) {
      labelList = res.data;
    }
    update();
  }

  void onSelectTags(int id) {
    tagList.contains(id) ? tagList.remove(id) : tagList.add(id);
    update(['update_tag']);
  }

  // 上传图片
  Future<void> onUploadImage() async {
    if (fileTemps.isNotEmpty) {
      fileTemps.clear();
    }
    final List<XFile> results = await _picker.pickMultiImage();
    if (results.isNotEmpty) {
      for (var i = 0; i < results.length; i++) {
        var path = await results[i].path;
        File file = File(path);
        fileTemps.add(file);
      }
      EasyLoading.show(status: '上传中');
      var res = await fieldProvider.uploadImage(fileTemps);
      if (res.code == 200) {
        imageList.addAll(res.data);
        // params.images. =  res.data.join(',');
        // String images = res.data.join(',');
        // 将images添加到params.images后面
        // params.images.insert(params.images.length, images);
      } else {
        EasyLoading.dismiss();
        showToast(res.msg);
      }
      update();
    }
  }

  void onZoomImage(String img) {
    Get.defaultDialog(
      title: '查看大图',
      content: Image.network(img, fit: BoxFit.fill),
    );
  }

  Future<void> onSubmit() async {
    params.vlabelIds = tagList.join(',');
    params.images = imageList.join(',');
    var res = await fieldProvider.savePictureArticle(params);
    if (res.code == 200) {
      showToast(res.msg);
      Get.back();
    }
  }
}
