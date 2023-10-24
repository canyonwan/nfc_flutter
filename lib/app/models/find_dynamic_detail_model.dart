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

class FindDynamicDetailRootModel {
  FindDynamicDetailRootModel({
    required this.code,
    this.data,
    required this.msg,
  });

  factory FindDynamicDetailRootModel.fromJson(Map<String, dynamic> json) =>
      FindDynamicDetailRootModel(
        code: asT<int>(json['code'])!,
        data: json['data'] == null
            ? null
            : FindDynamicDetailDataModel.fromJson(
                asT<Map<String, dynamic>>(json['data'])!),
        msg: asT<String>(json['msg'])!,
      );

  int code;
  FindDynamicDetailDataModel? data;
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

class FindDynamicDetailDataModel {
  FindDynamicDetailDataModel({
    this.articleId,
    this.articleName,
    this.content,
    this.createtime,
    this.enjoy,
    this.id,
    this.images,
    this.title,
  });

  factory FindDynamicDetailDataModel.fromJson(Map<String, dynamic> json) {
    final List<String>? images = json['images'] is List ? <String>[] : null;
    if (images != null) {
      for (final dynamic item in json['images']!) {
        if (item != null) {
          tryCatch(() {
            images.add(asT<String>(item)!);
          });
        }
      }
    }
    return FindDynamicDetailDataModel(
      articleId: asT<int?>(json['article_id']),
      articleName: asT<String?>(json['article_name']),
      content: asT<String?>(json['content']),
      createtime: asT<String?>(json['createtime']),
      enjoy: json['enjoy'] == null
          ? null
          : ShareItemModel.fromJson(asT<Map<String, dynamic>>(json['enjoy'])!),
      id: asT<int?>(json['id']),
      images: images,
      title: asT<String?>(json['title']),
    );
  }

  int? articleId;
  String? articleName;
  String? content;
  String? createtime;
  ShareItemModel? enjoy;
  int? id;
  List<String>? images;
  String? title;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'article_id': articleId,
        'article_name': articleName,
        'content': content,
        'createtime': createtime,
        'enjoy': enjoy,
        'id': id,
        'images': images,
        'title': title,
      };
}
