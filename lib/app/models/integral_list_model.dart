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

class IntegralRootModel {
  IntegralRootModel({
    required this.code,
    this.data,
    required this.msg,
  });

  factory IntegralRootModel.fromJson(Map<String, dynamic> json) =>
      IntegralRootModel(
        code: asT<int>(json['code'])!,
        data: json['data'] == null
            ? null
            : IntegralDataModel.fromJson(
                asT<Map<String, dynamic>>(json['data'])!),
        msg: asT<String>(json['msg'])!,
      );

  int code;
  IntegralDataModel? data;
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

class IntegralDataModel {
  IntegralDataModel({
    this.integral,
    this.integralListInfo,
    this.maxpage,
  });

  factory IntegralDataModel.fromJson(Map<String, dynamic> json) {
    final List<IntegralItemModel>? integralListInfo =
        json['integral_list_info'] is List ? <IntegralItemModel>[] : null;
    if (integralListInfo != null) {
      for (final dynamic item in json['integral_list_info']!) {
        if (item != null) {
          tryCatch(() {
            integralListInfo.add(
                IntegralItemModel.fromJson(asT<Map<String, dynamic>>(item)!));
          });
        }
      }
    }
    return IntegralDataModel(
      integral: asT<int?>(json['integral']),
      integralListInfo: integralListInfo,
      maxpage: asT<int?>(json['maxPage']),
    );
  }

  int? integral;
  List<IntegralItemModel>? integralListInfo;
  int? maxpage;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'integral': integral,
        'integral_list_info': integralListInfo,
        'maxPage': maxpage,
      };
}

class IntegralItemModel {
  IntegralItemModel({
    this.createtime,
    this.describe,
    this.id,
    this.integral,
    this.memberId,
    this.type,
  });

  factory IntegralItemModel.fromJson(Map<String, dynamic> json) =>
      IntegralItemModel(
        createtime: asT<String?>(json['createtime']),
        describe: asT<String?>(json['describe']),
        id: asT<int?>(json['id']),
        integral: asT<String?>(json['integral']),
        memberId: asT<int?>(json['member_id']),
        type: asT<int?>(json['type']),
      );

  String? createtime;
  String? describe;
  int? id;
  String? integral;
  int? memberId;
  int? type;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'createtime': createtime,
        'describe': describe,
        'id': id,
        'integral': integral,
        'member_id': memberId,
        'type': type,
      };
}
