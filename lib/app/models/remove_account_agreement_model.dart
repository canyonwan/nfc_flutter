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

class RemoveAccountInfoRootModel {
  RemoveAccountInfoRootModel({
    required this.code,
    this.data,
    required this.msg,
  });

  factory RemoveAccountInfoRootModel.fromJson(Map<String, dynamic> json) =>
      RemoveAccountInfoRootModel(
        code: asT<int>(json['code'])!,
        data: json['data'] == null
            ? null
            : RemoveAccountInfoDataModel.fromJson(
                asT<Map<String, dynamic>>(json['data'])!),
        msg: asT<String>(json['msg'])!,
      );

  int code;
  RemoveAccountInfoDataModel? data;
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

class RemoveAccountInfoDataModel {
  RemoveAccountInfoDataModel({
    this.content,
    this.id,
    this.title,
  });

  factory RemoveAccountInfoDataModel.fromJson(Map<String, dynamic> json) =>
      RemoveAccountInfoDataModel(
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
