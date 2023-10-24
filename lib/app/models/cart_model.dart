import 'dart:convert';
import 'dart:developer';

class CartResponse {
  int? code;
  List<Cart>? data;
  String? detail;

  CartResponse({this.code, this.data, this.detail});

  CartResponse.fromJson(Map<String, dynamic> json) {
    code = json["code"];
    detail = json["detail"];
    if (json["data"] != null) {
      data = <Cart>[];
      json["data"].forEach((v) {
        data?.add(Cart.formJson(v));
      });
    }
  }
}

class Cart {
  int? id;
  int? productId;
  String? productName;
  String? productPic;
  String? attribute;
  double? price;
  int? quantity;
  int? memberId;
  bool? check = true; //number

  Cart({
    this.id,
    this.productId,
    this.productName,
    this.productPic,
    this.attribute,
    this.price,
    this.quantity,
    this.memberId,
    this.check,
  });

  Cart.formJson(Map<String, dynamic> json) {
    productId = json["product_id"];
    productName = json["product_name"];
    id = json["id"];
    productPic = json["product_pic"];
    // attribute = json["product_attr"];
    if (json["product_attr"] != null) {
      List<String> arr = [];
      List<dynamic> attr = jsonDecode(json["product_attr"]);
      attr.forEach((v) {
        arr.add(v["value"]!);
      });
      attribute = arr.join("/");
    }
    price = json["price"] + 0.00;
    quantity = json["quantity"];
    memberId = json["member_id"];
    check = true;
  }
}

/// 购物车
/// 商品数量
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

class GoodsCountInCartRootModel {
  GoodsCountInCartRootModel({
    this.msg,
    this.data,
    this.code,
  });

  factory GoodsCountInCartRootModel.fromJson(Map<String, dynamic> jsonRes) =>
      GoodsCountInCartRootModel(
        msg: asT<String?>(jsonRes['msg']),
        data: jsonRes['data'] == null
            ? null
            : GoodsCountInCartDataModel.fromJson(
                asT<Map<String, dynamic>>(jsonRes['data'])!),
        code: asT<int?>(jsonRes['code']),
      );

  String? msg;
  GoodsCountInCartDataModel? data;
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

class GoodsCountInCartDataModel {
  GoodsCountInCartDataModel({
    required this.orderNum,
    required this.messageCount,
    required this.ifMessageShow,
    required this.cardNumber,
    required this.kucunNum,
  });

  factory GoodsCountInCartDataModel.fromJson(Map<String, dynamic> jsonRes) =>
      GoodsCountInCartDataModel(
        orderNum: asT<int>(jsonRes['order_num'])!,
        messageCount: asT<int>(jsonRes['message_count'])!,
        ifMessageShow: asT<int>(jsonRes['if_message_show'])!,
        cardNumber: asT<int>(jsonRes['card_number'])!,
        kucunNum: asT<int>(jsonRes['kucun_num'])!,
      );

  int orderNum;
  int messageCount;
  int ifMessageShow;
  int cardNumber;
  int kucunNum;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'order_num': orderNum,
        'message_count': messageCount,
        'if_message_show': ifMessageShow,
        'card_number': cardNumber,
        'kucun_num': kucunNum,
      };
}

// 计算购物车价格
class CalcCartTotalPriceRootModel {
  CalcCartTotalPriceRootModel({
    required this.code,
    this.data,
    required this.msg,
  });

  factory CalcCartTotalPriceRootModel.fromJson(Map<String, dynamic> json) =>
      CalcCartTotalPriceRootModel(
        code: asT<int>(json['code'])!,
        data: json['data'] == null
            ? null
            : CalcCartTotalPriceDataModel.fromJson(
                asT<Map<String, dynamic>>(json['data'])!),
        msg: asT<String>(json['msg'])!,
      );

  int code;
  CalcCartTotalPriceDataModel? data;
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

class CalcCartTotalPriceDataModel {
  CalcCartTotalPriceDataModel({
    this.freight,
    this.goodsPrice,
  });

  factory CalcCartTotalPriceDataModel.fromJson(Map<String, dynamic> json) =>
      CalcCartTotalPriceDataModel(
        freight: asT<String?>(json['freight']),
        goodsPrice: asT<String?>(json['goods_price']),
      );

  String? freight;
  String? goodsPrice;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'freight': freight,
        'goods_price': goodsPrice,
      };
}
