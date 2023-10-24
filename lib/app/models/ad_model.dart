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

class ADRootModel {
  ADRootModel({
    required this.code,
    this.data,
    required this.msg,
  });

  factory ADRootModel.fromJson(Map<String, dynamic> json) => ADRootModel(
        code: asT<int>(json['code'])!,
        data: json['data'] == null
            ? null
            : ADDataModel.fromJson(asT<Map<String, dynamic>>(json['data'])!),
        msg: asT<String>(json['msg'])!,
      );

  int code;
  ADDataModel? data;
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

class ADDataModel {
  ADDataModel({
    this.content,
    this.goodsList,
    this.originArticles,
    this.shareExplain,
    this.shareUrl,
    this.shareImage,
    this.shareTitle,
    this.title,
    this.videoFile,
    this.videoImage,
    this.voucherList,
  });

  factory ADDataModel.fromJson(Map<String, dynamic> json) {
    final List<GoodsItemModel>? goodsList =
        json['goods_list'] is List ? <GoodsItemModel>[] : null;
    if (goodsList != null) {
      for (final dynamic item in json['goods_list']!) {
        if (item != null) {
          tryCatch(() {
            goodsList
                .add(GoodsItemModel.fromJson(asT<Map<String, dynamic>>(item)!));
          });
        }
      }
    }

    final List<FieldItemModel>? originArticles =
        json['origin_articles'] is List ? <FieldItemModel>[] : null;
    if (originArticles != null) {
      for (final dynamic item in json['origin_articles']!) {
        if (item != null) {
          tryCatch(() {
            originArticles
                .add(FieldItemModel.fromJson(asT<Map<String, dynamic>>(item)!));
          });
        }
      }
    }

    final List<VoucherItemModel>? voucherList =
        json['voucher_list'] is List ? <VoucherItemModel>[] : null;
    if (voucherList != null) {
      for (final dynamic item in json['voucher_list']!) {
        if (item != null) {
          tryCatch(() {
            voucherList.add(
                VoucherItemModel.fromJson(asT<Map<String, dynamic>>(item)!));
          });
        }
      }
    }
    return ADDataModel(
      content: asT<String?>(json['content']),
      goodsList: goodsList,
      originArticles: originArticles,
      shareExplain: asT<String?>(json['share_explain']),
      shareImage: asT<String?>(json['share_image']),
      shareUrl: asT<String?>(json['share_url']),
      shareTitle: asT<String?>(json['share_title']),
      title: asT<String?>(json['title']),
      videoFile: asT<String?>(json['video_file']),
      videoImage: asT<String?>(json['video_image']),
      voucherList: voucherList,
    );
  }

  String? content;
  List<GoodsItemModel>? goodsList;
  List<FieldItemModel>? originArticles;
  String? shareExplain;
  String? shareImage;
  String? shareUrl;
  String? shareTitle;
  String? title;
  String? videoFile;
  String? videoImage;
  List<VoucherItemModel>? voucherList;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'content': content,
        'goods_list': goodsList,
        'origin_articles': originArticles,
        'share_explain': shareExplain,
        'share_image': shareImage,
        'share_url': shareUrl,
        'share_title': shareTitle,
        'title': title,
        'video_file': videoFile,
        'video_image': videoImage,
        'voucher_list': voucherList,
      };
}

class GoodsItemModel {
  GoodsItemModel({
    this.evaluationNumber,
    this.exclusivePrice,
    this.goodsImage,
    this.goodsName,
    this.goodsPrice,
    this.id,
    this.originalPrice,
    this.salesVolume,
  });

  factory GoodsItemModel.fromJson(Map<String, dynamic> json) => GoodsItemModel(
        evaluationNumber: asT<int?>(json['evaluation_number']),
        exclusivePrice: asT<String?>(json['exclusive_price']),
        goodsImage: asT<String?>(json['goods_image']),
        goodsName: asT<String?>(json['goods_name']),
        goodsPrice: asT<String?>(json['goods_price']),
        id: asT<int?>(json['id']),
        originalPrice: asT<String?>(json['original_price']),
        salesVolume: asT<int?>(json['sales_volume']),
      );

