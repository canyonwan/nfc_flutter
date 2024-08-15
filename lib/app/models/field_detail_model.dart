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

class FieldDetailRootModel {
  FieldDetailRootModel({
    this.msg,
    this.data,
    this.code,
  });

  factory FieldDetailRootModel.fromJson(Map<String, dynamic> jsonRes) =>
      FieldDetailRootModel(
        msg: asT<String?>(jsonRes['msg']),
        data: jsonRes['data'] == null
            ? null
            : FieldDetailDataModel.fromJson(
                asT<Map<String, dynamic>>(jsonRes['data'])!),
        code: asT<int?>(jsonRes['code']),
      );

  String? msg;
  FieldDetailDataModel? data;
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

class FieldDetailDataModel {
  FieldDetailDataModel({
    this.weather,
    this.videoImage,
    this.videoFile,
    this.totalPage,
    this.title,
    this.shareTitle,
    this.shareUrl,
    this.shareImage,
    this.shareExplain,
    this.recordList,
    this.orderInfo,
    this.messageCount,
    this.ifRecord,
    this.ifProduct,
    this.ifMessageShow,
    this.ifLike,
    this.ifInfo,
    this.ifDecision,
    this.ifContent,
    this.goodsList,
    this.enjoySet,
    this.decisionList,
    this.counselorInfo,
    this.content,
    this.claimList,
    this.chippedList,
    this.part1,
    this.part2,
    this.part3,
    this.part4,
    this.part1Num,
    this.part2Num,
  });

  factory FieldDetailDataModel.fromJson(Map<String, dynamic> jsonRes) {
    final List<LiveActionItemModel>? recordList =
        jsonRes['record_list'] is List ? <LiveActionItemModel>[] : null;
    if (recordList != null) {
      for (final dynamic item in jsonRes['record_list']!) {
        if (item != null) {
          tryCatch(() {
            recordList.add(
                LiveActionItemModel.fromJson(asT<Map<String, dynamic>>(item)!));
          });
        }
      }
    }

    final List<GoodsItemModel>? goodsList =
        jsonRes['goods_list'] is List ? <GoodsItemModel>[] : null;
    if (goodsList != null) {
      for (final dynamic item in jsonRes['goods_list']!) {
        if (item != null) {
          tryCatch(() {
            goodsList
                .add(GoodsItemModel.fromJson(asT<Map<String, dynamic>>(item)!));
          });
        }
      }
    }

    final List<Object>? enjoySet =
        jsonRes['enjoy_set'] is List ? <Object>[] : null;
    if (enjoySet != null) {
      for (final dynamic item in jsonRes['enjoy_set']!) {
        if (item != null) {
          tryCatch(() {
            enjoySet.add(asT<Object>(item)!);
          });
        }
      }
    }

    final List<DecisionItemModel>? decisionList =
        jsonRes['decision_list'] is List ? <DecisionItemModel>[] : null;
    if (decisionList != null) {
      for (final dynamic item in jsonRes['decision_list']!) {
        if (item != null) {
          tryCatch(() {
            decisionList.add(
                DecisionItemModel.fromJson(asT<Map<String, dynamic>>(item)!));
          });
        }
      }
    }

    final List<ClaimItemModel>? claimList =
        jsonRes['claim_list'] is List ? <ClaimItemModel>[] : null;
    if (claimList != null) {
      for (final dynamic item in jsonRes['claim_list']!) {
        if (item != null) {
          tryCatch(() {
            claimList
                .add(ClaimItemModel.fromJson(asT<Map<String, dynamic>>(item)!));
          });
        }
      }
    }

    final List<ChippedItemModel>? chippedList =
        jsonRes['chipped_list'] is List ? <ChippedItemModel>[] : null;
    if (chippedList != null) {
      for (final dynamic item in jsonRes['chipped_list']!) {
        if (item != null) {
          tryCatch(() {
            chippedList.add(
                ChippedItemModel.fromJson(asT<Map<String, dynamic>>(item)!));
          });
        }
      }
    }
    return FieldDetailDataModel(
      weather: jsonRes['weather'] == null
          ? null
          : WeatherModel.fromJson(
              asT<Map<String, dynamic>>(jsonRes['weather'])!),
      videoImage: asT<String?>(jsonRes['video_image']),
      videoFile: asT<String?>(jsonRes['video_file']),
      totalPage: asT<int?>(jsonRes['total_page']),
      title: asT<String?>(jsonRes['title']),
      shareTitle: asT<String?>(jsonRes['share_title']),
      shareUrl: asT<String?>(jsonRes['shareUrl']),
      shareImage: asT<String?>(jsonRes['share_image']),
      shareExplain: asT<String?>(jsonRes['share_explain']),
      recordList: recordList,
      orderInfo: jsonRes['order_info'] == null
          ? null
          : OrderInfoItemModel.fromJson(
              asT<Map<String, dynamic>>(jsonRes['order_info'])!),
      messageCount: asT<int?>(jsonRes['message_count']),
      ifRecord: asT<int?>(jsonRes['if_record']),
      ifProduct: asT<int?>(jsonRes['if_product']),
      ifMessageShow: asT<int?>(jsonRes['if_message_show']),
      ifLike: asT<int?>(jsonRes['if_like']),
      ifInfo: asT<int?>(jsonRes['if_info']),
      ifDecision: asT<int?>(jsonRes['if_decision']),
      ifContent: asT<int?>(jsonRes['if_content']),
      goodsList: goodsList,
      enjoySet: enjoySet,
      decisionList: decisionList,
      counselorInfo: jsonRes['counselor_info'] == null
          ? null
          : TechnicalAdvisorModel.fromJson(
              asT<Map<String, dynamic>>(jsonRes['counselor_info'])!),
      content: asT<String?>(jsonRes['content']),
      claimList: claimList,
      chippedList: chippedList,
      part1: asT<String?>(jsonRes['part1']),
      part2: asT<String?>(jsonRes['part2']),
      part3: asT<String?>(jsonRes['part3']),
      part4: asT<String?>(jsonRes['part4']),
      part1Num: asT<int?>(jsonRes['part1_num']),
      part2Num: asT<int?>(jsonRes['part2_num']),
    );
  }

