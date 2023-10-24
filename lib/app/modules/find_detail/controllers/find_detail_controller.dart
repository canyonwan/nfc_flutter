import 'package:better_video_player/better_video_player.dart';
import 'package:flutter/material.dart';
import 'package:fluwx/fluwx.dart';
import 'package:get/get.dart';
import 'package:mallxx_app/app/models/find_dynamic_detail_model.dart';
import 'package:mallxx_app/app/models/find_videodetail_model.dart';
import 'package:mallxx_app/app/modules/root/providers/cart_provider.dart';
import 'package:mallxx_app/app/modules/root/providers/find_provider.dart';
import 'package:mallxx_app/app/routes/app_pages.dart';

import '../../../models/find_model_entity.dart';

class FindDetailController extends GetxController {
  int adId = 0;
  int type = 1;
  // final MemberProvider _memberProvider = Get.find<MemberProvider>();
  final FindProvider _findProvider = Get.find<FindProvider>();
  final CartProvider cartProvider = Get.find<CartProvider>();

  late final BetterVideoPlayerController videoController;
  FindVideoDetailDataModel? videoDetailData;
  FindDynamicDetailDataModel? dynamicDetailData;

  @override
  void onInit() {
    adId = Get.arguments['adId'];
    type = Get.arguments['type'];
    // 1: 短视频 2: 公告动态 3: 吃货模式
    if (type == 1) {
      getFindShortVideoDetail();
    } else if (type == 2) {
      getFindDynamicDetail();
    }
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    videoController = BetterVideoPlayerController();
  }

  @override
  void onClose() {
    super.onClose();
    videoController.dispose();
  }

  Future<void> getFindShortVideoDetail() async {
    final res = await _findProvider.queryFindShortVideoDetail(adId);
    if (res.code == 200) {
      videoDetailData = res.data;
    } else {}
    update();
  }

  Future<void> getFindDynamicDetail() async {
    final res = await _findProvider.queryFindDynamicDetailUrl(adId);
    if (res.code == 200) {
      dynamicDetailData = res.data!;
      update();
    } else {}
  }

  Future<void> onShare(ShareItemModel share) async {
    await shareToWeChat(WeChatShareWebPageModel(
      share.enjoyUrl!,
      thumbnail: WeChatImage.network(share.image!),
      title: share.title!,
      description: share.content,
    ));
  }

  void onZoomImage(String img) {
    Get.defaultDialog(
      title: '查看大图',
      content: Image.network(img, fit: BoxFit.fill),
    );
  }

  void onJumpToFieldDetail(int id) {
    Get.toNamed(Routes.FIELD_DETAIL, arguments: {'id': id});
  }

  void onToDetail(int goodsId) {
    Get.toNamed(Routes.GOODS_DETAIL, arguments: goodsId);
  }
}
