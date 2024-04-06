import 'dart:async';
import 'dart:ui';

import 'package:amap_location_fluttify/amap_location_fluttify.dart';
import 'package:city_pickers/city_pickers.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluwx/fluwx.dart';
import 'package:get/get.dart';
import 'package:lpinyin/lpinyin.dart';
import 'package:mallxx_app/app/models/response_model.dart';
import 'package:mallxx_app/app/modules/root/providers/field_provider.dart';
import 'package:mallxx_app/app/routes/app_pages.dart';
import 'package:mallxx_app/utils.dart';
import 'package:oktoast/oktoast.dart';
import 'package:permission_handler/permission_handler.dart';

import '/app/models/field_list_model.dart';
import '../../../models/city_data_model.dart';

///
class FieldController extends GetxController {
  final EasyRefreshController easyRefreshController = EasyRefreshController(
      controlFinishRefresh: true, controlFinishLoad: true);
  final FieldProvider fieldProvider = Get.find<FieldProvider>();

  // final _findController = Get.find<FindController>();

  final categoryList = RxList<FieldCategoryItemModel>(); // 分类集合
  final fieldList = RxList<FieldItemModel>(); // 田地列表
  final isLoading = true.obs;
  final initLoading = true.obs;

  TextEditingController codeController = TextEditingController();
  TextEditingController transferController = TextEditingController();

  late FieldListDataModel dataModel;
  int totalPage = 0;
  RxBool showAllLabels = true.obs; // 显示全部的标签容器 true为在后台 即不显示

  // 搜索入参
  FieldListSearchModel searchModel =
      FieldListSearchModel(page: 1, search: '', mergename: '');

  @override
  void onInit() {
    getCategory(changeMenu: true);
    getCityData();
    onLocation();
    super.onInit();
  }

  Future<void> getCategory(
      {bool changeMenu = false, bool removeListId = false}) async {
    print('123: ${searchModel.mergename}');
    isLoading.value = true;
    // if (removeListId) searchModel.listId = null;
    if (changeMenu) initLoading.value = true;
    FieldListRootModel res = await fieldProvider.getCategory(searchModel);
    if (res.code == 200 && res.data != null) {
      totalPage = res.data!.totalPage;
      dataModel = res.data!;
      if (changeMenu) {
        initLoading.value = false;
        categoryList.value = res.data!.areaList!;
        searchModel.listId = categoryList.first.id!;
        getCategory();
        if (dataModel.labelIds!.isNotEmpty) {
          searchModel.labelId = dataModel.labelIds!.first.id;
        }
      }
      categoryList.value = res.data!.areaList!;
      fieldList.value = res.data!.articleList!;
      update(['updateMenuId', 'updateFieldItem']);
      isLoading.value = false;
    }
  }

  // 确认转移
  Future<void> onConfirmTransfer() async {
    if (codeController.text.isEmpty) {
      showToast('请输入编码');
      return;
    }
    if (transferController.text.isEmpty) {
      showToast('请输入转移码');
      return;
    }
    EasyLoading.show(status: '转移中..');
    final res = await fieldProvider.submitFarmTransfer(
        codeController.text, transferController.text);
    if (res.code == 200) {
      getCategory(changeMenu: false);
      EasyLoading.dismiss();
      showToast('转移成功');
      Get.back();
      update(['updateFieldItem']);
    }
  }

  Future<void> onRefresh() async {
    if (fieldList.isNotEmpty) fieldList.clear();
    searchModel.page = 1;
    searchModel.labelId = null;
    await getCategory();
    easyRefreshController.finishRefresh();
  }

  Future<void> onLoadMore() async {
    if (totalPage == searchModel.page) {
      easyRefreshController.finishLoad(IndicatorResult.noMore);
      return;
    }
    searchModel.page++;
    await getCategory();
    easyRefreshController.finishLoad(searchModel.page == totalPage
        ? IndicatorResult.noMore
        : IndicatorResult.success);
  }

  Future<void> onSetMenu(FieldCategoryItemModel model) async {
    searchModel.listId = model.id;
    searchModel.labelId = null;
    await getCategory();
    // model.ifShow = 0;
    update(['updateMenuId']);
  }

  Location location = Location();

