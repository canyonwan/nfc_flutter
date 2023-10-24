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

class GoodsDetailRootModel {
  GoodsDetailRootModel({
    required this.code,
    this.data,
    required this.msg,
  });

  factory GoodsDetailRootModel.fromJson(Map<String, dynamic> json) =>
      GoodsDetailRootModel(
        code: asT<int>(json['code'])!,
        data: json['data'] == null
            ? null
            : GoodsDetailDataModel.fromJson(
                asT<Map<String, dynamic>>(json['data'])!),
        msg: asT<String>(json['msg'])!,
      );

  int code;
  GoodsDetailDataModel? data;
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

class GoodsDetailDataModel {
  GoodsDetailDataModel({
    this.appDiscountPrice,
    this.articleId,
    this.articleInfo,
    this.assured,
    this.assured1,
    this.assured2,
    this.assured3,
    this.assured4,
    this.bargainMin,
    this.bargainNum,
    this.commodityArrivals,
    this.commodityBrandId,
    this.commodityCategoryId,
    this.commodityReduction,
    this.commodityReductionPrice,
    this.content,
    this.createtime,
    this.endTime,
    this.evaluationNumber,
    this.exclusivePrice,
    this.freightFirst,
    this.freightSecond,
    this.goodsImage,
    this.goodsLike,
    this.goodsName,
    this.goodsNotLike,
    this.goodsPrice,
    this.goodsRemark,
    this.goodsStatus,
    this.goodsUnit,
    this.habitat,
    this.id,
    this.ifMessageShow,
    this.ifOriginArticle,
    this.inventory,
    this.isHot,
    this.isPresell,
    this.lastTime,
    this.mergename,
    this.messageCount,
    this.num,
    this.originalPrice,
    this.presellRuleUrl,
    this.presellStatus,
    this.presellTotalNum,
    this.presellType,
    this.provider,
    this.residueNum,
    this.salesVolume,
    this.secondaryImages,
    this.sellerId,
    this.shapeCode,
    this.shareurl,
    this.shopDiscountPrice,
    this.specification,
    this.weigh,
  });

  factory GoodsDetailDataModel.fromJson(Map<String, dynamic> json) {
    final List<VR360ItemModel>? assured = json['assured'] is List ? <VR360ItemModel>[] : null;
    if (assured != null) {
      for (final dynamic item in json['assured']!) {
        if (item != null) {
          tryCatch(() {
            assured
                .add(VR360ItemModel.fromJson(asT<Map<String, dynamic>>(item)!));
          });
        }
      }
    }

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
    return GoodsDetailDataModel(
      appDiscountPrice: asT<String?>(json['app_discount_price']),
      articleId: asT<int?>(json['article_id']),
      articleInfo: json['article_info'] == null
          ? null
          : FieldInfo.fromJson(
              asT<Map<String, dynamic>>(json['article_info'])!),
      assured: assured,
      assured1: asT<String?>(json['assured1']),
      assured2: asT<String?>(json['assured2']),
      assured3: asT<String?>(json['assured3']),
      assured4: asT<String?>(json['assured4']),
      bargainMin: asT<String?>(json['bargain_min']),
      bargainNum: asT<int?>(json['bargain_num']),
      commodityArrivals: asT<String?>(json['commodity_arrivals']),
      commodityBrandId: asT<int?>(json['commodity_brand_id']),
      commodityCategoryId: asT<int?>(json['commodity_category_id']),
      commodityReduction: asT<String?>(json['commodity_reduction']),
      commodityReductionPrice: asT<String?>(json['commodity_reduction_price']),
      content: asT<String?>(json['content']),
      createtime: asT<int?>(json['createtime']),
      endTime: asT<int?>(json['end_time']),
      evaluationNumber: asT<int?>(json['evaluation_number']),
      exclusivePrice: asT<String?>(json['exclusive_price']),
      freightFirst: asT<String?>(json['freight_first']),
      freightSecond: asT<int?>(json['freight_second']),
      goodsImage: asT<String?>(json['goods_image']),
      goodsLike: asT<int?>(json['goods_like']),
      goodsName: asT<String?>(json['goods_name']),
      goodsNotLike: asT<int?>(json['goods_not_like']),
      goodsPrice: asT<String?>(json['goods_price']),
      goodsRemark: asT<String?>(json['goods_remark']),
      goodsStatus: asT<int?>(json['goods_status']),
      goodsUnit: asT<String?>(json['goods_unit']),
      habitat: asT<String?>(json['habitat']),
      id: asT<int?>(json['id']),
      ifMessageShow: asT<int?>(json['if_message_show']),
      ifOriginArticle: asT<int?>(json['if_origin_article']),
      inventory: asT<String?>(json['inventory']),
      isHot: asT<int?>(json['is_hot']),
      isPresell: asT<int?>(json['is_presell']),
      lastTime: asT<int?>(json['last_time']),
      mergename: asT<String?>(json['mergename']),
      messageCount: asT<int?>(json['message_count']),
      num: asT<int?>(json['num']),
      originalPrice: asT<String?>(json['original_price']),
      presellRuleUrl: asT<String?>(json['presell_rule_url']),
      presellStatus: asT<int?>(json['presell_status']),
      presellTotalNum: asT<int?>(json['presell_total_num']),
      presellType: asT<int?>(json['presell_type']),
      provider: asT<String?>(json['provider']),
      residueNum: asT<int?>(json['residue_num']),
      salesVolume: asT<int?>(json['sales_volume']),
      secondaryImages: secondaryImages,
      sellerId: asT<int?>(json['seller_id']),
      shapeCode: asT<String?>(json['shape_code']),
      shareurl: asT<String?>(json['shareUrl']),
      shopDiscountPrice: asT<String?>(json['shop_discount_price']),
      specification: asT<String?>(json['specification']),
      weigh: asT<int?>(json['weigh']),
    );
  }

