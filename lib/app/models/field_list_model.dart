import 'dart:convert';
import 'dart:developer';

void tryCatch(Function? f) {
  try {
    f?.call();
  } catch (e, stack) {
    log('$e');
    log('$stack');
  }
}

class FFConvert {
  FFConvert._();

  static T? Function<T extends Object?>(dynamic value) convert =
      <T>(dynamic value) {
    if (value == null) {
      return null;
    }
    return json.decode(value.toString()) as T?;
  };
}

T? asT<T extends Object?>(dynamic value, [T? defaultValue]) {
  if (value is T) {
    return value;
  }
  try {
    if (value != null) {
      final String valueS = value.toString();
      if ('' is T) {
        return valueS as T;
      } else if (0 is T) {
        return int.parse(valueS) as T;
      } else if (0.0 is T) {
        return double.parse(valueS) as T;
      } else if (false is T) {
        if (valueS == '0' || valueS == '1') {
          return (valueS == '1') as T;
        }
        return (valueS == 'true') as T;
      } else {
        return FFConvert.convert<T>(value);
      }
    }
  } catch (e, stackTrace) {
    log('asT<$T>', error: e, stackTrace: stackTrace);
    return defaultValue;
  }

  return defaultValue;
}

class FieldListRootModel {
  FieldListRootModel({
    this.msg,
    this.data,
    this.code,
  });

  factory FieldListRootModel.fromJson(Map<String, dynamic> jsonRes) =>
      FieldListRootModel(
        msg: asT<String?>(jsonRes['msg']),
        data: jsonRes['data'] == null
            ? null
            : FieldListDataModel.fromJson(
                asT<Map<String, dynamic>>(jsonRes['data'])!),
        code: asT<int?>(jsonRes['code']),
      );

  String? msg;
  FieldListDataModel? data;
  int? code;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'msg': msg,
        'data': data,
        'code': code,
      };
}

class FieldListDataModel {
  FieldListDataModel({
    required this.totalPage,
    required this.totalCount,
    required this.messageCount,
    this.labelIds,
    this.ifMessageShow,
    this.enjoy,
    this.articleList,
    this.areaList,
  });

  factory FieldListDataModel.fromJson(Map<String, dynamic> jsonRes) {
    final List<LabelItemModel>? labelIds =
        jsonRes['label_ids'] is List ? <LabelItemModel>[] : null;
    if (labelIds != null) {
      for (final dynamic item in jsonRes['label_ids']!) {
        if (item != null) {
          tryCatch(() {
            labelIds
                .add(LabelItemModel.fromJson(asT<Map<String, dynamic>>(item)!));
          });
        }
      }
    }

    final List<FieldItemModel>? articleList =
        jsonRes['article_list'] is List ? <FieldItemModel>[] : null;
    if (articleList != null) {
      for (final dynamic item in jsonRes['article_list']!) {
        if (item != null) {
          tryCatch(() {
            articleList
                .add(FieldItemModel.fromJson(asT<Map<String, dynamic>>(item)!));
          });
        }
      }
    }

    final List<FieldCategoryItemModel>? areaList =
        jsonRes['area_list'] is List ? <FieldCategoryItemModel>[] : null;
    if (areaList != null) {
      for (final dynamic item in jsonRes['area_list']!) {
        if (item != null) {
          tryCatch(() {
            areaList.add(FieldCategoryItemModel.fromJson(
                asT<Map<String, dynamic>>(item)!));
          });
        }
      }
    }
    return FieldListDataModel(
      totalPage: asT<int>(jsonRes['total_page'])!,
      totalCount: asT<int>(jsonRes['total_count'])!,
      messageCount: asT<int>(jsonRes['message_count'])!,
      labelIds: labelIds,
      ifMessageShow: asT<int?>(jsonRes['if_message_show']),
      enjoy: jsonRes['enjoy'] == null
          ? null
          : ShareItemModel.fromJson(
              asT<Map<String, dynamic>>(jsonRes['enjoy'])!),
      articleList: articleList,
      areaList: areaList,
    );
  }

