import 'dart:convert';
import 'dart:developer';

import 'find_model_entity.dart';

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

class FindVideoDetailRootModel {
  FindVideoDetailRootModel({
    required this.code,
    this.data,
    required this.msg,
  });

  factory FindVideoDetailRootModel.fromJson(Map<String, dynamic> json) =>
      FindVideoDetailRootModel(
        code: asT<int>(json['code'])!,
        data: json['data'] == null
            ? null
            : FindVideoDetailDataModel.fromJson(
                asT<Map<String, dynamic>>(json['data'])!),
        msg: asT<String>(json['msg'])!,
      );

  int code;
  FindVideoDetailDataModel? data;
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

class FindVideoDetailDataModel {
  FindVideoDetailDataModel({
    this.articleId,
    this.articleName,
    this.createtime,
    this.enjoy,
    this.height,
    this.id,
    this.title,
    this.videoImage,
    this.videoReturn,
    this.width,
  });

  factory FindVideoDetailDataModel.fromJson(Map<String, dynamic> json) =>
      FindVideoDetailDataModel(
        articleId: asT<int?>(json['article_id']),
        articleName: asT<String?>(json['article_name']),
        createtime: asT<String?>(json['createtime']),
        enjoy: json['enjoy'] == null
            ? null
            : ShareItemModel.fromJson(
                asT<Map<String, dynamic>>(json['enjoy'])!),
        height: asT<String?>(json['height']),
        id: asT<int?>(json['id']),
        title: asT<String?>(json['title']),
        videoImage: asT<String?>(json['video_image']),
        videoReturn: asT<String?>(json['video_return']),
        width: asT<String?>(json['width']),
      );

  int? articleId;
  String? articleName;
  String? createtime;
  ShareItemModel? enjoy;
  String? height;
  int? id;
  String? title;
  String? videoImage;
  String? videoReturn;
  String? width;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'article_id': articleId,
        'article_name': articleName,
        'createtime': createtime,
        'enjoy': enjoy,
        'height': height,
        'id': id,
        'title': title,
        'video_image': videoImage,
        'video_return': videoReturn,
        'width': width,
      };
}
