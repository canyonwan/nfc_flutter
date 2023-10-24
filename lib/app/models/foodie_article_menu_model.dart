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

T? asT<T>(dynamic value) {
  if (value is T) {
    return value;
  }
  return null;
}

class FoodieArticleMenuRootModel {
  FoodieArticleMenuRootModel({
    required this.code,
    required this.msg,
    this.data,
  });

  factory FoodieArticleMenuRootModel.fromJson(Map<String, dynamic> json) {
    final List<FoodieArticleMenuItemModel>? data =
        json['data'] is List ? <FoodieArticleMenuItemModel>[] : null;
    if (data != null) {
      for (final dynamic item in json['data']!) {
        if (item != null) {
          tryCatch(() {
            data.add(FoodieArticleMenuItemModel.fromJson(
                asT<Map<String, dynamic>>(item)!));
          });
        }
      }
    }
    return FoodieArticleMenuRootModel(
      code: asT<int>(json['code'])!,
      msg: asT<String>(json['msg'])!,
      data: data,
    );
  }

  int code;
  String msg;
  List<FoodieArticleMenuItemModel>? data;

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

class FoodieArticleMenuItemModel {
  FoodieArticleMenuItemModel({
    required this.id,
    required this.name,
  });

  factory FoodieArticleMenuItemModel.fromJson(Map<String, dynamic> json) =>
      FoodieArticleMenuItemModel(
        id: asT<int>(json['id'])!,
        name: asT<String>(json['name'])!,
      );

  int id;
  String name;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'name': name,
      };
}