  WeatherModel? weather;
  String? videoImage;
  String? videoFile;
  int? totalPage;
  String? title;
  String? shareTitle;
  String? shareUrl;
  String? shareImage;
  String? shareExplain;
  List<LiveActionItemModel>? recordList;
  OrderInfoItemModel? orderInfo;
  int? messageCount;
  int? ifRecord;
  int? ifProduct;
  int? ifMessageShow;
  int? ifLike;
  int? ifInfo;
  int? ifDecision;
  int? ifContent;
  List<GoodsItemModel>? goodsList;
  List<Object>? enjoySet;
  List<DecisionItemModel>? decisionList;
  TechnicalAdvisorModel? counselorInfo;
  String? content;
  List<ClaimItemModel>? claimList;
  List<ChippedItemModel>? chippedList;

  String? part1;
  String? part2;
  String? part3;
  String? part4;
  int? part1Num;
  int? part2Num;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'weather': weather,
        'video_image': videoImage,
        'video_file': videoFile,
        'total_page': totalPage,
        'title': title,
        'share_title': shareTitle,
        'shareUrl': shareUrl,
        'share_image': shareImage,
        'share_explain': shareExplain,
        'record_list': recordList,
        'order_info': orderInfo,
        'message_count': messageCount,
        'if_record': ifRecord,
        'if_product': ifProduct,
        'if_message_show': ifMessageShow,
        'if_like': ifLike,
        'if_info': ifInfo,
        'if_decision': ifDecision,
        'if_content': ifContent,
        'goods_list': goodsList,
        'enjoy_set': enjoySet,
        'decision_list': decisionList,
        'counselor_info': counselorInfo,
        'content': content,
        'claim_list': claimList,
        'chipped_list': chippedList,
        'part1': part1,
        'part2': part2,
        'part3': part3,
        'part4': part4,
        'part1_num': part1Num,
        'part2_num': part2Num,
      };
}