  int? evaluationNumber;
  String? exclusivePrice;
  String? goodsImage;
  String? goodsName;
  String? goodsPrice;
  int? id;
  String? originalPrice;
  int? salesVolume;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'evaluation_number': evaluationNumber,
        'exclusive_price': exclusivePrice,
        'goods_image': goodsImage,
        'goods_name': goodsName,
        'goods_price': goodsPrice,
        'id': id,
        'original_price': originalPrice,
        'sales_volume': salesVolume,
      };
}

class VoucherModel {
  VoucherModel({
    this.amount,
    this.createtime,
    this.endTime,
    this.explain,
    this.full,
    this.getNum,
    this.id,
    this.name,
    this.price,
    this.residueNum,
    this.startTime,
  });

  factory VoucherModel.fromJson(Map<String, dynamic> json) => VoucherModel(
        amount: asT<int?>(json['amount']),
        createtime: asT<int?>(json['createtime']),
        endTime: asT<String?>(json['end_time']),
        explain: asT<String?>(json['explain']),
        full: asT<String?>(json['full']),
        getNum: asT<int?>(json['get_num']),
        id: asT<int?>(json['id']),
        name: asT<String?>(json['name']),
        price: asT<String?>(json['price']),
        residueNum: asT<int?>(json['residue_num']),
        startTime: asT<String?>(json['start_time']),
      );

  int? amount;
  int? createtime;
  String? endTime;
  String? explain;
  String? full;
  int? getNum;
  int? id;
  String? name;
  String? price;
  int? residueNum;
  String? startTime;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'amount': amount,
        'createtime': createtime,
        'end_time': endTime,
        'explain': explain,
        'full': full,
        'get_num': getNum,
        'id': id,
        'name': name,
        'price': price,
        'residue_num': residueNum,
        'start_time': startTime,
      };
}

class VoucherItemModel {
  VoucherItemModel({
    this.amount,
    this.createtime,
    this.endTime,
    this.explain,
    this.full,
    this.getNum,
    this.id,
    this.name,
    this.price,
    this.residueNum,
    this.startTime,
  });

  factory VoucherItemModel.fromJson(Map<String, dynamic> json) =>
      VoucherItemModel(
        amount: asT<int?>(json['amount']),
        createtime: asT<int?>(json['createtime']),
        endTime: asT<String?>(json['end_time']),
        explain: asT<String?>(json['explain']),
        full: asT<String?>(json['full']),
        getNum: asT<int?>(json['get_num']),
        id: asT<int?>(json['id']),
        name: asT<String?>(json['name']),
        price: asT<String?>(json['price']),
        residueNum: asT<int?>(json['residue_num']),
        startTime: asT<String?>(json['start_time']),
      );

  int? amount;
  int? createtime;
  String? endTime;
  String? explain;
  String? full;
  int? getNum;
  int? id;
  String? name;
  String? price;
  int? residueNum;
  String? startTime;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'amount': amount,
        'createtime': createtime,
        'end_time': endTime,
        'explain': explain,
        'full': full,
        'get_num': getNum,
        'id': id,
        'name': name,
        'price': price,
        'residue_num': residueNum,
        'start_time': startTime,
      };
}

class FieldItemModel {
  FieldItemModel({
    this.describe,
    this.id,
    this.image,
    this.title,
  });

  factory FieldItemModel.fromJson(Map<String, dynamic> json) => FieldItemModel(
        describe: asT<String?>(json['describe']),
        id: asT<int?>(json['id']),
        image: asT<String?>(json['image']),
        title: asT<String?>(json['title']),
      );

  String? describe;
  int? id;
  String? image;
  String? title;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'describe': describe,
        'id': id,
        'image': image,
        'title': title,
      };
}
