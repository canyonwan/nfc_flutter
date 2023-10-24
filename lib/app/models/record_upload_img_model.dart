import 'dart:convert';

T? asT<T>(dynamic value) {
  if (value is T) {
    return value;
  }
  return null;
}

class RecordUploadImageRootModel {
  RecordUploadImageRootModel({
    required this.code,
    required this.msg,
    required this.data,
  });

  factory RecordUploadImageRootModel.fromJson(Map<String, dynamic> json) {
    final List<String>? data = json['data'] is List ? <String>[] : null;
    if (data != null) {
      for (final dynamic item in json['data']!) {
        if (item != null) {
          data.add(asT<String>(item)!);
        }
      }
    }
    return RecordUploadImageRootModel(
      code: asT<int>(json['code'])!,
      msg: asT<String>(json['msg'])!,
      data: data!,
    );
  }

  int code;
  String msg;
  List<String> data;

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
