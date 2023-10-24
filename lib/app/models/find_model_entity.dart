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

class FindRootModel {
  FindRootModel({
    required this.code,
    this.data,
    required this.msg,
  });

  factory FindRootModel.fromJson(Map<String, dynamic> json) => FindRootModel(
        code: asT<String>(json['code'])!,
        data: json['data'] == null
            ? null
            : FindDataModel.fromJson(asT<Map<String, dynamic>>(json['data'])!),
        msg: asT<String>(json['msg'])!,
      );

  String code;
  FindDataModel? data;
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

class FindDataModel {
  FindDataModel({
    required this.advertisement,
    this.enjoy,
    required this.ifMessageShow,
    this.list,
    this.messageCount,
    this.picture,
    required this.totalPage,
  });

  factory FindDataModel.fromJson(Map<String, dynamic> json) {
    final List<BannerItemModel>? advertisement =
        json['advertisement'] is List ? <BannerItemModel>[] : null;
    if (advertisement != null) {
      for (final dynamic item in json['advertisement']!) {
        if (item != null) {
          tryCatch(() {
            advertisement.add(
                BannerItemModel.fromJson(asT<Map<String, dynamic>>(item)!));
          });
        }
      }
    }

    final List<FindItemModel>? list =
        json['list'] is List ? <FindItemModel>[] : null;
    if (list != null) {
      for (final dynamic item in json['list']!) {
        if (item != null) {
          tryCatch(() {
            list.add(FindItemModel.fromJson(asT<Map<String, dynamic>>(item)!));
          });
        }
      }
    }

    final List<ADItemModel>? picture =
        json['picture'] is List ? <ADItemModel>[] : null;
    if (picture != null) {
      for (final dynamic item in json['picture']!) {
        if (item != null) {
          tryCatch(() {
            picture.add(ADItemModel.fromJson(asT<Map<String, dynamic>>(item)!));
          });
        }
      }
    }
    return FindDataModel(
      advertisement: advertisement!,
      enjoy: json['enjoy'] == null
          ? null
          : ShareItemModel.fromJson(asT<Map<String, dynamic>>(json['enjoy'])!),
      ifMessageShow: asT<int>(json['if_message_show'])!,
      list: list,
      messageCount: asT<int?>(json['message_count']),
      picture: picture,
      totalPage: asT<int>(json['total_page'])!,
    );
  }

  List<BannerItemModel> advertisement;
  ShareItemModel? enjoy;
  int ifMessageShow;
  List<FindItemModel>? list;
  int? messageCount;
  List<ADItemModel>? picture;
  int totalPage;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'advertisement': advertisement,
        'enjoy': enjoy,
        'if_message_show': ifMessageShow,
        'list': list,
        'message_count': messageCount,
        'picture': picture,
        'total_page': totalPage,
      };
}

class ShareItemModel {
  ShareItemModel({
    this.content,
    this.enjoyUrl,
    this.image,
    this.title,
  });

  factory ShareItemModel.fromJson(Map<String, dynamic> json) => ShareItemModel(
        content: asT<String?>(json['content']),
        enjoyUrl: asT<String?>(json['enjoy_url']),
        image: asT<String?>(json['image']),
        title: asT<String?>(json['title']),
      );

  String? content;
  String? enjoyUrl;
  String? image;
  String? title;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'content': content,
        'enjoy_url': enjoyUrl,
        'image': image,
        'title': title,
      };
}

class ADItemModel {
  ADItemModel({
    this.areaIds,
    this.id,
    this.image,
  });

  factory ADItemModel.fromJson(Map<String, dynamic> json) => ADItemModel(
        areaIds: asT<String?>(json['area_ids']),
        id: asT<int?>(json['id']),
        image: asT<String?>(json['image']),
      );

  String? areaIds;
  int? id;
  String? image;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'area_ids': areaIds,
        'id': id,
        'image': image,
      };
}

class BannerItemModel {
  BannerItemModel({
    required this.id,
    required this.image,
  });

  factory BannerItemModel.fromJson(Map<String, dynamic> json) =>
      BannerItemModel(
        id: asT<int>(json['id'])!,
        image: asT<String>(json['image'])!,
      );

  int id;
  String image;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'image': image,
      };
}

class FindItemModel {
  FindItemModel({
    this.articleId,
    this.browse,
    this.collectNum,
    this.id,
    this.ifCollect,
    this.image,
    this.title,
    this.type,
    this.videoReturn,
  });

  factory FindItemModel.fromJson(Map<String, dynamic> json) => FindItemModel(
        articleId: asT<int?>(json['article_id']),
        browse: asT<String?>(json['browse']),
        collectNum: asT<int?>(json['collect_num']),
        id: asT<int?>(json['id']),
        ifCollect: asT<int?>(json['if_collect']),
        image: asT<String?>(json['image']),
        title: asT<String?>(json['title']),
        type: asT<int?>(json['type']),
        videoReturn: asT<String?>(json['video_return']),
      );

  int? articleId;
  String? browse;
  int? collectNum;
  int? id;
  int? ifCollect;
  String? image;
  String? title;
  int? type;
  String? videoReturn;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'article_id': articleId,
        'browse': browse,
        'collect_num': collectNum,
        'id': id,
        'if_collect': ifCollect,
        'image': image,
        'title': title,
        'type': type,
        'video_return': videoReturn,
      };
}