  Future<void> onLocation() async {
    if (await requestPermission()) {
      final location = await AmapLocation.instance.fetchLocation();
    }
    if (await AppUtils.requestLocationPermission() == true) {
      location = await AmapLocation.instance.fetchLocation();
      print('location: ${location}');
      searchModel.mergename =
          '${location.country ?? ''},${location.province ?? ''},${location.city ?? ''},${location.district}';
      update(['update_location']);
    } else {
      await AppUtils.requestLocationPermission();
      await onLocation();
    }
  }

  Future<bool> requestPermission() async {
    final permissions = await Permission.locationWhenInUse.request();
    if (permissions.isGranted) {
      return true;
    } else {
      showToast('需要定位权限!');
      return false;
    }
  }

  // 选择标签
  Future<void> onSelectLabel(int labelId) async {
    searchModel.labelId = labelId;
    await getCategory();
    update();
  }

  // 打开全部选择标签box
  void onShowAllLabels(bool value) {
    showAllLabels.value = !value;
  }

  // 收藏地
  Future<void> onCollectField(FieldItemModel item) async {
    ResponseData res;
    if (item.ifLike == 0) {
      res = await fieldProvider.collectField(item.id!);
      if (res.code == 200) item.ifLike = 1;
    } else {
      res = await fieldProvider.canCelCollectField(item.id!);
      if (res.code == 200) item.ifLike = 0;
    }
    showToast(res.msg);
    update(['updateFieldItem']);
  }

  Future<void> shareToSession() async {
    await shareToWeChat(WeChatShareWebPageModel(
      dataModel.enjoy!.enjoyUrl!,
      thumbnail: WeChatImage.network(dataModel.enjoy!.image!),
      title: dataModel.enjoy!.title!,
      description: dataModel.enjoy!.content,
    ));
  }

  Future<void> onToSearch() async {
    searchModel.listId = null;
    final res =
        await Get.toNamed(Routes.SEARCH_VIEW, arguments: searchModel.search);
    searchModel.search = res ?? '';
    update(['updateSearch']);
    await getCategory(changeMenu: true);
  }

  Map<String, dynamic>? citiesData = {};
  Map<String, String>? provincesData = {};

  Future<void> getCityData() async {
    final res = await fieldProvider.queryCityPickerData();
    if (res.code == 200 && res.data != null) {
      for (var i = 0; i < res.data!.length; i++) {
        if (res.data!.isNotEmpty) {
          provincesData![res.data![i].id.toString()] = res.data![i].name!;
          citiesData = _convertDataToMap(res.data!);
        }
      }
    }
  }

  String areaId = '';

  // FindController _findController = Get.find<FindController>();
  Future<void> onSelectAddress(bool changeField,
      {VoidCallback? changeCarts}) async {
    Result? result = await CityPickers.showCityPicker(
      context: Get.context!,
      locationCode: areaId == '' ? '3' : areaId,
      provincesData: provincesData,
      citiesData: citiesData,
    );
    print(': ${result}');
    if (result != null) {
      searchModel.mergename =
          '${'中国'},${result.provinceName},${result.cityName},${result.areaName}';
      areaId = result.areaId!;
      // _findController.getFindList();
      if (changeField) {
        getCategory(changeMenu: true);
      } else if (!changeField && changeCarts != null) {
        changeCarts();
      }

      print('searchMOdal: ${searchModel.mergename}');

      update(['update_location']);
    }
  }

  Map<String, dynamic> _convertDataToMap(List<CityItemModel> data) {
    Map<String, dynamic> result = {};
    data.forEach((element) {
      result[element.id.toString()] = <String, dynamic>{};
      element.childrenlist!.forEach((item) {
        String letter =
            PinyinHelper.getFirstWordPinyin(item.name!).substring(0, 1);
        result[element.id.toString()]
            [item.id.toString()] = {'name': item.name, 'alpha': letter};
        if (item.childrenlist != null && item.childrenlist!.isNotEmpty) {
          result[item.id.toString()] = <String, dynamic>{};
          item.childrenlist!.forEach((area) {
            String areaLetter =
                PinyinHelper.getFirstWordPinyin(area.name!).substring(0, 1);
            result[item.id.toString()]
                [area.id.toString()] = {'name': area.name, 'alpha': areaLetter};
          });
        }
      });
    });
    return result;
  }

//  查看田地详情
  Future<void> onFieldDetail(FieldItemModel item) async {
    Get.toNamed(Routes.FIELD_DETAIL,
        arguments: {"id": item.id, "mergename": searchModel.mergename});
    // getCategory(changeMenu: true);
    // item.ifShow = 0;
    update(['updateFieldItem']);
  }
}