  String? appDiscountPrice;
  int? articleId;
  FieldInfo? articleInfo;
  List<VR360ItemModel>? assured;
  String? assured1;
  String? assured2;
  String? assured3;
  String? assured4;
  String? bargainMin;
  int? bargainNum;
  String? commodityArrivals;
  int? commodityBrandId;
  int? commodityCategoryId;
  String? commodityReduction;
  String? commodityReductionPrice;
  String? content;
  int? createtime;
  int? endTime;
  int? evaluationNumber;
  String? exclusivePrice;
  String? freightFirst;
  int? freightSecond;
  String? goodsImage;
  int? goodsLike;
  String? goodsName;
  int? goodsNotLike;
  String? goodsPrice;
  String? goodsRemark;
  int? goodsStatus;
  String? goodsUnit;
  String? habitat;
  int? id;
  int? ifMessageShow;
  int? ifOriginArticle;
  String? inventory;
  int? isHot;
  int? isPresell;
  int? lastTime;
  String? mergename;
  int? messageCount;
  int? num;
  String? originalPrice;
  String? presellRuleUrl;
  int? presellStatus;
  int? presellTotalNum;
  int? presellType;
  String? provider;
  int? residueNum;
  int? salesVolume;
  List<String>? secondaryImages;
  int? sellerId;
  String? shapeCode;
  String? shareurl;
  String? shopDiscountPrice;
  String? specification;
  int? weigh;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'app_discount_price': appDiscountPrice,
        'article_id': articleId,
        'article_info': articleInfo,
        'assured': assured,
        'assured1': assured1,
        'assured2': assured2,
        'assured3': assured3,
        'assured4': assured4,
        'bargain_min': bargainMin,
        'bargain_num': bargainNum,
        'commodity_arrivals': commodityArrivals,
        'commodity_brand_id': commodityBrandId,
        'commodity_category_id': commodityCategoryId,
        'commodity_reduction': commodityReduction,
        'commodity_reduction_price': commodityReductionPrice,
        'content': content,
        'createtime': createtime,
        'end_time': endTime,
        'evaluation_number': evaluationNumber,
        'exclusive_price': exclusivePrice,
        'freight_first': freightFirst,
        'freight_second': freightSecond,
        'goods_image': goodsImage,
        'goods_like': goodsLike,
        'goods_name': goodsName,
        'goods_not_like': goodsNotLike,
        'goods_price': goodsPrice,
        'goods_remark': goodsRemark,
        'goods_status': goodsStatus,
        'goods_unit': goodsUnit,
        'habitat': habitat,
        'id': id,
        'if_message_show': ifMessageShow,
        'if_origin_article': ifOriginArticle,
        'inventory': inventory,
        'is_hot': isHot,
        'is_presell': isPresell,
        'last_time': lastTime,
        'mergename': mergename,
        'message_count': messageCount,
        'num': num,
        'original_price': originalPrice,
        'presell_rule_url': presellRuleUrl,
        'presell_status': presellStatus,
        'presell_total_num': presellTotalNum,
        'presell_type': presellType,
        'provider': provider,
        'residue_num': residueNum,
        'sales_volume': salesVolume,
        'secondary_images': secondaryImages,
        'seller_id': sellerId,
        'shape_code': shapeCode,
        'shareUrl': shareurl,
        'shop_discount_price': shopDiscountPrice,
        'specification': specification,
        'weigh': weigh,
      };
}

