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

class NoticeListRootModel {
  NoticeListRootModel({
    required this.code,
    this.data,
    required this.msg,
  });

  factory NoticeListRootModel.fromJson(Map<String, dynamic> json) =>
      NoticeListRootModel(
        code: asT<int>(json['code'])!,
        data: json['data'] == null
            ? null
            : NoticeDatatModel.fromJson(
                asT<Map<String, dynamic>>(json['data'])!),
        msg: asT<String>(json['msg'])!,
      );

  int code;
  NoticeDatatModel? data;
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

class NoticeDatatModel {
  NoticeDatatModel({
    this.maxpage,
    this.messageCount,
    this.noticeCount,
    this.noticeList,
  });

  factory NoticeDatatModel.fromJson(Map<String, dynamic> json) {
    final List<NoticeItemModel>? noticeList =
        json['notice_list'] is List ? <NoticeItemModel>[] : null;
    if (noticeList != null) {
      for (final dynamic item in json['notice_list']!) {
        if (item != null) {
          tryCatch(() {
            noticeList.add(
                NoticeItemModel.fromJson(asT<Map<String, dynamic>>(item)!));
          });
        }
      }
    }
    return NoticeDatatModel(
      maxpage: asT<int?>(json['maxPage']),
      messageCount: asT<int?>(json['message_count']),
      noticeCount: asT<int?>(json['notice_count']),
      noticeList: noticeList,
    );
  }

  int? maxpage;
  int? messageCount;
  int? noticeCount;
  List<NoticeItemModel>? noticeList;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'maxPage': maxpage,
        'message_count': messageCount,
        'notice_count': noticeCount,
        'notice_list': noticeList,
      };
}

class NoticeItemModel {
  NoticeItemModel({
    this.createtime,
    this.describe,
    this.id,
    this.ifRead,
    this.images,
    this.title,
    this.type,
  });

  factory NoticeItemModel.fromJson(Map<String, dynamic> json) =>
      NoticeItemModel(
        createtime: asT<String?>(json['createtime']),
        describe: asT<String?>(json['describe']),
        id: asT<int?>(json['id']),
        ifRead: asT<int?>(json['if_read']),
        images: asT<String?>(json['images']),
        title: asT<String?>(json['title']),
        type: asT<int?>(json['type']),
      );

  String? createtime;
  String? describe;
  int? id;
  int? ifRead;
  String? images;
  String? title;
  int? type;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'createtime': createtime,
        'describe': describe,
        'id': id,
        'if_read': ifRead,
        'images': images,
        'title': title,
        'type': type,
      };
}

//

class MessageDetailRootModel {
  MessageDetailRootModel({
    required this.code,
    this.data,
    required this.msg,
  });

  factory MessageDetailRootModel.fromJson(Map<String, dynamic> json) =>
      MessageDetailRootModel(
        code: asT<int>(json['code'])!,
        data: json['data'] == null
            ? null
            : MessageDetailDataModel.fromJson(
                asT<Map<String, dynamic>>(json['data'])!),
        msg: asT<String>(json['msg'])!,
      );

  int code;
  MessageDetailDataModel? data;
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

class MessageDetailDataModel {
  MessageDetailDataModel({
    this.content,
    this.id,
    this.title,
  });

  factory MessageDetailDataModel.fromJson(Map<String, dynamic> json) =>
      MessageDetailDataModel(
        content: asT<String?>(json['content']),
        id: asT<int?>(json['id']),
        title: asT<String?>(json['title']),
      );

  String? content;
  int? id;
  String? title;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'content': content,
        'id': id,
        'title': title,
      };
}
