import 'dart:convert';

T? asT<T>(dynamic value) {
  if (value is T) {
    return value;
  }
  return null;
}

class ShortVideoRootModel {
  ShortVideoRootModel({
    required this.code,
    required this.msg,
    required this.data,
  });

  factory ShortVideoRootModel.fromJson(Map<String, dynamic> json) =>
      ShortVideoRootModel(
        code: asT<int>(json['code'])!,
        msg: asT<String>(json['msg'])!,
        data: ShortVideoDataModel.fromJson(
            asT<Map<String, dynamic>>(json['data'])!),
      );

  int code;
  String msg;
  ShortVideoDataModel data;

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

class ShortVideoDataModel {
  ShortVideoDataModel({
    required this.id,
    required this.title,
    required this.videoImage,
    required this.videoFile,
    required this.vlabelIds,
    required this.weigh,
    required this.ifPrivate,
  });

  factory ShortVideoDataModel.fromJson(Map<String, dynamic> json) {
    final List<String>? vlabelIds =
        json['vlabel_ids'] is List ? <String>[] : null;
    if (vlabelIds != null) {
      for (final dynamic item in json['vlabel_ids']!) {
        if (item != null) {
          vlabelIds.add(asT<String>(item)!);
        }
      }
    }
    return ShortVideoDataModel(
      id: asT<int>(json['id'])!,
      title: asT<String>(json['title'])!,
      videoImage: asT<String>(json['video_image'])!,
      videoFile: asT<String>(json['video_file'])!,
      vlabelIds: vlabelIds!,
      weigh: asT<int>(json['weigh'])!,
      ifPrivate: asT<int>(json['if_private'])!,
    );
  }

  int id;
  String title;
  String videoImage;
  String videoFile;
  List<String> vlabelIds;
  int weigh;
  int ifPrivate;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'title': title,
        'video_image': videoImage,
        'video_file': videoFile,
        'vlabel_ids': vlabelIds,
        'weigh': weigh,
        'if_private': ifPrivate,
      };
}
