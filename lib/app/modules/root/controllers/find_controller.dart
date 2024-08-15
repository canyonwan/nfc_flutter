import 'dart:async';

import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluwx/fluwx.dart';
import 'package:get/get.dart';
import 'package:oktoast/oktoast.dart';

import '../../../models/find_model_entity.dart';
import '../../../routes/app_pages.dart';
import '../providers/find_provider.dart';
import 'field_controller.dart';

class FindController extends GetxController with StateMixin<FindDataModel> {
// class FindController extends GetxController {
  final FindProvider findProvider = Get.find<FindProvider>();
  final FieldController _fieldController = Get.find<FieldController>();
  final EasyRefreshController liveActionEasyRefreshController =
      EasyRefreshController(
    controlFinishRefresh: true,
    controlFinishLoad: true,
  );
  ScrollController scrollController = ScrollController();

  List<BannerItemModel> bannerList = []; // 发现页banner列表
  List<ADItemModel> ADList = []; // 发现页广告列表
  List<FindItemModel> findList = []; // 发现页底部列表
  FindDataModel findData =
      FindDataModel(advertisement: [], ifMessageShow: 0, totalPage: 0);
  int totalPage = 1;
  int page = 1;
  int playingIndex = -1;

  //
  final EasyRefreshController findRefreshController = EasyRefreshController(
    controlFinishRefresh: true,
    controlFinishLoad: true,
  );

  @override
  void onInit() {
    super.onInit();
    getFindList(loadFindList: true);
  }

  void onVideoClick(int index) {
    playingIndex = index;
    update();
  }

  Future<void> onRefresh() async {
    page = 1;
    if (findList.isNotEmpty) {
      findList.clear();
    }
    await getFindList(loadFindList: true);
    findRefreshController.finishRefresh();
  }

  Future<void> onSelectAddress() async {
    await _fieldController.onSelectAddress(false);
    await findRefreshController.callRefresh();
  }

  Future<void> onCollect(FindItemModel item) async {
    var res = await findProvider.findCollect(
      id: item.id!,
      status: item.ifCollect == 0 ? 1 : 0,
      type: item.type!,
    );
    if (res.code == 200) {
      showToast(res.msg);
      if (item.ifCollect == 0) {
        item.collectNum = item.collectNum! + 1;
      } else {
        item.collectNum = item.collectNum! - 1;
      }
      item.ifCollect = item.ifCollect == 0 ? 1 : 0;
    } else {
      showToast(res.msg);
    }
    update(['collect']);
  }

  Future<void> getFindList({bool loadFindList = false}) async {
    var res = await findProvider.queryFindList(
        page: page, mergename: _fieldController.searchModel.mergename);
    change(null, status: RxStatus.loading());
    if (res.code == '200') {
      findData = res.data!;
      totalPage = res.data!.totalPage;
      if (!loadFindList) {
        bannerList = res.data!.advertisement;
        ADList = res.data!.picture!;
        if (findList.isNotEmpty) {
          findList.clear();
        }
        findList.addAll(findData.list!);
        change(res.data, status: RxStatus.success());
      }
      if (loadFindList) {
        if (findData.list!.isEmpty) {
          findList = [];
          change(null, status: RxStatus.empty());
        } else {
          findList.addAll(findData.list!);
          change(res.data, status: RxStatus.success());
        }
      }
    } else {
      change(null, status: RxStatus.error('${res.msg}, 点击刷新'));
    }
  }

  Future<void> onLoadMore() async {
    if (totalPage == page) {
      findRefreshController.finishLoad(IndicatorResult.noMore);
      return;
    }
    page++;
    await getFindList(loadFindList: true);
    findRefreshController.finishLoad(
        page == totalPage ? IndicatorResult.noMore : IndicatorResult.success);
  }

  void onTapItem(BannerItemModel m) {
    Get.toNamed(Routes.MY_ACTIVITY_FORECAST,
        arguments: {'adId': m.id, 'type': 1});
  }

  void onSelectItem(ADItemModel m) {
    Get.toNamed(Routes.MY_ACTIVITY_FORECAST,
        arguments: {'adId': m.id, 'type': 0});
  }

  Future<void> shareToSession(ShareItemModel model) async {
    await shareToWeChat(WeChatShareWebPageModel(
      model.enjoyUrl!,
      thumbnail: WeChatImage.network(model.image!),
      title: model.title!,
      description: model.content,
    ));
  }
}
