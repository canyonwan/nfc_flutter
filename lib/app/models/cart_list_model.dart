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

class CartListRootModel {
  CartListRootModel({
    required this.code,
    this.data,
    required this.msg,
  });

  factory CartListRootModel.fromJson(Map<String, dynamic> json) =>
      CartListRootModel(
        code: asT<int>(json['code'])!,
        data: json['data'] == null
            ? null
            : CartDataModel.fromJson(asT<Map<String, dynamic>>(json['data'])!),
        msg: asT<String>(json['msg'])!,
      );

  int code;
  CartDataModel? data;
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

class CartDataModel {
  CartDataModel({
    this.full,
    this.ifMessageShow,
    this.invalid,
    this.messageCount,
    this.notSend,
    this.today,
    this.todaySend,
  });

  factory CartDataModel.fromJson(Map<String, dynamic> json) {
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
    return CartDataModel(
      full: asT<String?>(json['full']),
      ifMessageShow: asT<int?>(json['if_message_show']),
      invalid: invalid,
      messageCount: asT<int?>(json['message_count']),
      notSend: notSend,
      today: today,
      todaySend: todaySend,
    );
  }

  String? full;
  int? ifMessageShow;
  List<CartGoodsModel>? invalid;
  int? messageCount;
  List<CartGoodsModel>? notSend;
  List<CartGoodsModel>? today;
  List<CartGoodsModel>? todaySend;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'full': full,
        'if_message_show': ifMessageShow,
        'invalid': invalid,
        'message_count': messageCount,
        'not_send': notSend,
        'today': today,
        'today_send': todaySend,
      };
}

class CartGoodsModel {
  CartGoodsModel({
    this.cartId,
    this.check,
    this.freight,
    this.goodsId,
    this.goodsImage,
    this.goodsName,
    this.goodsNum,
    this.goodsPrice,
    this.specification,
    this.status,
    this.totalPrice,
  });

  factory CartGoodsModel.fromJson(Map<String, dynamic> json) => CartGoodsModel(
        cartId: asT<int?>(json['cart_id']),
        check: asT<bool?>(json['check']),
        freight: asT<String?>(json['freight']),
        goodsId: asT<int?>(json['goods_id']),
        goodsImage: asT<String?>(json['goods_image']),
        goodsName: asT<String?>(json['goods_name']),
        goodsNum: asT<String?>(json['goods_num']),
        goodsPrice: asT<String?>(json['goods_price']),
        specification: asT<String?>(json['specification']),
        status: asT<String?>(json['status']),
        totalPrice: asT<String?>(json['total_price']),
      );

  int? cartId;
  bool? check;
  String? freight;
  int? goodsId;
  String? goodsImage;
  String? goodsName;
  String? goodsNum;
  String? goodsPrice;
  String? specification;
  String? status;
  String? totalPrice;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'cart_id': cartId,
        'check': check,
        'freight': freight,
        'goods_id': goodsId,
        'goods_image': goodsImage,
        'goods_name': goodsName,
        'goods_num': goodsNum,
        'goods_price': goodsPrice,
        'specification': specification,
        'status': status,
        'total_price': totalPrice,
      };
}