class WeatherModel {
  WeatherModel({
    this.windSpeed,
    this.windScale,
    this.windDir,
    this.wind360,
    this.vis,
    this.text,
    this.temp,
    this.pressure,
    this.precip,
    this.obsTime,
    this.iconImg,
    this.icon,
    this.humidity,
    this.feelsLike,
    this.dew,
    this.cloud,
    this.backImage,
    this.air,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> jsonRes) => WeatherModel(
        windSpeed: asT<String?>(jsonRes['windSpeed']),
        windScale: asT<String?>(jsonRes['windScale']),
        windDir: asT<String?>(jsonRes['windDir']),
        wind360: asT<String?>(jsonRes['wind360']),
        vis: asT<String?>(jsonRes['vis']),
        text: asT<String?>(jsonRes['text']),
        temp: asT<String?>(jsonRes['temp']),
        pressure: asT<String?>(jsonRes['pressure']),
        precip: asT<String?>(jsonRes['precip']),
        obsTime: asT<String?>(jsonRes['obsTime']),
        iconImg: asT<String?>(jsonRes['icon_img']),
        icon: asT<String?>(jsonRes['icon']),
        humidity: asT<String?>(jsonRes['humidity']),
        feelsLike: asT<String?>(jsonRes['feelsLike']),
        dew: asT<String?>(jsonRes['dew']),
        cloud: asT<String?>(jsonRes['cloud']),
        backImage: asT<String?>(jsonRes['back_image']),
        air: asT<String?>(jsonRes['air']),
      );

  String? windSpeed;
  String? windScale;
  String? windDir;
  String? wind360;
  String? vis;
  String? text;
  String? temp;
  String? pressure;
  String? precip;
  String? obsTime;
  String? iconImg;
  String? icon;
  String? humidity;
  String? feelsLike;
  String? dew;
  String? cloud;
  String? backImage;
  String? air;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'windSpeed': windSpeed,
        'windScale': windScale,
        'windDir': windDir,
        'wind360': wind360,
        'vis': vis,
        'text': text,
        'temp': temp,
        'pressure': pressure,
        'precip': precip,
        'obsTime': obsTime,
        'icon_img': iconImg,
        'icon': icon,
        'humidity': humidity,
        'feelsLike': feelsLike,
        'dew': dew,
        'cloud': cloud,
        'back_image': backImage,
        'air': air,
      };
}

class LiveActionItemModel {
  LiveActionItemModel({
    this.width,
    this.videoReturn,
    this.videoImage,
    this.videoFile,
    this.type,
    this.title,
    this.images,
    this.id,
    this.height,
    this.createtime,
    this.content,
    this.articleId,
    this.ifControl,
  });

  factory LiveActionItemModel.fromJson(Map<String, dynamic> jsonRes) {
    final List<String>? images = jsonRes['images'] is List ? <String>[] : null;
    if (images != null) {
      for (final dynamic item in jsonRes['images']!) {
        if (item != null) {
          tryCatch(() {
            images.add(asT<String>(item)!);
          });
        }
      }
    }
    return LiveActionItemModel(
      width: asT<String?>(jsonRes['width']),
      videoReturn: asT<String?>(jsonRes['video_return']),
      videoImage: asT<String?>(jsonRes['video_image']),
      videoFile: asT<String?>(jsonRes['video_file']),
      type: asT<int?>(jsonRes['type']),
      title: asT<String?>(jsonRes['title']),
      images: images,
      id: asT<int?>(jsonRes['id']),
      height: asT<String?>(jsonRes['height']),
      createtime: asT<String?>(jsonRes['createtime']),
      content: asT<String?>(jsonRes['content']),
      articleId: asT<String?>(jsonRes['article_id']),
      ifControl: asT<int?>(jsonRes['if_control']),
    );
  }

  String? width;
  String? videoReturn;
  String? videoImage;
  String? videoFile;
  int? type;
  String? title;
  List<String>? images;
  int? id;
  String? height;
  String? createtime;
  String? content;
  String? articleId;
  int? ifControl;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'width': width,
        'video_return': videoReturn,
        'video_image': videoImage,
        'video_file': videoFile,
        'type': type,
        'title': title,
        'images': images,
        'id': id,
        'height': height,
        'createtime': createtime,
        'content': content,
        'article_id': articleId,
        'if_control': ifControl,
      };
}

class ChippedItemModel {
  ChippedItemModel({
    this.salesVolume,
    this.originalPrice,
    this.lastTime,
    this.id,
    this.goodsPrice,
    this.goodsName,
    this.goodsImage,
    this.exclusivePrice,
    this.evaluationNumber,
    this.countDown,
    this.chippedNum,
  });