  int totalPage;
  int totalCount;
  int messageCount;
  List<LabelItemModel>? labelIds;
  int? ifMessageShow;
  ShareItemModel? enjoy;
  List<FieldItemModel>? articleList;
  List<FieldCategoryItemModel>? areaList;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'total_page': totalPage,
        'total_count': totalCount,
        'message_count': messageCount,
        'label_ids': labelIds,
        'if_message_show': ifMessageShow,
        'enjoy': enjoy,
        'article_list': articleList,
        'area_list': areaList,
      };
}

class FieldCategoryItemModel {
  FieldCategoryItemModel({
    this.name,
    this.ifShow,
    this.ifIncrease,
    this.id,
    this.count,
  });

  factory FieldCategoryItemModel.fromJson(Map<String, dynamic> jsonRes) =>
      FieldCategoryItemModel(
        name: asT<String?>(jsonRes['name']),
        ifShow: asT<int?>(jsonRes['if_show']),
        ifIncrease: asT<int?>(jsonRes['if_increase']),
        id: asT<int?>(jsonRes['id']),
        count: asT<int?>(jsonRes['count']),
      );

  String? name;
  int? ifShow;
  int? ifIncrease;
  int? id;
  int? count;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'name': name,
        'if_show': ifShow,
        'if_increase': ifIncrease,
        'id': id,
        'count': count,
      };
}

class FieldItemModel {
  FieldItemModel({
    this.weigh,
    this.vrImages,
    this.videoImage,
    this.videoFile,
    this.vidPicCount,
    this.title,
    this.status,
    this.shareTitle,
    this.shareImage,
    this.shareExplain,
    this.serialNumber,
    this.sale,
    this.qrUrl,
    this.qrImage,
    this.provinceId,
    this.playAddress,
    this.password,
    this.partnerRead,
    this.partnerNickname,
    this.partnerName,
    this.partnerImage,
    this.originPlaceIds,
    this.newLink,
    this.monthIds,
    this.monitorNumber,
    this.monitorIds,
    this.monitorChannels,
    this.memberIds,
    this.memberEvaluation,
    this.memberBrowse,
    this.liveNum,
    this.liveAddress2,
    this.liveAddress,
    this.link,
    this.labelIds,
    this.image,
    this.ifShow,
    this.ifRecommend,
    this.ifLive,
    this.ifLike,
    this.id,
    this.goodsIds,
    this.expertRemark,
    this.enjoyUrl,
    this.describe,
    this.createtime,
    this.count,
    this.content,
    this.cityId,
    this.basicsYear,
    this.basicsGrade,
    this.basicsEnshrine,
    this.basicsBrowse,
    this.articlesId,
    this.areaIds,
    this.areaId,
    this.address,
  });

