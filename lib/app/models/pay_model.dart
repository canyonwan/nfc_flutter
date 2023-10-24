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

class PayRootModel {
  PayRootModel({
    required this.code,
    this.data,
    required this.msg,
  });

  factory PayRootModel.fromJson(Map<String, dynamic> json) => PayRootModel(
        code: asT<int>(json['code'])!,
        data: json['data'] == null
            ? null
            : PayDataModel.fromJson(asT<Map<String, dynamic>>(json['data'])!),
        msg: asT<String>(json['msg'])!,
      );

  int code;
  PayDataModel? data;
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

class PayDataModel {
  PayDataModel({
    this.appid,
    this.alipay,
    this.noncestr,
    this.package,
    this.partnerid,
    this.prepayid,
    this.sign,
    this.timestamp,
  });

  factory PayDataModel.fromJson(Map<String, dynamic> json) => PayDataModel(
        appid: asT<String?>(json['appid']),
        alipay: asT<String?>(json['alipay']),
        noncestr: asT<String?>(json['noncestr']),
        package: asT<String?>(json['package']),
        partnerid: asT<String?>(json['partnerid']),
        prepayid: asT<String?>(json['prepayid']),
        sign: asT<String?>(json['sign']),
        timestamp: asT<int?>(json['timestamp']),
      );

  String? appid;
  String? alipay;
  String? noncestr;
  String? package;
  String? partnerid;
  String? prepayid;
  String? sign;
  int? timestamp;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'appid': appid,
        'alipay': alipay,
        'noncestr': noncestr,
        'package': package,
        'partnerid': partnerid,
        'prepayid': prepayid,
        'sign': sign,
        'timestamp': timestamp,
      };
}
