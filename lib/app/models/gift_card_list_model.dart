import 'dart:convert';

T? asT<T>(dynamic value) {
  if (value is T) {
    return value;
  }
  return null;
}

class GiftCardListRootModel {
  GiftCardListRootModel({
    required this.code,
    required this.msg,
    this.data,
  });

  factory GiftCardListRootModel.fromJson(Map<String, dynamic> json) =>
      GiftCardListRootModel(
        code: asT<int>(json['code'])!,
        msg: asT<String>(json['msg'])!,
        data: json['data'] == null
            ? null
            : GiftCardListDataModel.fromJson(
                asT<Map<String, dynamic>>(json['data'])!),
      );

  int code;
  String msg;
  GiftCardListDataModel? data;

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

class GiftCardListDataModel {
  GiftCardListDataModel({
    required this.count,
    this.list,
  });

  factory GiftCardListDataModel.fromJson(Map<String, dynamic> json) {
    final List<GiftCardItemModel>? list =
        json['list'] is List ? <GiftCardItemModel>[] : null;
    if (list != null) {
      for (final dynamic item in json['list']!) {
        if (item != null) {
          list.add(
              GiftCardItemModel.fromJson(asT<Map<String, dynamic>>(item)!));
        }
      }
    }
    return GiftCardListDataModel(
      count: asT<int>(json['count'])!,
      list: list,
    );
  }

  int count;
  List<GiftCardItemModel>? list;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'count': count,
        'list': list,
      };
}

class GiftCardItemModel {
  GiftCardItemModel({
    required this.name,
    required this.detail,
    required this.remark,
    required this.number,
    required this.endTime,
  });

  factory GiftCardItemModel.fromJson(Map<String, dynamic> json) =>
      GiftCardItemModel(
        name: asT<String>(json['name'])!,
        detail: asT<String>(json['detail'])!,
        remark: asT<String>(json['remark'])!,
        number: asT<String>(json['number'])!,
        endTime: asT<String>(json['end_time'])!,
      );

  String name;
  String detail;
  String remark;
  String number;
  String endTime;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'name': name,
        'detail': detail,
        'remark': remark,
        'number': number,
        'end_time': endTime,
      };
}