  factory FieldItemModel.fromJson(Map<String, dynamic> jsonRes) =>
      FieldItemModel(
        weigh: asT<int?>(jsonRes['weigh']),
        vrImages: asT<Object?>(jsonRes['vr_images']),
        videoImage: asT<String?>(jsonRes['video_image']),
        videoFile: asT<String?>(jsonRes['video_file']),
        vidPicCount: asT<int?>(jsonRes['vid_pic_count']),
        title: asT<String?>(jsonRes['title']),
        status: asT<int?>(jsonRes['status']),
        shareTitle: asT<String?>(jsonRes['share_title']),
        shareImage: asT<String?>(jsonRes['share_image']),
        shareExplain: asT<String?>(jsonRes['share_explain']),
        serialNumber: asT<String?>(jsonRes['serial_number']),
        sale: asT<Object?>(jsonRes['sale']),
        qrUrl: asT<String?>(jsonRes['qr_url']),
        qrImage: asT<String?>(jsonRes['qr_image']),
        provinceId: asT<int?>(jsonRes['province_id']),
        playAddress: asT<Object?>(jsonRes['play_address']),
        password: asT<Object?>(jsonRes['password']),
        partnerRead: asT<int?>(jsonRes['partner_read']),
        partnerNickname: asT<Object?>(jsonRes['partner_nickname']),
        partnerName: asT<Object?>(jsonRes['partner_name']),
        partnerImage: asT<Object?>(jsonRes['partner_image']),
        originPlaceIds: asT<String?>(jsonRes['origin_place_ids']),
        newLink: asT<String?>(jsonRes['new_link']),
        monthIds: asT<String?>(jsonRes['month_ids']),
        monitorNumber: asT<Object?>(jsonRes['monitor_number']),
        monitorIds: asT<String?>(jsonRes['monitor_ids']),
        monitorChannels: asT<Object?>(jsonRes['monitor_channels']),
        memberIds: asT<String?>(jsonRes['member_ids']),
        memberEvaluation: asT<String?>(jsonRes['member_evaluation']),
        memberBrowse: asT<int?>(jsonRes['member_browse']),
        liveNum: asT<int?>(jsonRes['live_num']),
        liveAddress2: asT<String?>(jsonRes['live_address2']),
        liveAddress: asT<String?>(jsonRes['live_address']),
        link: asT<String?>(jsonRes['link']),
        labelIds: asT<String?>(jsonRes['label_ids']),
        image: asT<String?>(jsonRes['image']),
        ifShow: asT<int?>(jsonRes['if_show']),
        ifRecommend: asT<int?>(jsonRes['if_recommend']),
        ifLive: asT<int?>(jsonRes['if_live']),
        ifLike: asT<int?>(jsonRes['if_like']),
        id: asT<int?>(jsonRes['id']),
        goodsIds: asT<String?>(jsonRes['goods_ids']),
        expertRemark: asT<String?>(jsonRes['expert_remark']),
        enjoyUrl: asT<String?>(jsonRes['enjoy_url']),
        describe: asT<String?>(jsonRes['describe']),
        createtime: asT<int?>(jsonRes['createtime']),
        count: asT<int?>(jsonRes['count']),
        content: asT<String?>(jsonRes['content']),
        cityId: asT<int?>(jsonRes['city_id']),
        basicsYear: asT<int?>(jsonRes['basics_year']),
        basicsGrade: asT<String?>(jsonRes['basics_grade']),
        basicsEnshrine: asT<String?>(jsonRes['basics_enshrine']),
        basicsBrowse: asT<String?>(jsonRes['basics_browse']),
        articlesId: asT<int?>(jsonRes['articles_id']),
        areaIds: asT<String?>(jsonRes['area_ids']),
        areaId: asT<int?>(jsonRes['area_id']),
        address: asT<String?>(jsonRes['address']),
      );