  factory ChippedItemModel.fromJson(Map<String, dynamic> jsonRes) =>
      ChippedItemModel(
        salesVolume: asT<int?>(jsonRes['sales_volume']),
        originalPrice: asT<String?>(jsonRes['original_price']),
        lastTime: asT<int?>(jsonRes['last_time']),
        id: asT<int?>(jsonRes['id']),
        goodsPrice: asT<String?>(jsonRes['goods_price']),
        goodsName: asT<String?>(jsonRes['goods_name']),
        goodsImage: asT<String?>(jsonRes['goods_image']),
        exclusivePrice: asT<String?>(jsonRes['exclusive_price']),
        evaluationNumber: asT<int?>(jsonRes['evaluation_number']),
        countDown: asT<String?>(jsonRes['count_down']),
        chippedNum: asT<int?>(jsonRes['chipped_num']),
      );

  int? salesVolume;
  String? originalPrice;
  int? lastTime;
  int? id;
  String? goodsPrice;
  String? goodsName;
  String? goodsImage;
  String? exclusivePrice;
  int? evaluationNumber;
  String? countDown;
  int? chippedNum;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'sales_volume': salesVolume,
        'original_price': originalPrice,
        'last_time': lastTime,
        'id': id,
        'goods_price': goodsPrice,
        'goods_name': goodsName,
        'goods_image': goodsImage,
        'exclusive_price': exclusivePrice,
        'evaluation_number': evaluationNumber,
        'count_down': countDown,
        'chipped_num': chippedNum,
      };
}

class GoodsItemModel {
  GoodsItemModel({
    this.salesVolume,
    this.originalPrice,
    this.ifSellOut,
    this.id,
    this.goodsPrice,
    this.goodsName,
    this.goodsImage,
    this.exclusivePrice,
    this.evaluationNumber,
  });

  factory GoodsItemModel.fromJson(Map<String, dynamic> jsonRes) =>
      GoodsItemModel(
        salesVolume: asT<int?>(jsonRes['sales_volume']),
        originalPrice: asT<String?>(jsonRes['original_price']),
        ifSellOut: asT<int?>(jsonRes['if_sell_out']),
        id: asT<int?>(jsonRes['id']),
        goodsPrice: asT<String?>(jsonRes['goods_price']),
        goodsName: asT<String?>(jsonRes['goods_name']),
        goodsImage: asT<String?>(jsonRes['goods_image']),
        exclusivePrice: asT<String?>(jsonRes['exclusive_price']),
        evaluationNumber: asT<int?>(jsonRes['evaluation_number']),
      );

  int? salesVolume;
  String? originalPrice;
  int? ifSellOut;
  int? id;
  String? goodsPrice;
  String? goodsName;
  String? goodsImage;
  String? exclusivePrice;
  int? evaluationNumber;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'sales_volume': salesVolume,
        'original_price': originalPrice,
        'if_sell_out': ifSellOut,
        'id': id,
        'goods_price': goodsPrice,
        'goods_name': goodsName,
        'goods_image': goodsImage,
        'exclusive_price': exclusivePrice,
        'evaluation_number': evaluationNumber,
      };
}

class ClaimItemModel {
  ClaimItemModel({
    this.units,
    this.reapTime,
    this.price,
    this.name,
    this.id,
    this.exclusivePrice,
    this.describe,
  });

  factory ClaimItemModel.fromJson(Map<String, dynamic> jsonRes) =>
      ClaimItemModel(
        units: asT<String?>(jsonRes['units']),
        reapTime: asT<String?>(jsonRes['reap_time']),
        price: asT<String?>(jsonRes['price']),
        name: asT<String?>(jsonRes['name']),
        id: asT<int?>(jsonRes['id']),
        exclusivePrice: asT<String?>(jsonRes['exclusive_price']),
        describe: asT<String?>(jsonRes['describe']),
      );

  String? units;
  String? reapTime;
  String? price;
  String? name;
  int? id;
  String? exclusivePrice;
  String? describe;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'units': units,
        'reap_time': reapTime,
        'price': price,
        'name': name,
        'id': id,
        'exclusive_price': exclusivePrice,
        'describe': describe,
      };
}

