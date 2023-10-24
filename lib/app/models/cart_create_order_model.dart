import 'dart:convert';
import 'dart:developer';

import 'package:mallxx_app/app/models/address_model.dart';
import 'package:mallxx_app/app/models/cart_list_model.dart';

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

class CartCreateOrderRootModel {
  CartCreateOrderRootModel({
    required this.code,
    this.data,
    required this.msg,
  });

  factory CartCreateOrderRootModel.fromJson(Map<String, dynamic> json) =>
      CartCreateOrderRootModel(
        code: asT<int>(json['code'])!,
        data: json['data'] == null
            ? null
            : CartCreateOrderDataModel.fromJson(
                asT<Map<String, dynamic>>(json['data'])!),
        msg: asT<String>(json['msg'])!,
      );

  int code;
  CartCreateOrderDataModel? data;
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

class CartCreateOrderDataModel {
  CartCreateOrderDataModel({
    this.goodsPrice,
    this.ifHasVoucher,
    this.ifShowAddress,
    this.invalid,
    this.invalidTime,
    this.isVip,
    this.jisuan,
    this.notSend,
    this.notSendTime,
    this.showAddress,
    this.specialPrice,
    this.today,
    this.todaySend,
    this.todaySendTime,
    this.todayTime,
    this.totalFee,
    this.totalPrice,
    this.voucherPrice,
  });

  factory CartCreateOrderDataModel.fromJson(Map<String, dynamic> json) {
    final List<CartGoodsModel>? invalid =
        json['invalid'] is List ? <CartGoodsModel>[] : null;
    if (invalid != null) {
      for (final dynamic item in json['invalid']!) {
        if (item != null) {
          tryCatch(() {
            invalid
                .add(CartGoodsModel.fromJson(asT<Map<String, dynamic>>(item)!));
          });
        }
      }
    }

    final List<CartGoodsModel>? notSend =
        json['not_send'] is List ? <CartGoodsModel>[] : null;
    if (notSend != null) {
      for (final dynamic item in json['not_send']!) {
        if (item != null) {
          tryCatch(() {
            notSend
                .add(CartGoodsModel.fromJson(asT<Map<String, dynamic>>(item)!));
          });
        }
      }
    }

    final List<CartGoodsModel>? today =
        json['today'] is List ? <CartGoodsModel>[] : null;
    if (today != null) {
      for (final dynamic item in json['today']!) {
        if (item != null) {
          tryCatch(() {
            today
                .add(CartGoodsModel.fromJson(asT<Map<String, dynamic>>(item)!));
          });
        }
      }
    }

    final List<CartGoodsModel>? todaySend =
        json['today_send'] is List ? <CartGoodsModel>[] : null;
    if (todaySend != null) {
      for (final dynamic item in json['today_send']!) {
        if (item != null) {
          tryCatch(() {
            todaySend
                .add(CartGoodsModel.fromJson(asT<Map<String, dynamic>>(item)!));
          });
        }
      }
    }
    return CartCreateOrderDataModel(
      goodsPrice: asT<String?>(json['goods_price']),
      ifHasVoucher: asT<int?>(json['if_has_voucher']),
      ifShowAddress: asT<int?>(json['if_show_address']),
      invalid: invalid,
      invalidTime: asT<String?>(json['invalid_time']),
      isVip: asT<int?>(json['is_vip']),
      jisuan: asT<int?>(json['jisuan']),
      notSend: notSend,
      notSendTime: asT<String?>(json['not_send_time']),
      showAddress: json['show_address'] == null
          ? null
          : MyAddressItem.fromJson(
              asT<Map<String, dynamic>>(json['show_address'])!),
      specialPrice: asT<String?>(json['special_price']),
      today: today,
      todaySend: todaySend,
      todaySendTime: asT<String?>(json['today_send_time']),
      todayTime: asT<String?>(json['today_time']),
      totalFee: asT<String?>(json['total_fee']),
      totalPrice: asT<String?>(json['total_price']),
      voucherPrice: asT<String?>(json['voucher_price']),
    );
  }

  String? goodsPrice;
  int? ifHasVoucher;
  int? ifShowAddress;
  List<CartGoodsModel>? invalid;
  String? invalidTime;
  int? isVip;
  int? jisuan;
  List<CartGoodsModel>? notSend;
  String? notSendTime;
  MyAddressItem? showAddress;
  String? specialPrice;
  List<CartGoodsModel>? today;
  List<CartGoodsModel>? todaySend;
  String? todaySendTime;
  String? todayTime;
  String? totalFee;
  String? totalPrice;
  String? voucherPrice;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'goods_price': goodsPrice,
        'if_has_voucher': ifHasVoucher,
        'if_show_address': ifShowAddress,
        'invalid': invalid,
        'invalid_time': invalidTime,
        'is_vip': isVip,
        'jisuan': jisuan,
        'not_send': notSend,
        'not_send_time': notSendTime,
        'show_address': showAddress,
        'special_price': specialPrice,
        'today': today,
        'today_send': todaySend,
        'today_send_time': todaySendTime,
        'today_time': todayTime,
        'total_fee': totalFee,
        'total_price': totalPrice,
        'voucher_price': voucherPrice,
      };
}