  int? weigh;
  Object? vrImages;
  String? videoImage;
  String? videoFile;
  int? vidPicCount;
  String? title;
  int? status;
  String? shareTitle;
  String? shareImage;
  String? shareExplain;
  String? serialNumber;
  Object? sale;
  String? qrUrl;
  String? qrImage;
  int? provinceId;
  Object? playAddress;
  Object? password;
  int? partnerRead;
  Object? partnerNickname;
  Object? partnerName;
  Object? partnerImage;
  String? originPlaceIds;
  String? newLink;
  String? monthIds;
  Object? monitorNumber;
  String? monitorIds;
  Object? monitorChannels;
  String? memberIds;
  String? memberEvaluation;
  int? memberBrowse;
  int? liveNum;
  String? liveAddress2;
  String? liveAddress;
  String? link;
  String? labelIds;
  String? image;
  int? ifShow;
  int? ifRecommend;
  int? ifLive;
  int? ifLike;
  int? id;
  String? goodsIds;
  String? expertRemark;
  String? enjoyUrl;
  String? describe;
  int? createtime;
  int? count;
  String? content;
  int? cityId;
  int? basicsYear;
  String? basicsGrade;
  String? basicsEnshrine;
  String? basicsBrowse;
  int? articlesId;
  String? areaIds;
  int? areaId;
  String? address;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'weigh': weigh,
        'vr_images': vrImages,
        'video_image': videoImage,
        'video_file': videoFile,
        'vid_pic_count': vidPicCount,
        'title': title,
        'status': status,
        'share_title': shareTitle,
        'share_image': shareImage,
        'share_explain': shareExplain,
        'serial_number': serialNumber,
        'sale': sale,
        'qr_url': qrUrl,
        'qr_image': qrImage,
        'province_id': provinceId,
        'play_address': playAddress,
        'password': password,
        'partner_read': partnerRead,
        'partner_nickname': partnerNickname,
        'partner_name': partnerName,
        'partner_image': partnerImage,
        'origin_place_ids': originPlaceIds,
        'new_link': newLink,
        'month_ids': monthIds,
        'monitor_number': monitorNumber,
        'monitor_ids': monitorIds,
        'monitor_channels': monitorChannels,
        'member_ids': memberIds,
        'member_evaluation': memberEvaluation,
        'member_browse': memberBrowse,
        'live_num': liveNum,
        'live_address2': liveAddress2,
        'live_address': liveAddress,
        'link': link,
        'label_ids': labelIds,
        'image': image,
        'if_show': ifShow,
        'if_recommend': ifRecommend,
        'if_live': ifLive,
        'if_like': ifLike,
        'id': id,
        'goods_ids': goodsIds,
        'expert_remark': expertRemark,
        'enjoy_url': enjoyUrl,
        'describe': describe,
        'createtime': createtime,
        'count': count,
        'content': content,
        'city_id': cityId,
        'basics_year': basicsYear,
        'basics_grade': basicsGrade,
        'basics_enshrine': basicsEnshrine,
        'basics_browse': basicsBrowse,
        'articles_id': articlesId,
        'area_ids': areaIds,
        'area_id': areaId,
        'address': address,
      };
}

class LabelItemModel {
  LabelItemModel({
    this.name,
    this.id,
  });

  factory LabelItemModel.fromJson(Map<String, dynamic> jsonRes) =>
      LabelItemModel(
        name: asT<String?>(jsonRes['name']),
        id: asT<int?>(jsonRes['id']),
      );

  String? name;
  int? id;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'name': name,
        'id': id,
      };
}

class ShareItemModel {
  ShareItemModel({
    this.title,
    this.image,
    this.id,
    this.enjoyUrl,
    this.content,
  });

  factory ShareItemModel.fromJson(Map<String, dynamic> jsonRes) =>
      ShareItemModel(
        title: asT<String?>(jsonRes['title']),
        image: asT<String?>(jsonRes['image']),
        id: asT<int?>(jsonRes['id']),
        enjoyUrl: asT<String?>(jsonRes['enjoy_url']),
        content: asT<String?>(jsonRes['content']),
      );

  String? title;
  String? image;
  int? id;
  String? enjoyUrl;
  String? content;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'title': title,
        'image': image,
        'id': id,
        'enjoy_url': enjoyUrl,
        'content': content,
      };
}

class FieldListSearchModel {
  FieldListSearchModel({
    this.search,
    required this.page,
    this.mergename,
    this.listId,
    this.labelId,
  });

  factory FieldListSearchModel.fromJson(Map<String, dynamic> jsonRes) =>
      FieldListSearchModel(
        search: asT<String?>(jsonRes['search']),
        page: asT<int>(jsonRes['page'])!,
        mergename: asT<String?>(jsonRes['mergename']),
        listId: asT<int?>(jsonRes['list_id']),
        labelId: asT<int?>(jsonRes['label_id']),
      );

  String? search;
  int page;
  String? mergename;
  int? listId;
  int? labelId;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'search': search,
        'page': page,
        'mergename': mergename,
        'list_id': listId,
        'label_id': labelId,
      };
}
