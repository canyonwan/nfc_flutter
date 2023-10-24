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

class GuessLikeRootModel {
  GuessLikeRootModel({
    required this.code,
    this.data,
    required this.msg,
  });

  factory GuessLikeRootModel.fromJson(Map<String, dynamic> json) =>
      GuessLikeRootModel(
        code: asT<int>(json['code'])!,
        data: json['data'] == null
            ? null
            : GuessLikeDataModel.fromJson(
                asT<Map<String, dynamic>>(json['data'])!),
        msg: asT<String>(json['msg'])!,
      );

  int code;
  GuessLikeDataModel? data;
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

class GuessLikeDataModel {
  GuessLikeDataModel({
    this.goodsList,
    this.totalPage,
  });

  factory GuessLikeDataModel.fromJson(Map<String, dynamic> json) {
    final List<GuessGoodsModel>? goodsList =
        json['goods_list'] is List ? <GuessGoodsModel>[] : null;
    if (goodsList != null) {
      for (final dynamic item in json['goods_list']!) {
        if (item != null) {
          tryCatch(() {
            goodsList.add(
                GuessGoodsModel.fromJson(asT<Map<String, dynamic>>(item)!));
          });
        }
      }
    }
    return GuessLikeDataModel(
      goodsList: goodsList,
      totalPage: asT<int?>(json['total_page']),
    );
  }

  List<GuessGoodsModel>? goodsList;
  int? totalPage;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'goods_list': goodsList,
        'total_page': totalPage,
      };
}

class GuessGoodsModel {
  GuessGoodsModel({
    this.exclusivePrice,
    this.goodsImage,
    this.goodsName,
    this.goodsPrice,
    this.id,
    this.originalPrice,
  });

  factory GuessGoodsModel.fromJson(Map<String, dynamic> json) =>
      GuessGoodsModel(
        exclusivePrice: asT<String?>(json['exclusive_price']),
        goodsImage: asT<String?>(json['goods_image']),
        goodsName: asT<String?>(json['goods_name']),
        goodsPrice: asT<String?>(json['goods_price']),
        id: asT<int?>(json['id']),
        originalPrice: asT<String?>(json['original_price']),
      );

  String? exclusivePrice;
  String? goodsImage;
  String? goodsName;
  String? goodsPrice;
  int? id;
  String? originalPrice;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'exclusive_price': exclusivePrice,
        'goods_image': goodsImage,
        'goods_name': goodsName,
        'goods_price': goodsPrice,
        'id': id,
        'original_price': originalPrice,
      };
}
