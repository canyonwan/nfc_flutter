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

class CanProcessedProductionRootModel {
  CanProcessedProductionRootModel({
    this.msg,
    this.data,
    this.code,
  });

  factory CanProcessedProductionRootModel.fromJson(
      Map<String, dynamic> jsonRes) {
    final List<CanProcessedProductionModel>? data =
        jsonRes['data'] is List ? <CanProcessedProductionModel>[] : null;
    if (data != null) {
      for (final dynamic item in jsonRes['data']!) {
        if (item != null) {
          tryCatch(() {
            data.add(CanProcessedProductionModel.fromJson(
                asT<Map<String, dynamic>>(item)!));
          });
        }
      }
    }
    return CanProcessedProductionRootModel(
      msg: asT<String?>(jsonRes['msg']),
      data: data,
      code: asT<int?>(jsonRes['code']),
    );
  }

  String? msg;
  List<CanProcessedProductionModel>? data;
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

class CanProcessedProductionModel {
  CanProcessedProductionModel({
    this.goodsName,
    this.goodsImage,
    this.goodsId,
    this.expense,
    this.count,
  });

  factory CanProcessedProductionModel.fromJson(Map<String, dynamic> jsonRes) =>
      CanProcessedProductionModel(
        goodsName: asT<String?>(jsonRes['goods_name']),
        goodsImage: asT<String?>(jsonRes['goods_image']),
        goodsId: asT<int?>(jsonRes['goods_id']),
        count: asT<int?>(jsonRes['count']),
        expense: asT<String?>(jsonRes['expense']),
      );

  String? goodsName;
  String? goodsImage;
  int? goodsId;
  int? count;
  String? expense;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'goods_name': goodsName,
        'goods_image': goodsImage,
        'goods_id': goodsId,
        'count': count,
        'expense': expense,
      };
}
