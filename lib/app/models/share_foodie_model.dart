import 'dart:convert';

T? asT<T>(dynamic value) {
  if (value is T) {
    return value;
  }
  return null;
}

class ShareFoodieRootModel {
  ShareFoodieRootModel({
    required this.code,
    required this.msg,
    this.data,
  });

  factory ShareFoodieRootModel.fromJson(Map<String, dynamic> json) =>
      ShareFoodieRootModel(
        code: asT<int>(json['code'])!,
        msg: asT<String>(json['msg'])!,
        data: json['data'] == null
            ? null
            : ShareFoodieDataModel.fromJson(
                asT<Map<String, dynamic>>(json['data'])!),
      );

  int code;
  String msg;
  ShareFoodieDataModel? data;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'code': code,
        'msg': msg,
        'data': data,
      };
}

class ShareFoodieDataModel {
  ShareFoodieDataModel({
    this.id,
    this.title,
    this.content,
    this.image,
    this.enjoyUrl,
  });

  factory ShareFoodieDataModel.fromJson(Map<String, dynamic> json) =>
      ShareFoodieDataModel(
        id: asT<int?>(json['id']),
        title: asT<String?>(json['title']),
        content: asT<String?>(json['content']),
        image: asT<String?>(json['image']),
        enjoyUrl: asT<String?>(json['enjoy_url']),
      );

  int? id;
  String? title;
  String? content;
  String? image;
  String? enjoyUrl;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'title': title,
        'content': content,
        'image': image,
        'enjoy_url': enjoyUrl,
      };
}
