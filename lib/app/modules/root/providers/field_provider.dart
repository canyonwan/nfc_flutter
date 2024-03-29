import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mallxx_app/app/models/city_data_model.dart';
import 'package:mallxx_app/app/models/field_detail_button_status_model.dart';
import 'package:mallxx_app/app/models/field_detail_model.dart';
import 'package:mallxx_app/app/models/label_list_model.dart';
import 'package:mallxx_app/app/models/picture_article_detail_model.dart';
import 'package:mallxx_app/app/models/record_upload_img_model.dart';
import 'package:mallxx_app/app/models/record_upload_video_model.dart';
import 'package:mallxx_app/app/models/response_model.dart';
import 'package:mallxx_app/app/models/save_article_model.dart';
import 'package:mallxx_app/app/models/save_short_video_model.dart';
import 'package:mallxx_app/app/models/short_video_detail_model.dart';

import '/app/models/field_list_model.dart';
import '/app/providers/base_provider.dart';

class FieldProvider extends BaseProvider {
  //static const String categoryWithChildren = "/product/category/list/children";
  static const String categoryWithChildren = "/apizhibo/tiandi_list";
  static const String collectUrl = "/apizhibo/collect_articles";
  static const String cancelCollectUrl = "/apizhibo/cancel_collect_articles";
  static const String fieldDetailUrl = "/api/html_tiandi_detail";
  static const String editFieldDetailAndExplainUrl =
      "/apizhibo/member_change_enjoy"; //  修改田地分享和详情
  static const String complainUrl = "/apizhibo/member_complain";
  static const String claimFieldUrl = "/api/claim_detail";
  static const String cityPickerDataUrl = "apisj/get_area";
  static const String claimAgreementUrl = "/api/rlxy";
  static const String submitDecisionUrl = "/api/commit_decision"; // 提交决策
  static const String changeLiveNumUrl = "apipartner/change_live_num"; // 修改直播人数
  static const String decisionOrderPaymentUrl =
      "/api/wap_decision_payment"; // 决策订单支付
  static const String detailButtonStatusUrl = "apizhibo/if_live"; // 田地详情按钮状态
  static const String createFieldClaimOrderUrl =
      "api/create_claim_order"; // 生成田地认领订单

  static const String labelListUrl = "api/vlabel_list"; // 视频/图文标签列表
  static const String labelListUrl1 = "api/vlabel_lists"; // 视频/图文标签列表(农场详情用)
  static const String delRecordUrl = "api/delete_record"; // 删除实景记录

  static const String uploadImageUrl = "api/upload_picture"; // 用户上传图片
  static const String uploadVideoUrl = "api/upload_video"; // 用户上传视频
  static const String pictureArticleDetailUrl = "api/notice_detail"; // 图文详情
  static const String shortVideoDetailUrl = "api/video_detail"; // 视频详情
  static const String farmTransferUrl = "api/farm_transfer"; // 农场转移
  static const String savePictureArticleUrl =
      "api/member_alter_notice"; // 用户新建/编辑图文
  static const String saveShortVideoUrl =
      "api/member_alter_video"; // 用户新建/编辑短视频

  @override
  void onInit() {
    // httpClient.defaultDecoder = (map) {
    //   if (map is Map<String, dynamic>) return newcategory.fromJson(map);
    // };
    super.onInit();
  }

  Future<FieldListRootModel> getCategory(
      FieldListSearchModel searchModel) async {
    final response = await post(categoryWithChildren, searchModel.toJson());
    return FieldListRootModel.fromJson(response.body);
  }

  // 收藏田地
  Future<ResponseData> collectField(int fieldId) async {
    final response = await post(collectUrl, {"article_id": fieldId});
    return ResponseData.fromJson(response.body);
  }

  // 省市区三级列表
  Future<CityDataRootModel> queryCityPickerData() async {
    final response = await post(cityPickerDataUrl, {});
    return CityDataRootModel.fromJson(response.body);
  }

  // 取消收藏田地
  Future<ResponseData> canCelCollectField(int fieldId) async {
    final response = await post(cancelCollectUrl, {"article_id": fieldId});
    return ResponseData.fromJson(response.body);
  }

  // 田地详情
  Future<FieldDetailRootModel> queryFieldDetail(int fieldId,
      {String? mergename,
      int? page = 1,
      int? sort = 1,
      String? vlabel_ids}) async {
    final response = await post(fieldDetailUrl, {
      "article_id": fieldId,
      "mergename": mergename,
      "page": page,
      'sort': sort,
      'vlabel_ids': vlabel_ids
    });
    return FieldDetailRootModel.fromJson(response.body);
  }

  // 认领田地详情
  Future<ClaimFieldRootModel> queryClaimFieldDetail(int claimId,
      {int? num = 1}) async {
    final response =
        await post(claimFieldUrl, {"claim_id": claimId, "num": num});
    return ClaimFieldRootModel.fromJson(response.body);
  }

  // 我要投诉
  Future<ResponseData> complain(
      int fieldId, String? phone, String content) async {
    final response = await post(complainUrl,
        {"article_id": fieldId, "phone": phone, "content": content});
    return ResponseData.fromJson(response.body);
  }

