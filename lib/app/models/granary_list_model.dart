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

class GranaryListRootModel {
  GranaryListRootModel({
    this.msg,
    this.data,
    this.code,
  });

  factory GranaryListRootModel.fromJson(Map<String, dynamic> jsonRes) =>
      GranaryListRootModel(
        msg: asT<String?>(jsonRes['msg']),
        data: jsonRes['data'] == null
            ? null
            : GranaryListDataModel.fromJson(
                asT<Map<String, dynamic>>(jsonRes['data'])!),
        code: asT<int?>(jsonRes['code']),
      );

  String? msg;
  GranaryListDataModel? data;
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

class GranaryListDataModel {
  GranaryListDataModel({
    this.totalPage,
    this.image,
    this.granaryList,
    this.articleTitle,
    this.articleList,
    this.articleId,
  });

  factory GranaryListDataModel.fromJson(Map<String, dynamic> jsonRes) {
    final List<GranaryItemModel>? granaryList =
        jsonRes['granary_list'] is List ? <GranaryItemModel>[] : null;
    if (granaryList != null) {
      for (final dynamic item in jsonRes['granary_list']!) {
        if (item != null) {
          tryCatch(() {
            granaryList.add(
                GranaryItemModel.fromJson(asT<Map<String, dynamic>>(item)!));
          });
        }
      }
    }

    final List<ArticleList>? articleList =
        jsonRes['article_list'] is List ? <ArticleList>[] : null;
    if (articleList != null) {
      for (final dynamic item in jsonRes['article_list']!) {
        if (item != null) {
          tryCatch(() {
            articleList
                .add(ArticleList.fromJson(asT<Map<String, dynamic>>(item)!));
          });
        }
      }
    }
    return GranaryListDataModel(
      totalPage: asT<int?>(jsonRes['total_page']),
      image: asT<String?>(jsonRes['image']),
      granaryList: granaryList,
      articleTitle: asT<String?>(jsonRes['article_title']),
      articleList: articleList,
      articleId: asT<String?>(jsonRes['article_id']),
    );
  }

  int? totalPage;
  String? image;
  List<GranaryItemModel>? granaryList;
  String? articleTitle;
  List<ArticleList>? articleList;
  String? articleId;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'total_page': totalPage,
        'image': image,
        'granary_list': granaryList,
        'article_title': articleTitle,
        'article_list': articleList,
        'article_id': articleId,
      };
}

class ArticleList {
  ArticleList({
    this.articleTitle,
    this.articleId,
    this.ifShow,
  });

  factory ArticleList.fromJson(Map<String, dynamic> jsonRes) => ArticleList(
        articleTitle: asT<String?>(jsonRes['article_title']),
        articleId: asT<int?>(jsonRes['article_id']),
        ifShow: asT<int?>(jsonRes['if_show']),
      );

  String? articleTitle;
  int? articleId;
  int? ifShow;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'article_title': articleTitle,
        'article_id': articleId,
        'if_show': ifShow,
      };
}

class GranaryItemModel {
  GranaryItemModel({
    this.units,
    this.totalNum,
    this.residueNum,
    this.recyclePrice,
    this.name,
    this.image,
    this.ifRecycle,
    this.ifProcess,
    this.ifExpire,
    this.id,
    this.expireTime,
    this.createtime,
  });

  factory GranaryItemModel.fromJson(Map<String, dynamic> jsonRes) =>
      GranaryItemModel(
        units: asT<String?>(jsonRes['units']),
        totalNum: asT<String?>(jsonRes['total_num']),
        residueNum: asT<String?>(jsonRes['residue_num']),
        recyclePrice: asT<String?>(jsonRes['recycle_price']),
        name: asT<String?>(jsonRes['name']),
        image: asT<String?>(jsonRes['image']),
        ifRecycle: asT<int?>(jsonRes['if_recycle']),
        ifProcess: asT<int?>(jsonRes['if_process']),
        ifExpire: asT<int?>(jsonRes['if_expire']),
        id: asT<int?>(jsonRes['id']),
        expireTime: asT<String?>(jsonRes['expire_time']),
        createtime: asT<String?>(jsonRes['createtime']),
      );

  String? units;
  String? totalNum;
  String? residueNum;
  String? recyclePrice;
  String? name;
  String? image;
  int? ifRecycle;
  int? ifProcess;
  int? ifExpire;
  int? id;
  String? expireTime;
  String? createtime;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'units': units,
        'total_num': totalNum,
        'residue_num': residueNum,
        'recycle_price': recyclePrice,
        'name': name,
        'image': image,
        'if_recycle': ifRecycle,
        'if_process': ifProcess,
        'if_expire': ifExpire,
        'id': id,
        'expire_time': expireTime,
        'createtime': createtime,
      };
}