class VR360ItemModel {
  VR360ItemModel({
    this.assuredImage,
    this.assuredTitle,
    this.enjoyUrl,
    this.id,
    this.url,
  });

  factory VR360ItemModel.fromJson(Map<String, dynamic> json) => VR360ItemModel(
        assuredImage: asT<String?>(json['assured_image']),
        assuredTitle: asT<String?>(json['assured_title']),
        enjoyUrl: asT<String?>(json['enjoy_url']),
        id: asT<int?>(json['id']),
        url: asT<String?>(json['url']),
      );

  String? assuredImage;
  String? assuredTitle;
  String? enjoyUrl;
  int? id;
  String? url;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'assured_image': assuredImage,
        'assured_title': assuredTitle,
        'enjoy_url': enjoyUrl,
        'id': id,
        'url': url,
      };
}

class FieldInfo {
  FieldInfo({
    this.describe,
    this.id,
    this.ifLike,
    this.image,
    this.link,
    this.liveAddress,
    this.newenjoyUrl,
    this.shareExplain,
    this.shareImage,
    this.shareTitle,
    this.title,
  });

  factory FieldInfo.fromJson(Map<String, dynamic> json) => FieldInfo(
        describe: asT<String?>(json['describe']),
        id: asT<int?>(json['id']),
        ifLike: asT<int?>(json['if_like']),
        image: asT<String?>(json['image']),
        link: asT<String?>(json['link']),
        liveAddress: asT<String?>(json['live_address']),
        newenjoyUrl: asT<String?>(json['newenjoy_url']),
        shareExplain: asT<String?>(json['share_explain']),
        shareImage: asT<String?>(json['share_image']),
        shareTitle: asT<String?>(json['share_title']),
        title: asT<String?>(json['title']),
      );

  String? describe;
  int? id;
  int? ifLike;
  String? image;
  String? link;
  String? liveAddress;
  String? newenjoyUrl;
  String? shareExplain;
  String? shareImage;
  String? shareTitle;
  String? title;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'describe': describe,
        'id': id,
        'if_like': ifLike,
        'image': image,
        'link': link,
        'live_address': liveAddress,
        'newenjoy_url': newenjoyUrl,
        'share_explain': shareExplain,
        'share_image': shareImage,
        'share_title': shareTitle,
        'title': title,
      };
}

// 商品详情里的食谱秀评列表
class CookbookEvaluateRootModel {
  const CookbookEvaluateRootModel({
    required this.msg,
    this.data,
    required this.code,
  });

  factory CookbookEvaluateRootModel.fromJson(Map<String, dynamic> json) =>
      CookbookEvaluateRootModel(
        msg: asT<String>(json['msg'])!,
        data: json['data'] == null
            ? null
            : CookbookEvaluateDataModel.fromJson(
                asT<Map<String, dynamic>>(json['data'])!),
        code: asT<int>(json['code'])!,
      );

  final String msg;
  final CookbookEvaluateDataModel? data;
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

class CookbookEvaluateDataModel {
  const CookbookEvaluateDataModel({
    this.totalPage,
    this.list,
  });

