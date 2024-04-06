import 'dart:convert';

T? asT<T>(dynamic value) {
  if (value is T) {
    return value;
  }
  return null;
}

class GranaryListRootModel {
  GranaryListRootModel({
    required this.code,
    required this.msg,
    this.data,
  });

  factory GranaryListRootModel.fromJson(Map<String, dynamic> json) =>
      GranaryListRootModel(
        code: asT<int>(json['code'])!,
        msg: asT<String>(json['msg'])!,
        data: json['data'] == null
            ? null
            : GranaryListDataModel.fromJson(
                asT<Map<String, dynamic>>(json['data'])!),
      );

  int code;
  String msg;
  GranaryListDataModel? data;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'code': code,
        'msg': msg,
        'data': data,
      };
}

class GranaryListDataModel {
  GranaryListDataModel({
    this.ifMessageShow,
    this.messageCount,
    this.articleId,
    this.articleTitle,
    this.image,
    this.totalPage,
    this.articleList,
    this.granaryList,
  });

  factory GranaryListDataModel.fromJson(Map<String, dynamic> json) {
    final List<ArticleList>? articleList =
        json['article_list'] is List ? <ArticleList>[] : null;
    if (articleList != null) {
      for (final dynamic item in json['article_list']!) {
        if (item != null) {
          articleList
              .add(ArticleList.fromJson(asT<Map<String, dynamic>>(item)!));
        }
      }
    }

    final List<GranaryItemModel>? granaryList =
        json['granary_list'] is List ? <GranaryItemModel>[] : null;
    if (granaryList != null) {
      for (final dynamic item in json['granary_list']!) {
        if (item != null) {
          granaryList
              .add(GranaryItemModel.fromJson(asT<Map<String, dynamic>>(item)!));
        }
      }
    }
    return GranaryListDataModel(
      ifMessageShow: asT<int?>(json['if_message_show']),
      messageCount: asT<int?>(json['message_count']),
      articleId: asT<String?>(json['article_id']),
      articleTitle: asT<String?>(json['article_title']),
      image: asT<String?>(json['image']),
      totalPage: asT<int?>(json['total_page']),
      articleList: articleList,
      granaryList: granaryList,
    );
  }

  int? ifMessageShow;
  int? messageCount;
  String? articleId;
  String? articleTitle;
  String? image;
  int? totalPage;
  List<ArticleList>? articleList;
  List<GranaryItemModel>? granaryList;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'if_message_show': ifMessageShow,
        'message_count': messageCount,
        'article_id': articleId,
        'article_title': articleTitle,
        'image': image,
        'total_page': totalPage,
        'article_list': articleList,
        'granary_list': granaryList,
      };
}

class ArticleList {
  ArticleList({
    this.articleId,
    this.articleTitle,
    this.ifShow,
  });

  factory ArticleList.fromJson(Map<String, dynamic> json) => ArticleList(
        articleId: asT<int?>(json['article_id']),
        articleTitle: asT<String?>(json['article_title']),
        ifShow: asT<int?>(json['if_show']),
      );

  int? articleId;
  String? articleTitle;
  int? ifShow;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'article_id': articleId,
        'article_title': articleTitle,
        'if_show': ifShow,
      };
}

class GranaryItemModel {
  GranaryItemModel({
    this.id,
    this.createtime,
    this.totalNum,
    this.name,
    this.residueNum,
    this.units,
    this.ifExpire,
    this.expireTime,
    this.ifRecycle,
    this.recyclePrice,
    this.ifProcess,
    this.image,
  });

  factory GranaryItemModel.fromJson(Map<String, dynamic> json) =>
      GranaryItemModel(
        id: asT<int?>(json['id']),
        createtime: asT<String?>(json['createtime']),
        totalNum: asT<String?>(json['total_num']),
        name: asT<String?>(json['name']),
        residueNum: asT<String?>(json['residue_num']),
        units: asT<String?>(json['units']),
        ifExpire: asT<int?>(json['if_expire']),
        expireTime: asT<String?>(json['expire_time']),
        ifRecycle: asT<int?>(json['if_recycle']),
        recyclePrice: asT<String?>(json['recycle_price']),
        ifProcess: asT<int?>(json['if_process']),
        image: asT<String?>(json['image']),
      );

  int? id;
  String? createtime;
  String? totalNum;
  String? name;
  String? residueNum;
  String? units;
  int? ifExpire;
  String? expireTime;
  int? ifRecycle;
  String? recyclePrice;
  int? ifProcess;
  String? image;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'createtime': createtime,
        'total_num': totalNum,
        'name': name,
        'residue_num': residueNum,
        'units': units,
        'if_expire': ifExpire,
        'expire_time': expireTime,
        'if_recycle': ifRecycle,
        'recycle_price': recyclePrice,
        'if_process': ifProcess,
        'image': image,
      };
}
