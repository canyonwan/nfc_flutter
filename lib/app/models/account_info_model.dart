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

class AccountInfoRootModel {
  AccountInfoRootModel({
    required this.code,
    this.data,
    required this.msg,
  });

  factory AccountInfoRootModel.fromJson(Map<String, dynamic> json) =>
      AccountInfoRootModel(
        code: asT<int>(json['code'])!,
        data: json['data'] == null
            ? null
            : AccountInfoDataModel.fromJson(
                asT<Map<String, dynamic>>(json['data'])!),
        msg: asT<String>(json['msg'])!,
      );

  int code;
  AccountInfoDataModel? data;
  String msg;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'code': code,
        'data': data,
        'msg': msg,
      };
}

class AccountInfoDataModel {
  AccountInfoDataModel({
    this.about,
    this.advertisement,
    this.browseCount,
    this.endTime,
    this.goodsLike,
    this.goodsNotLike,
    this.guessLike,
    this.ifLogistics,
    this.ifMessageShow,
    this.ifPayPass,
    this.isVip,
    this.logisticsInfo,
    this.memberAlreadycollectCount,
    this.memberEvaluateCount,
    this.memberImg,
    this.memberName,
    this.memberRefundCount,
    this.memberStaycollectCount,
    this.memberStaypayCount,
    this.messageCount,
    this.phone,
    this.picture,
    this.restaurant,
    this.save,
    this.savePrice,
    this.sex,
    this.startTime,
  });

  factory AccountInfoDataModel.fromJson(Map<String, dynamic> json) {
    final List<SwiperItemModel>? advertisement =
        json['advertisement'] is List ? <SwiperItemModel>[] : null;
    if (advertisement != null) {
      for (final dynamic item in json['advertisement']!) {
        if (item != null) {
          tryCatch(() {
            advertisement.add(
                SwiperItemModel.fromJson(asT<Map<String, dynamic>>(item)!));
          });
        }
      }
    }

    final List<AdItemModel>? picture =
        json['picture'] is List ? <AdItemModel>[] : null;
    if (picture != null) {
      for (final dynamic item in json['picture']!) {
        if (item != null) {
          tryCatch(() {
            picture.add(AdItemModel.fromJson(asT<Map<String, dynamic>>(item)!));
          });
        }
      }
    }
    return AccountInfoDataModel(
      about: asT<String?>(json['about']),
      advertisement: advertisement,
      browseCount: asT<int?>(json['browse_count']),
      endTime: asT<String?>(json['end_time']),
      goodsLike: asT<int?>(json['goods_like']),
      goodsNotLike: asT<int?>(json['goods_not_like']),
      guessLike: asT<int?>(json['guess_like']),
      ifLogistics: asT<int?>(json['if_logistics']),
      ifMessageShow: asT<int?>(json['if_message_show']),
      ifPayPass: asT<int?>(json['if_pay_pass']),
      isVip: asT<int?>(json['is_vip']),
      logisticsInfo: json['logistics_info'] == null
          ? null
          : LogisticsInfoModel.fromJson(
              asT<Map<String, dynamic>>(json['logistics_info'])!),
      memberAlreadycollectCount: asT<int?>(json['member_alreadycollect_count']),
      memberEvaluateCount: asT<int?>(json['member_evaluate_count']),
      memberImg: asT<String?>(json['member_img']),
      memberName: asT<String?>(json['member_name']),
      memberRefundCount: asT<int?>(json['member_refund_count']),
      memberStaycollectCount: asT<int?>(json['member_staycollect_count']),
      memberStaypayCount: asT<int?>(json['member_staypay_count']),
      messageCount: asT<int?>(json['message_count']),
      phone: asT<String?>(json['phone']),
      picture: picture,
      restaurant: asT<String?>(json['restaurant']),
      save: asT<String?>(json['save']),
      savePrice: asT<double?>(json['save_price']),
      sex: asT<int?>(json['sex']),
      startTime: asT<String?>(json['start_time']),
    );
  }

  String? about;
  List<SwiperItemModel>? advertisement;
  int? browseCount;
  String? endTime;
  int? goodsLike;
  int? goodsNotLike;
  int? guessLike;
  int? ifLogistics;
  int? ifMessageShow;
  int? ifPayPass;
  int? isVip;
  LogisticsInfoModel? logisticsInfo;
  int? memberAlreadycollectCount;
  int? memberEvaluateCount;
  String? memberImg;
  String? memberName;
  int? memberRefundCount;
  int? memberStaycollectCount;
  int? memberStaypayCount;
  int? messageCount;
  String? phone;
  List<AdItemModel>? picture;
  String? restaurant;
  String? save;
  double? savePrice;
  int? sex;
  String? startTime;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'about': about,
        'advertisement': advertisement,
        'browse_count': browseCount,
        'end_time': endTime,
        'goods_like': goodsLike,
        'goods_not_like': goodsNotLike,
        'guess_like': guessLike,
        'if_logistics': ifLogistics,
        'if_message_show': ifMessageShow,
        'if_pay_pass': ifPayPass,
        'is_vip': isVip,
        'logistics_info': logisticsInfo,
        'member_alreadycollect_count': memberAlreadycollectCount,
        'member_evaluate_count': memberEvaluateCount,
        'member_img': memberImg,
        'member_name': memberName,
        'member_refund_count': memberRefundCount,
        'member_staycollect_count': memberStaycollectCount,
        'member_staypay_count': memberStaypayCount,
        'message_count': messageCount,
        'phone': phone,
        'picture': picture,
        'restaurant': restaurant,
        'save': save,
        'save_price': savePrice,
        'sex': sex,
        'start_time': startTime,
      };
}

class LogisticsInfoModel {
  LogisticsInfoModel({
    this.content,
    this.picture,
    this.time,
    this.title,
  });

  factory LogisticsInfoModel.fromJson(Map<String, dynamic> json) =>
      LogisticsInfoModel(
        content: asT<String?>(json['content']),
        picture: asT<String?>(json['picture']),
        time: asT<String?>(json['time']),
        title: asT<String?>(json['title']),
      );

  String? content;
  String? picture;
  String? time;
  String? title;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'content': content,
        'picture': picture,
        'time': time,
        'title': title,
      };
}

class AdItemModel {
  AdItemModel({
    this.areaIds,
    this.id,
    this.image,
  });

  factory AdItemModel.fromJson(Map<String, dynamic> json) => AdItemModel(
        areaIds: asT<String?>(json['area_ids']),
        id: asT<int?>(json['id']),
        image: asT<String?>(json['image']),
      );

  String? areaIds;
  int? id;
  String? image;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'area_ids': areaIds,
        'id': id,
        'image': image,
      };
}

class SwiperItemModel {
  SwiperItemModel({
    this.id,
    this.image,
  });

  factory SwiperItemModel.fromJson(Map<String, dynamic> json) =>
      SwiperItemModel(
        id: asT<int?>(json['id']),
        image: asT<String?>(json['image']),
      );

  int? id;
  String? image;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'image': image,
      };
}