  factory CookbookEvaluateDataModel.fromJson(Map<String, dynamic> json) {
    final List<CookbookEvaluateItemModel>? list =
        json['list'] is List ? <CookbookEvaluateItemModel>[] : null;
    if (list != null) {
      for (final dynamic item in json['list']!) {
        if (item != null) {
          tryCatch(() {
            list.add(CookbookEvaluateItemModel.fromJson(
                asT<Map<String, dynamic>>(item)!));
          });
        }
      }
    }
    return CookbookEvaluateDataModel(
      totalPage: asT<int?>(json['total_page']),
      list: list,
    );
  }

  final int? totalPage;
  final List<CookbookEvaluateItemModel>? list;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'total_page': totalPage,
        'list': list,
      };
}

class CookbookEvaluateItemModel {
  const CookbookEvaluateItemModel({
    this.title,
    this.link,
    this.image,
    this.id,
    this.enjoyUrl,
    this.createtime,
  });

  factory CookbookEvaluateItemModel.fromJson(Map<String, dynamic> json) =>
      CookbookEvaluateItemModel(
        title: asT<String?>(json['title']),
        link: asT<String?>(json['link']),
        image: asT<String?>(json['image']),
        id: asT<int?>(json['id']),
        enjoyUrl: asT<String?>(json['enjoy_url']),
        createtime: asT<String?>(json['createtime']),
      );

  final String? title;
  final String? link;
  final String? image;
  final int? id;
  final String? enjoyUrl;
  final String? createtime;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'title': title,
        'link': link,
        'image': image,
        'id': id,
        'enjoy_url': enjoyUrl,
        'createtime': createtime,
      };
}

/// 商品评价列表
class GoodsCommentRootModel {
  const GoodsCommentRootModel({
    required this.msg,
    this.data,
    required this.code,
  });

  factory GoodsCommentRootModel.fromJson(Map<String, dynamic> json) =>
      GoodsCommentRootModel(
        msg: asT<String>(json['msg'])!,
        data: json['data'] == null
            ? null
            : GoodsCommentDataModel.fromJson(
                asT<Map<String, dynamic>>(json['data'])!),
        code: asT<int>(json['code'])!,
      );

  final String msg;
  final GoodsCommentDataModel? data;
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

class GoodsCommentDataModel {
  const GoodsCommentDataModel({
    this.maxpage,
    this.goodsComment,
  });

  factory GoodsCommentDataModel.fromJson(Map<String, dynamic> json) {
    final List<GoodsCommentItemModel>? goodsComment =
        json['goods_comment'] is List ? <GoodsCommentItemModel>[] : null;
    if (goodsComment != null) {
      for (final dynamic item in json['goods_comment']!) {
        if (item != null) {
          tryCatch(() {
            goodsComment.add(GoodsCommentItemModel.fromJson(
                asT<Map<String, dynamic>>(item)!));
          });
        }
      }
    }
    return GoodsCommentDataModel(
      maxpage: asT<int?>(json['maxPage']),
      goodsComment: goodsComment,
    );
  }

  final int? maxpage;
  final List<GoodsCommentItemModel>? goodsComment;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'maxPage': maxpage,
        'goods_comment': goodsComment,
      };
}

class GoodsCommentItemModel {
  const GoodsCommentItemModel({
    this.zhuipingList,
    this.type,
    this.orderId,
    this.memberName,
    this.memberImg,
    this.memberId,
    this.isCheck,
    this.isBy,
    this.id,
    this.hasZhuiping,
    this.grade,
    this.goodsId,
    this.evaiuateImg,
    this.createtime,
    this.contents,
  });

