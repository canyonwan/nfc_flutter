import 'dart:convert';

T? asT<T>(dynamic value) {
  if (value is T) {
    return value;
  }
  return null;
}

class LabelListRootModel {
  LabelListRootModel({
    required this.code,
    required this.msg,
    required this.data,
  });

  factory LabelListRootModel.fromJson(Map<String, dynamic> json) {
    final List<LabelModel>? data = json['data'] is List ? <LabelModel>[] : null;
    if (data != null) {
      for (final dynamic item in json['data']!) {
        if (item != null) {
          data.add(LabelModel.fromJson(asT<Map<String, dynamic>>(item)!));
        }
      }
    }
    return LabelListRootModel(
      code: asT<int>(json['code'])!,
      msg: asT<String>(json['msg'])!,
      data: data!,
    );
  }

  int code;
  String msg;
  List<LabelModel> data;

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

class LabelModel {
  LabelModel({
    required this.id,
    required this.name,
  });

  factory LabelModel.fromJson(Map<String, dynamic> json) => LabelModel(
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