class DecisionItemModel {
  DecisionItemModel({
    this.totalPrice,
    this.time,
    this.ifGranary,
    this.statusName,
    this.status,
    this.optionList,
    this.memberChoose,
    this.item,
    this.image,
    this.voucher,
    this.id,
    this.countdown,
    this.content,
    this.ifContent,
    this.ifImage,
    this.ifCheck,
    this.optionPrice,
    this.decesionGoods,
  });

  factory DecisionItemModel.fromJson(Map<String, dynamic> jsonRes) {
    final List<DecesionGoodsItem>? decesionGoods =
        jsonRes['decesion_goods'] is List ? <DecesionGoodsItem>[] : null;
    if (decesionGoods != null) {
      for (final dynamic item in jsonRes['decesion_goods']!) {
        if (item != null) {
          decesionGoods.add(
              DecesionGoodsItem.fromJson(asT<Map<String, dynamic>>(item)!));
        }
      }
    }
    final List<OptionItemModel>? optionList =
        jsonRes['option_list'] is List ? <OptionItemModel>[] : null;
    if (optionList != null) {
      for (final dynamic item in jsonRes['option_list']!) {
        if (item != null) {
          tryCatch(() {
            optionList.add(
                OptionItemModel.fromJson(asT<Map<String, dynamic>>(item)!));
          });
        }
      }
    }
    return DecisionItemModel(
      totalPrice: asT<String?>(jsonRes['total_price']),
      time: asT<String?>(jsonRes['time']),
      statusName: asT<String?>(jsonRes['status_name']),
      status: asT<int?>(jsonRes['status']),
      ifContent: asT<int?>(jsonRes['ifContent']),
      ifImage: asT<int?>(jsonRes['ifImage']),
      ifCheck: asT<int?>(jsonRes['ifCheck']),
      optionList: optionList,
      decesionGoods: decesionGoods!,
      memberChoose: asT<int?>(jsonRes['member_choose']),
      ifGranary: asT<int?>(jsonRes['if_granary']),
      item: asT<String?>(jsonRes['item']),
      image: asT<String?>(jsonRes['image']),
      optionPrice: asT<String?>(jsonRes['optionPrice']),
      id: asT<int?>(jsonRes['id']),
      countdown: asT<String?>(jsonRes['countdown']),
      content: asT<String?>(jsonRes['content']),
      voucher: jsonRes['voucher'] == null
          ? null
          : VoucherItem.fromJson(
              asT<Map<String, dynamic>>(jsonRes['voucher'])!),
    );
  }

  String? totalPrice;
  String? time;
  String? statusName;
  int? status;
  List<OptionItemModel>? optionList;
  List<DecesionGoodsItem>? decesionGoods;
  int? memberChoose;
  String? item;
  String? image;
  int? id;
  String? countdown;
  String? content;
  int? ifContent;
  int? ifImage;
  int? ifCheck;
  String? optionPrice;
  int? ifGranary;
  VoucherItem? voucher;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'total_price': totalPrice,
        'time': time,
        'status_name': statusName,
        'status': status,
        'option_list': optionList,
        'member_choose': memberChoose,
        'item': item,
        'image': image,
        'id': id,
        'countdown': countdown,
        'content': content,
        'if_granary': ifGranary,
        'voucher': voucher,
      };
}

class VoucherItem {
  VoucherItem({
    this.id,
    this.name,
    this.explain,
    this.full,
    this.price,
    this.amount,
    this.residueNum,
    this.getNum,
    this.startTime,
    this.endTime,
    this.createtime,
  });

  factory VoucherItem.fromJson(Map<String, dynamic> json) => VoucherItem(
        id: asT<int?>(json['id']),
        name: asT<String?>(json['name']),
        explain: asT<String?>(json['explain']),
        full: asT<String?>(json['full']),
        price: asT<String?>(json['price']),
        amount: asT<int?>(json['amount']),
        residueNum: asT<int?>(json['residue_num']),
        getNum: asT<int?>(json['get_num']),
        startTime: asT<String?>(json['start_time']),
        endTime: asT<String?>(json['end_time']),
        createtime: asT<int?>(json['createtime']),
      );

