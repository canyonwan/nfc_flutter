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

class GranarySubmitOrderRootModel {
  GranarySubmitOrderRootModel({
    this.msg,
    this.data,
    this.code,
  });

  factory GranarySubmitOrderRootModel.fromJson(Map<String, dynamic> jsonRes) =>
      GranarySubmitOrderRootModel(
        msg: asT<String?>(jsonRes['msg']),
        data: jsonRes['data'] == null
            ? null
            : SubmitOrderDataModel.fromJson(
                asT<Map<String, dynamic>>(jsonRes['data'])!),
        code: asT<int?>(jsonRes['code']),
      );

  String? msg;
  SubmitOrderDataModel? data;
  int? code;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'msg': msg,
        'data': data,
        'code': code,
      };
}

class SubmitOrderDataModel {
  SubmitOrderDataModel({
    this.totalPrice,
    this.orderSn,
  });

  factory SubmitOrderDataModel.fromJson(Map<String, dynamic> jsonRes) =>
      SubmitOrderDataModel(
        totalPrice: asT<double?>(jsonRes['total_price']),
        orderSn: asT<String?>(jsonRes['order_sn']),
      );

  double? totalPrice;
  String? orderSn;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'total_price': totalPrice,
        'order_sn': orderSn,
      };
}
