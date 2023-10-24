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

class CartCommitOrderRootModel {
  CartCommitOrderRootModel({
    required this.code,
    this.data,
    required this.msg,
  });

  factory CartCommitOrderRootModel.fromJson(Map<String, dynamic> json) =>
      CartCommitOrderRootModel(
        code: asT<int>(json['code'])!,
        data: json['data'] == null
            ? null
            : CartCommitOrderDataModel.fromJson(
                asT<Map<String, dynamic>>(json['data'])!),
        msg: asT<String>(json['msg'])!,
      );

  int code;
  CartCommitOrderDataModel? data;
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

class CartCommitOrderDataModel {
  CartCommitOrderDataModel({
    this.cardNumber,
    this.orderSn,
  });

  factory CartCommitOrderDataModel.fromJson(Map<String, dynamic> json) =>
      CartCommitOrderDataModel(
        cardNumber: asT<int?>(json['card_number']),
        orderSn: asT<String?>(json['order_sn']),
      );

  int? cardNumber;
  String? orderSn;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'card_number': cardNumber,
        'order_sn': orderSn,
      };
}