  int? id;
  String? name;
  String? explain;
  String? full;
  String? price;
  int? amount;
  int? residueNum;
  int? getNum;
  String? startTime;
  String? endTime;
  int? createtime;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'name': name,
        'explain': explain,
        'full': full,
        'price': price,
        'amount': amount,
        'residue_num': residueNum,
        'get_num': getNum,
        'start_time': startTime,
        'end_time': endTime,
        'createtime': createtime,
      };
}

class DecesionGoodsItem {
  DecesionGoodsItem({
    required this.evaluationNumber,
    required this.exclusivePrice,
    required this.goodsImage,
    required this.goodsName,
    required this.goodsPrice,
    required this.id,
    required this.salesVolume,
  });

  factory DecesionGoodsItem.fromJson(Map<String, dynamic> json) =>
      DecesionGoodsItem(
        evaluationNumber: asT<int>(json['evaluation_number'])!,
        exclusivePrice: asT<String>(json['exclusive_price'])!,
        goodsImage: asT<String>(json['goods_image'])!,
        goodsName: asT<String>(json['goods_name'])!,
        goodsPrice: asT<String>(json['goods_price'])!,
        id: asT<int>(json['id'])!,
        salesVolume: asT<int>(json['sales_volume'])!,
      );

  int evaluationNumber;
  String exclusivePrice;
  String goodsImage;
  String goodsName;
  String goodsPrice;
  int id;
  int salesVolume;

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
        'sales_volume': salesVolume,
      };
}

class OptionItemModel {
  OptionItemModel({
    this.price,
    this.name,
    this.ifImage,
    this.ifContent,
    this.ifCheck,
    this.id,
  });

  factory OptionItemModel.fromJson(Map<String, dynamic> jsonRes) =>
      OptionItemModel(
        price: asT<String?>(jsonRes['price']),
        name: asT<String?>(jsonRes['name']),
        ifImage: asT<int?>(jsonRes['if_image']),
        ifContent: asT<int?>(jsonRes['if_content']),
        ifCheck: asT<int?>(jsonRes['if_check']),
        id: asT<int?>(jsonRes['id']),
      );

  String? price;
  String? name;
  int? ifImage;
  int? ifContent;
  int? ifCheck;
  int? id;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'price': price,
        'name': name,
        'if_image': ifImage,
        'if_content': ifContent,
        'if_check': ifCheck,
        'id': id,
      };
}

class OrderInfoItemModel {
  OrderInfoItemModel({
    this.units,
    this.totalPrice,
    this.serialNumber,
    this.reapTime,
    this.parentArticle,
    this.num,
    this.createtime,
    this.claimName,
  });

  factory OrderInfoItemModel.fromJson(Map<String, dynamic> jsonRes) =>
      OrderInfoItemModel(
        units: asT<String?>(jsonRes['units']),
        totalPrice: asT<String?>(jsonRes['total_price']),
        serialNumber: asT<String?>(jsonRes['serial_number']),
        reapTime: asT<String?>(jsonRes['reap_time']),
        parentArticle: asT<String?>(jsonRes['parent_article']),
        num: asT<int?>(jsonRes['num']),
        createtime: asT<String?>(jsonRes['createtime']),
        claimName: asT<String?>(jsonRes['claim_name']),
      );

  String? units;
  String? totalPrice;
  String? serialNumber;
  String? reapTime;
  String? parentArticle;
  int? num;
  String? createtime;
  String? claimName;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'units': units,
        'total_price': totalPrice,
        'serial_number': serialNumber,
        'reap_time': reapTime,
        'parent_article': parentArticle,
        'num': num,
        'createtime': createtime,
        'claim_name': claimName,
      };
}

class TechnicalAdvisorModel {
  TechnicalAdvisorModel({
    this.name,
    this.introduce,
    this.image,
    this.serviceUrl,
    this.phone,
  });

  factory TechnicalAdvisorModel.fromJson(Map<String, dynamic> jsonRes) =>
      TechnicalAdvisorModel(
        name: asT<String?>(jsonRes['name']),
        introduce: asT<String?>(jsonRes['introduce']),
        image: asT<String?>(jsonRes['image']),
        serviceUrl: asT<String?>(jsonRes['service_url']),
        phone: asT<String?>(jsonRes['phone']),
      );

  String? name;
  String? introduce;
  String? image;
  String? serviceUrl;
  String? phone;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'name': name,
        'introduce': introduce,
        'image': image,
        'service_url': serviceUrl,
        'phone': phone,
      };
}

