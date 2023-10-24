import 'dart:convert';

T? asT<T>(dynamic value) {
  if (value is T) {
    return value;
  }
  return null;
}

class PictureArticleRootModel {
  PictureArticleRootModel({
    required this.code,
    required this.msg,
    required this.data,
  });

  factory PictureArticleRootModel.fromJson(Map<String, dynamic> json) =>
      PictureArticleRootModel(
        code: asT<int>(json['code'])!,
        msg: asT<String>(json['msg'])!,
        data: PictureArticleDataModel.fromJson(
            asT<Map<String, dynamic>>(json['data'])!),
      );

  int code;
  String msg;
  PictureArticleDataModel data;

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

class PictureArticleDataModel {
  PictureArticleDataModel({
    required this.id,
    required this.title,
    required this.shareExplain,
    required this.content,
    required this.images,
    required this.vlabelIds,
    required this.ifPrivate,
  });

  factory PictureArticleDataModel.fromJson(Map<String, dynamic> json) {
    final List<String>? images = json['images'] is List ? <String>[] : null;
    if (images != null) {
      for (final dynamic item in json['images']!) {
        if (item != null) {
          images.add(asT<String>(item)!);
        }
      }
    }

    final List<String>? vlabelIds =
        json['vlabel_ids'] is List ? <String>[] : null;
    if (vlabelIds != null) {
      for (final dynamic item in json['vlabel_ids']!) {
        if (item != null) {
          vlabelIds.add(asT<String>(item)!);
        }
      }
    }
    return PictureArticleDataModel(
      id: asT<int>(json['id'])!,
      title: asT<String>(json['title'])!,
      shareExplain: asT<String>(json['share_explain'])!,
      content: asT<String>(json['content'])!,
      images: images!,
      vlabelIds: vlabelIds!,
      ifPrivate: asT<int>(json['if_private'])!,
    );
  }

  int id;
  String title;
  String shareExplain;
  String content;
  List<String> images;
  List<String> vlabelIds;
  int ifPrivate;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'title': title,
        'share_explain': shareExplain,
        'content': content,
        'images': images,
        'vlabel_ids': vlabelIds,
        'if_private': ifPrivate,
      };
}
