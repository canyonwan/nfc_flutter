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

class MyQRCodeRootModel {
  MyQRCodeRootModel({
    required this.code,
    this.data,
    required this.msg,
  });

  factory MyQRCodeRootModel.fromJson(Map<String, dynamic> json) =>
      MyQRCodeRootModel(
        code: asT<int>(json['code'])!,
        data: json['data'] == null
            ? null
            : MyQRCodeDataModel.fromJson(
                asT<Map<String, dynamic>>(json['data'])!),
        msg: asT<String>(json['msg'])!,
      );

  int code;
  MyQRCodeDataModel? data;
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

class MyQRCodeDataModel {
  MyQRCodeDataModel({
    this.erImg,
    this.yiImg,
  });

  factory MyQRCodeDataModel.fromJson(Map<String, dynamic> json) =>
      MyQRCodeDataModel(
        erImg: asT<String?>(json['er_img']),
        yiImg: asT<String?>(json['yi_img']),
      );

  String? erImg;
  String? yiImg;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'er_img': erImg,
        'yi_img': yiImg,
      };
}