/// 认领田地详情
class ClaimFieldRootModel {
  ClaimFieldRootModel({
    this.msg,
    this.data,
    this.code,
  });

  factory ClaimFieldRootModel.fromJson(Map<String, dynamic> jsonRes) =>
      ClaimFieldRootModel(
        msg: asT<String?>(jsonRes['msg']),
        data: jsonRes['data'] == null
            ? null
            : ClaimFieldDataModel.fromJson(
                asT<Map<String, dynamic>>(jsonRes['data'])!),
        code: asT<int?>(jsonRes['code']),
      );

  String? msg;
  ClaimFieldDataModel? data;
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

class ClaimFieldDataModel {
  ClaimFieldDataModel({
    this.units,
    this.totalPrice,
    this.reapTime,
    this.price,
    this.name,
    this.id,
    this.describe,
    this.content,
  });

  factory ClaimFieldDataModel.fromJson(Map<String, dynamic> jsonRes) =>
      ClaimFieldDataModel(
        units: asT<String?>(jsonRes['units']),
        totalPrice: asT<double?>(jsonRes['total_price']),
        reapTime: asT<String?>(jsonRes['reap_time']),
        price: asT<String?>(jsonRes['price']),
        name: asT<String?>(jsonRes['name']),
        id: asT<int?>(jsonRes['id']),
        describe: asT<String?>(jsonRes['describe']),
        content: asT<String?>(jsonRes['content']),
      );

  String? units;
  double? totalPrice;
  String? reapTime;
  String? price;
  String? name;
  int? id;
  String? describe;
  String? content;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'units': units,
        'total_price': totalPrice,
        'reap_time': reapTime,
        'price': price,
        'name': name,
        'id': id,
        'describe': describe,
        'content': content,
      };
}

/// 认领协议
class ClaimAgreementRootModel {
  ClaimAgreementRootModel({
    this.msg,
    this.data,
    this.code,
  });

  factory ClaimAgreementRootModel.fromJson(Map<String, dynamic> jsonRes) =>
      ClaimAgreementRootModel(
        msg: asT<String?>(jsonRes['msg']),
        data: jsonRes['data'] == null
            ? null
            : ClaimAgreementDataModel.fromJson(
                asT<Map<String, dynamic>>(jsonRes['data'])!),
        code: asT<int?>(jsonRes['code']),
      );

  String? msg;
  ClaimAgreementDataModel? data;
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

class ClaimAgreementDataModel {
  ClaimAgreementDataModel({
    this.title,
    this.id,
    this.content,
  });

  factory ClaimAgreementDataModel.fromJson(Map<String, dynamic> jsonRes) =>
      ClaimAgreementDataModel(
        title: asT<String?>(jsonRes['title']),
        id: asT<int?>(jsonRes['id']),
        content: asT<String?>(jsonRes['content']),
      );

  String? title;
  int? id;
  String? content;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'title': title,
        'id': id,
        'content': content,
      };
}

/// 提交决策

class SubmitDecisionRootModel {
  SubmitDecisionRootModel({
    this.msg,
    this.data,
    this.code,
  });

  factory SubmitDecisionRootModel.fromJson(Map<String, dynamic> jsonRes) =>
      SubmitDecisionRootModel(
        msg: asT<String?>(jsonRes['msg']),
        data: jsonRes['data'] == null
            ? null
            : SubmitDecisionDataModel.fromJson(
                asT<Map<String, dynamic>>(jsonRes['data'])!),
        code: asT<int?>(jsonRes['code']),
      );

  String? msg;
  SubmitDecisionDataModel? data;
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

class SubmitDecisionDataModel {
  SubmitDecisionDataModel({
    this.totalPrice,
    this.orderSn,
    this.ifPay,
  });

  factory SubmitDecisionDataModel.fromJson(Map<String, dynamic> jsonRes) =>
      SubmitDecisionDataModel(
        totalPrice: asT<String?>(jsonRes['total_price']),
        orderSn: asT<String?>(jsonRes['order_sn']),
        ifPay: asT<int?>(jsonRes['if_pay']),
      );

  String? totalPrice;
  String? orderSn;
  int? ifPay;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'total_price': totalPrice,
        'order_sn': orderSn,
        'if_pay': ifPay,
      };
}
