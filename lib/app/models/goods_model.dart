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

class GoodsListRootModel {
  const GoodsListRootModel({
    required this.msg,
    this.data,
    required this.code,
  });

  factory GoodsListRootModel.fromJson(Map<String, dynamic> json) =>
      GoodsListRootModel(
        msg: asT<String>(json['msg'])!,
        data: json['data'] == null
            ? null
            : GoodsListDataModel.fromJson(
                asT<Map<String, dynamic>>(json['data'])!),
        code: asT<int>(json['code'])!,
      );

  final String msg;
  final GoodsListDataModel? data;
  final int code;

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

class GoodsListDataModel {
  const GoodsListDataModel({
    this.messageCount,
    this.maxpage,
    this.list,
    this.ifMessageShow,
    this.enjoy,
  });

  factory GoodsListDataModel.fromJson(Map<String, dynamic> json) {
    final List<GoodsItemModel>? list =
        json['list'] is List ? <GoodsItemModel>[] : null;
    if (list != null) {
      for (final dynamic item in json['list']!) {
        if (item != null) {
          tryCatch(() {
            list.add(GoodsItemModel.fromJson(asT<Map<String, dynamic>>(item)!));
          });
        }
      }
    }
    return GoodsListDataModel(
      messageCount: asT<int?>(json['message_count']),
      maxpage: asT<int?>(json['maxPage']),
      list: list,
      ifMessageShow: asT<int?>(json['if_message_show']),
      enjoy: json['enjoy'] == null
          ? null
          : ShareItemModel.fromJson(
          asT<Map<String, dynamic>>(json['enjoy'])!),
    );
  }

  final int? messageCount;
  final int? maxpage;
  final List<GoodsItemModel>? list;
  final int? ifMessageShow;
  final ShareItemModel? enjoy;
  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'message_count': messageCount,
        'maxPage': maxpage,
        'list': list,
        'if_message_show': ifMessageShow,
        'enjoy': enjoy,
      };
}

class GoodsItemModel {
  const GoodsItemModel({
    this.secondaryImages,
    this.salesVolume,
    this.ifSellOut,
    this.id,
    this.goodsUnit,
    this.goodsRemark,
    this.goodsPrice,
    this.goodsName,
    this.goodsImage,
    this.exclusivePrice,
    this.evaluationNumber,
    this.commodityCategoryId,
  });

  factory GoodsItemModel.fromJson(Map<String, dynamic> json) {
    final List<String>? secondaryImages =
        json['secondary_images'] is List ? <String>[] : null;
    if (secondaryImages != null) {
      for (final dynamic item in json['secondary_images']!) {
        if (item != null) {
          tryCatch(() {
            secondaryImages.add(asT<String>(item)!);
          });
        }
      }
    }
    return GoodsItemModel(
      secondaryImages: secondaryImages,
      salesVolume: asT<int?>(json['sales_volume']),
      ifSellOut: asT<int?>(json['if_sell_out']),
      id: asT<int?>(json['id']),
      goodsUnit: asT<String?>(json['goods_unit']),
      goodsRemark: asT<String?>(json['goods_remark']),
      goodsPrice: asT<String?>(json['goods_price']),
      goodsName: asT<String?>(json['goods_name']),
      goodsImage: asT<String?>(json['goods_image']),
      exclusivePrice: asT<String?>(json['exclusive_price']),
      evaluationNumber: asT<int?>(json['evaluation_number']),
      commodityCategoryId: asT<int?>(json['commodity_category_id']),
    );
  }

  final List<String>? secondaryImages;
  final int? salesVolume;
  final int? ifSellOut;
  final int? id;
  final String? goodsUnit;
  final String? goodsRemark;
  final String? goodsPrice;
  final String? goodsName;
  final String? goodsImage;
  final String? exclusivePrice;
  final int? evaluationNumber;
  final int? commodityCategoryId;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'secondary_images': secondaryImages,
        'sales_volume': salesVolume,
        'if_sell_out': ifSellOut,
        'id': id,
        'goods_unit': goodsUnit,
        'goods_remark': goodsRemark,
        'goods_price': goodsPrice,
        'goods_name': goodsName,
        'goods_image': goodsImage,
        'exclusive_price': exclusivePrice,
        'evaluation_number': evaluationNumber,
        'commodity_category_id': commodityCategoryId,
      };

}
class ShareItemModel {
  ShareItemModel({
    this.title,
    this.image,
    this.id,
    this.enjoyUrl,
    this.content,
  });

  factory ShareItemModel.fromJson(Map<String, dynamic> jsonRes) =>
      ShareItemModel(
        title: asT<String?>(jsonRes['title']),
        image: asT<String?>(jsonRes['image']),
        id: asT<int?>(jsonRes['id']),
        enjoyUrl: asT<String?>(jsonRes['enjoy_url']),
        content: asT<String?>(jsonRes['content']),
      );

  String? title;
  String? image;
  int? id;
  String? enjoyUrl;
  String? content;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'title': title,
    'image': image,
    'id': id,
    'enjoy_url': enjoyUrl,
    'content': content,
  };
}
