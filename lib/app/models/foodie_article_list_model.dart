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

class FoodieArticleListRootModel {
  FoodieArticleListRootModel({
    required this.code,
    required this.msg,
    this.data,
  });

  factory FoodieArticleListRootModel.fromJson(Map<String, dynamic> json) =>
      FoodieArticleListRootModel(
        code: asT<int>(json['code'])!,
        msg: asT<String>(json['msg'])!,
        data: json['data'] == null
            ? null
            : FoodieArticleListDataModel.fromJson(
                asT<Map<String, dynamic>>(json['data'])!),
      );

  int code;
  String msg;
  FoodieArticleListDataModel? data;

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

class FoodieArticleListDataModel {
  FoodieArticleListDataModel({
    required this.totalPage,
    required this.list,
  });

  factory FoodieArticleListDataModel.fromJson(Map<String, dynamic> json) {
    final List<FoodieArticleItemModel>? list =
        json['list'] is List ? <FoodieArticleItemModel>[] : null;
    if (list != null) {
      for (final dynamic item in json['list']!) {
        if (item != null) {
          tryCatch(() {
            list.add(FoodieArticleItemModel.fromJson(
                asT<Map<String, dynamic>>(item)!));
          });
        }
      }
    }
    return FoodieArticleListDataModel(
      totalPage: asT<int>(json['total_page'])!,
      list: list!,
    );
  }

  int totalPage;
  List<FoodieArticleItemModel> list;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'total_page': totalPage,
        'list': list,
      };
}

class FoodieArticleItemModel {
  FoodieArticleItemModel({
    required this.id,
    required this.title,
    required this.image,
    required this.createtime,
  });

  factory FoodieArticleItemModel.fromJson(Map<String, dynamic> json) =>
      FoodieArticleItemModel(
        id: asT<int>(json['id'])!,
        title: asT<String>(json['title'])!,
        image: asT<String>(json['image'])!,
        createtime: asT<String>(json['createtime'])!,
      );

  int id;
  String title;
  String image;
  String createtime;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'title': title,
        'image': image,
        'createtime': createtime,
      };
}