  // 认领协议
  Future<ClaimAgreementRootModel> queryClaimAgreement() async {
    final response = await post(claimAgreementUrl, {});
    return ClaimAgreementRootModel.fromJson(response.body);
  }

  // 提交决策
  Future<SubmitDecisionRootModel> submitDecision(
      int decisionId, int optionId, String? content, String? imageUrl) async {
    final response = await post(submitDecisionUrl, {
      "decision_id": decisionId,
      'option_id': optionId,
      'content': content,
      'image_url': imageUrl
    });
    return SubmitDecisionRootModel.fromJson(response.body);
  }

  // 决策订单支付
  Future<ResponseData> decisionOrderPayment(OrderPaymentModel params) async {
    final response = await post(decisionOrderPaymentUrl, params);
    return ResponseData.fromJson(response.body);
  }

  // 田地详情按钮状态
  Future<FieldDetailButtonStatusRootModel> queryDetailButtonStatusUrl(
      int fieldId) async {
    final response = await post(detailButtonStatusUrl, {'article_id': fieldId});
    return FieldDetailButtonStatusRootModel.fromJson(response.body);
  }

  // 修改田地分享和详情
  Future<ResponseData> onEditFieldDetailAndExplain(int fieldId,
      {String? shareExplain, String? content}) async {
    final response = await post(editFieldDetailAndExplainUrl, {
      'article_id': fieldId,
      'share_explain': shareExplain,
      'content': content
    });
    return ResponseData.fromJson(response.body);
  }

  // 修改直播人数
  Future<ResponseData> changeLiveNum(int fieldId, int type) async {
    final response =
        await post(changeLiveNumUrl, {'article_id': fieldId, 'type': type});
    return ResponseData.fromJson(response.body);
  }

  // 生成田地认领订单
  Future<CreateFieldClaimRootModel> createFieldClaimOrder(
      int claim_id,
      int count,
      String name,
      String phone,
      String address_id,
      String address) async {
    final response = await post(createFieldClaimOrderUrl, {
      'claim_id': claim_id,
      'num': count,
      'name': name,
      'phone': phone,
      'address_id': address_id,
      'address': address
    });
    print('提交订单：${response.body}');
    return CreateFieldClaimRootModel.fromJson(response.body);
  }

  // 视频/图文标签列表
  Future<LabelListRootModel> queryLiveRecordLabelList(int articleId) async {
    final response = await post(labelListUrl, {'article_id': articleId});
    return LabelListRootModel.fromJson(response.body);
  }

  // 视频/图文标签列表
  Future<LabelListRootModel> queryLabelList(int articleId) async {
    final response = await post(labelListUrl1, {'article_id': articleId});
    return LabelListRootModel.fromJson(response.body);
  }

  Future<ResponseData> delRecord(
      {int? recordId, int? articleId, int? type}) async {
    final response = await post(delRecordUrl, {
      'id': recordId,
      'article_id': articleId,
      'type': type,
    });
    return ResponseData.fromJson(response.body);
  }

  // 用户上传图片
  Future<RecordUploadImageRootModel> uploadImage(List<File> files) async {
    final form = FormData(Map<String, dynamic>());
    for (int i = 0; i < files.length; i++) {
      form.files.add(MapEntry(
          'images[${i}]', MultipartFile(files[i], filename: 'image$i.jpg')));
    }
    final response = await post(uploadImageUrl, form);
    return RecordUploadImageRootModel.fromJson(response.body);
  }

  // 用户上传视频
  Future<RecordUploadVideoRootModel> uploadVideo(File video) async {
    final form = FormData({
      'file': MultipartFile(video, filename: 'video'),
    });
    final response = await post(uploadVideoUrl, form);
    debugPrint('response.body: ${response}');
    return RecordUploadVideoRootModel.fromJson(response.body);
  }

  // 图文详情
  Future<PictureArticleRootModel> pictureArticleDetail(int id) async {
    final response = await post(pictureArticleDetailUrl, {'id': id});
    return PictureArticleRootModel.fromJson(response.body);
  }

  // 视频详情
  Future<ShortVideoRootModel> queryShortVideoDetail(int videoId) async {
    final response = await post(shortVideoDetailUrl, {'id': videoId});
    return ShortVideoRootModel.fromJson(response.body);
  }

  // 用户新建/编辑图文
  Future<ResponseData> savePictureArticle(SaveArticleRootModel params) async {
    final response = await post(savePictureArticleUrl, params.toJson());
    return ResponseData.fromJson(response.body);
  }

  // 农场转移
  Future<ResponseData> submitFarmTransfer(
      String serialNumber, String transferCode) async {
    final response = await post(farmTransferUrl,
        {'serial_number': serialNumber, 'transfer': transferCode});
    return ResponseData.fromJson(response.body);
  }

  // 用户新建/编辑短视频
  Future<ResponseData> saveShortVideo(SaveShortVideoRootModel model) async {
    final response = await post(
      saveShortVideoUrl,
      model.toJson(),
    );
    return ResponseData.fromJson(response.body);
  }

  // 实景和决策标记为已读
  Future<ResponseData> markReadForVRAndDecision(int articleId, int part) async {
    final response = await post(
      "api/farm_mark",
      {
        "article_id": articleId,
        "part": part,
      },
    );
    return ResponseData.fromJson(response.body);
  }
}
