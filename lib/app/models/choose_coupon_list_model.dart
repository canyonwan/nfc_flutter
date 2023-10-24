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

class ChooseCouponListRootModel {
  ChooseCouponListRootModel({
    required this.code,
    this.data,
    required this.msg,
  });

  factory ChooseCouponListRootModel.fromJson(Map<String, dynamic> json) =>
      ChooseCouponListRootModel(
        code: asT<int>(json['code'])!,
        data: json['data'] == null
            ? null
            : ChooseCouponListDataModel.fromJson(
                asT<Map<String, dynamic>>(json['data'])!),
        msg: asT<String>(json['msg'])!,
      );

  int code;
  ChooseCouponListDataModel? data;
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

class ChooseCouponListDataModel {
  ChooseCouponListDataModel({
    this.canUse,
    this.canUseCount,
    this.notUse,
    this.notUseCount,
    this.price,
  });

  factory ChooseCouponListDataModel.fromJson(Map<String, dynamic> json) {
    final List<ChooseCouponModel>? canUse =
        json['can_use'] is List ? <ChooseCouponModel>[] : null;
    if (canUse != null) {
      for (final dynamic item in json['can_use']!) {
        if (item != null) {
          tryCatch(() {
            canUse.add(
                ChooseCouponModel.fromJson(asT<Map<String, dynamic>>(item)!));
          });
        }
      }
    }

    final List<ChooseCouponModel>? notUse =
        json['not_use'] is List ? <ChooseCouponModel>[] : null;
    if (notUse != null) {
      for (final dynamic item in json['not_use']!) {
        if (item != null) {
          tryCatch(() {
            notUse.add(
                ChooseCouponModel.fromJson(asT<Map<String, dynamic>>(item)!));
          });
        }
      }
    }
    return ChooseCouponListDataModel(
      canUse: canUse,
      canUseCount: asT<int?>(json['can_use_count']),
      notUse: notUse,
      notUseCount: asT<int?>(json['not_use_count']),
      price: asT<String?>(json['price']),
    );
  }

  List<ChooseCouponModel>? canUse;
  int? canUseCount;
  List<ChooseCouponModel>? notUse;
  int? notUseCount;
  String? price;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'can_use': canUse,
        'can_use_count': canUseCount,
        'not_use': notUse,
        'not_use_count': notUseCount,
        'price': price,
      };
}

class ChooseCouponModel {
  ChooseCouponModel({
    this.endTime,
    this.explain,
    this.full,
    this.id,
    this.name,
    this.price,
    this.startTime,
  });

  factory ChooseCouponModel.fromJson(Map<String, dynamic> json) =>
      ChooseCouponModel(
        endTime: asT<String?>(json['end_time']),
        explain: asT<String?>(json['explain']),
        full: asT<String?>(json['full']),
        id: asT<int?>(json['id']),
        name: asT<String?>(json['name']),
        price: asT<String?>(json['price']),
        startTime: asT<String?>(json['start_time']),
      );

  String? endTime;
  String? explain;
  String? full;
  int? id;
  String? name;
  String? price;
  String? startTime;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'end_time': endTime,
        'explain': explain,
        'full': full,
        'id': id,
        'name': name,
        'price': price,
        'start_time': startTime,
      };
}