  factory GoodsCommentItemModel.fromJson(Map<String, dynamic> json) {
    final List<ZhuiPingItemModel>? zhuipingList =
        json['zhuiping_list'] is List ? <ZhuiPingItemModel>[] : null;
    if (zhuipingList != null) {
      for (final dynamic item in json['zhuiping_list']!) {
        if (item != null) {
          tryCatch(() {
            zhuipingList.add(
                ZhuiPingItemModel.fromJson(asT<Map<String, dynamic>>(item)!));
          });
        }
      }
    }

    final List<Object>? evaiuateImg =
        json['evaiuate_img'] is List ? <Object>[] : null;
    if (evaiuateImg != null) {
      for (final dynamic item in json['evaiuate_img']!) {
        if (item != null) {
          tryCatch(() {
            evaiuateImg.add(asT<Object>(item)!);
          });
        }
      }
    }
    return GoodsCommentItemModel(
      zhuipingList: zhuipingList,
      type: asT<int?>(json['type']),
      orderId: asT<Object?>(json['order_id']),
      memberName: asT<String?>(json['member_name']),
      memberImg: asT<String?>(json['member_img']),
      memberId: asT<int?>(json['member_id']),
      isCheck: asT<int?>(json['is_check']),
      isBy: asT<int?>(json['is_by']),
      id: asT<int?>(json['id']),
      hasZhuiping: asT<int?>(json['has_zhuiping']),
      grade: asT<int?>(json['grade']),
      goodsId: asT<int?>(json['goods_id']),
      evaiuateImg: evaiuateImg,
      createtime: asT<String?>(json['createtime']),
      contents: asT<String?>(json['contents']),
    );
  }

  final List<ZhuiPingItemModel>? zhuipingList;
  final int? type;
  final Object? orderId;
  final String? memberName;
  final String? memberImg;
  final int? memberId;
  final int? isCheck;
  final int? isBy;
  final int? id;
  final int? hasZhuiping;
  final int? grade;
  final int? goodsId;
  final List<Object>? evaiuateImg;
  final String? createtime;
  final String? contents;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'zhuiping_list': zhuipingList,
        'type': type,
        'order_id': orderId,
        'member_name': memberName,
        'member_img': memberImg,
        'member_id': memberId,
        'is_check': isCheck,
        'is_by': isBy,
        'id': id,
        'has_zhuiping': hasZhuiping,
        'grade': grade,
        'goods_id': goodsId,
        'evaiuate_img': evaiuateImg,
        'createtime': createtime,
        'contents': contents,
      };
}

class ZhuiPingItemModel {
  const ZhuiPingItemModel({
    this.type,
    this.orderId,
    this.memberName,
    this.memberImg,
    this.memberId,
    this.isCheck,
    this.isBy,
    this.id,
    this.hasZhuiping,
    this.grade,
    this.goodsId,
    this.evaiuateImg,
    this.createtime,
    this.contents,
  });

  factory ZhuiPingItemModel.fromJson(Map<String, dynamic> json) {
    final List<Object>? evaiuateImg =
        json['evaiuate_img'] is List ? <Object>[] : null;
    if (evaiuateImg != null) {
      for (final dynamic item in json['evaiuate_img']!) {
        if (item != null) {
          tryCatch(() {
            evaiuateImg.add(asT<Object>(item)!);
          });
        }
      }
    }
    return ZhuiPingItemModel(
      type: asT<int?>(json['type']),
      orderId: asT<Object?>(json['order_id']),
      memberName: asT<String?>(json['member_name']),
      memberImg: asT<String?>(json['member_img']),
      memberId: asT<int?>(json['member_id']),
      isCheck: asT<int?>(json['is_check']),
      isBy: asT<int?>(json['is_by']),
      id: asT<int?>(json['id']),
      hasZhuiping: asT<int?>(json['has_zhuiping']),
      grade: asT<int?>(json['grade']),
      goodsId: asT<int?>(json['goods_id']),
      evaiuateImg: evaiuateImg,
      createtime: asT<String?>(json['createtime']),
      contents: asT<String?>(json['contents']),
    );
  }

  final int? type;
  final Object? orderId;
  final String? memberName;
  final String? memberImg;
  final int? memberId;
  final int? isCheck;
  final int? isBy;
  final int? id;
  final int? hasZhuiping;
  final int? grade;
  final int? goodsId;
  final List<Object>? evaiuateImg;
  final String? createtime;
  final String? contents;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'type': type,
        'order_id': orderId,
        'member_name': memberName,
        'member_img': memberImg,
        'member_id': memberId,
        'is_check': isCheck,
        'is_by': isBy,
        'id': id,
        'has_zhuiping': hasZhuiping,
        'grade': grade,
        'goods_id': goodsId,
        'evaiuate_img': evaiuateImg,
        'createtime': createtime,
        'contents': contents,
      };
}
