import 'dart:io';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mallxx_app/app/models/label_list_model.dart';
import 'package:mallxx_app/app/models/save_short_video_model.dart';
import 'package:mallxx_app/app/models/short_video_detail_model.dart';
import 'package:mallxx_app/app/modules/root/providers/field_provider.dart';
import 'package:mallxx_app/app/modules/video_upload/views/video_editor_view.dart';
import 'package:oktoast/oktoast.dart';
import 'package:video_compress/video_compress.dart';

class VideoUploadController extends GetxController {
  File? fileTemp;
  final ImagePicker _picker = ImagePicker();
  final FieldProvider fieldProvider = Get.find<FieldProvider>();

  final SaveShortVideoRootModel params = SaveShortVideoRootModel(
    id: 0,
    articleId:
        Get.arguments['articleId'] != null ? Get.arguments['articleId'] : 0,
    // articleId: 0,
    title: '',
    vlabelIds: '',
    ifPrivate: 1,
    videoImage: '', // 视频封面图链接
    videoFile: '', // 视频链接
    weigh: '',
  );
  List<int> tagList = [];
  late ShortVideoDataModel data;

  @override
  void onInit() {
    getLabelList();
    super.onInit();
  }

  @override
  void onReady() {
    if (Get.arguments['id'] != null) {
      getShortVideoDetail();
    }
    super.onReady();
  }

  List<LabelModel> labelList = [];

  // radio change
  void onRadioChange(int index) {
    params.ifPrivate = index;
    update();
  }

  // 视频详情
  Future<void> getShortVideoDetail() async {
    var res = await fieldProvider.queryShortVideoDetail(Get.arguments['id']);
    if (res.code == 200) {
      data = res.data;
      params.id = data.id;
      params.title = data.title;
      params.videoImage = data.videoImage;
      params.videoFile = data.videoFile;
      params.vlabelIds = data.vlabelIds.join(',');
      tagList = data.vlabelIds.map((e) => int.parse(e)).toList();
      params.weigh = data.weigh.toString();
      params.ifPrivate = data.ifPrivate;
      update();
    }
  }

  // 获取标签列表
  Future<void> getLabelList() async {
    var res = await fieldProvider.queryLiveRecordLabelList();
    if (res.code == 200) {
      labelList = res.data;
    }
    update();
  }

  void onSelectTags(int id) {
    tagList.contains(id) ? tagList.remove(id) : tagList.add(id);
    update(['update_tag']);
  }

  // 上传视频
  Future<void> onUploadVideo() async {
    final XFile? result = await _picker.pickVideo(source: ImageSource.gallery);
    if (result == null) {
      return;
    }
    File file = File(result.path);
    // 获取XFile文件的大小和时长
    final fileBytes = await file.readAsBytes();
    final fileSize = fileBytes.lengthInBytes;
    var fileMbSize = fileSize / (1024 * 1024);
    if (fileMbSize > 100) {
      showToast('视频大小不能超过100M');
      return;
    }

    EasyLoading.show(status: '压缩中');
    fileTemp = await _compressVideo(result.path);
    EasyLoading.dismiss();
    // fileTemp = File(result!.path);

    // fileTemp = file;
    if (fileTemp != null) {
      // 去视频编辑
      var res = await Get.to(() => VideoEditorView(file: fileTemp!));
      print('res: $res');
      params.videoImage = res.imageUrl;
      params.videoFile = res.fileUrl;
      print('结果结果params: $params');
      // EasyLoading.show(status: '上传中');
      // var res = await fieldProvider.uploadVideo(fileTemp!);
      // if (res.code == 200) {
      //   params.videoImage = res.data.imageUrl;
      //   params.videoFile = res.data.fileUrl;
      // }
    }
    update();
  }

  // 压缩视频
  Future<File> _compressVideo(String path) async {
    final MediaInfo? info = await VideoCompress.compressVideo(
      path,
      quality: VideoQuality.HighestQuality,
      deleteOrigin: false,
      includeAudio: true,
    );
    return File(info!.path!);
  }

  // 上传封面
  Future<void> onUploadCover() async {
    final XFile? result = await _picker.pickImage(source: ImageSource.gallery);
    if (result != null) {
      var fileTemps = await result.path;
      File file = File(fileTemps);
      fileTemp = file;
      EasyLoading.show(status: '上传中');
      var res = await fieldProvider.uploadImage([fileTemp!]);
      if (res.code == 200) {
        params.videoImage = res.data.first;
        EasyLoading.dismiss();
      }
      update();
    }
  }

  Future<void> onSubmit() async {
    params.vlabelIds = tagList.join(',');
    var res = await fieldProvider.saveShortVideo(params);
    if (res.code == 200) {
      showToast(res.msg);
      Get.back();
    }
  }
}
