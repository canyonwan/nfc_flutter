import 'dart:convert';

T? asT<T>(dynamic value) {
  if (value is T) {
    return value;
  }
  return null;
}

class RecordUploadVideoRootModel {
  RecordUploadVideoRootModel({
    required this.code,
    required this.msg,
    required this.data,
  });

  factory RecordUploadVideoRootModel.fromJson(Map<String, dynamic> json) =>
      RecordUploadVideoRootModel(
        code: asT<int>(json['code'])!,
        msg: asT<String>(json['msg'])!,
        data: RecordUploadVideoDataModel.fromJson(
            asT<Map<String, dynamic>>(json['data'])!),
      );

  int code;
  String msg;
  RecordUploadVideoDataModel data;

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

class RecordUploadVideoDataModel {
  RecordUploadVideoDataModel({
    required this.fileUrl,
    required this.imageUrl,
  });

  factory RecordUploadVideoDataModel.fromJson(Map<String, dynamic> json) =>
      RecordUploadVideoDataModel(
        fileUrl: asT<String>(json['file_url'])!,
        imageUrl: asT<String>(json['image_url'])!,
      );

  String fileUrl;
  String imageUrl;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'file_url': fileUrl,
        'image_url': imageUrl,
      };
}
