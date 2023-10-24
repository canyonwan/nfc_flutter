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

class CityDataRootModel {
  CityDataRootModel({
    required this.code,
    this.data,
    this.msg,
  });

  factory CityDataRootModel.fromJson(Map<String, dynamic> json) {
    final List<CityItemModel>? data =
        json['data'] is List ? <CityItemModel>[] : null;
    if (data != null) {
      for (final dynamic item in json['data']!) {
        if (item != null) {
          tryCatch(() {
            data.add(CityItemModel.fromJson(asT<Map<String, dynamic>>(item)!));
          });
        }
      }
    }
    return CityDataRootModel(
      code: asT<int>(json['code'])!,
      data: data,
      msg: asT<String?>(json['msg']),
    );
  }

  int code;
  List<CityItemModel>? data;
  String? msg;

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

class CityItemModel {
  CityItemModel({
    this.checked,
    this.childrenlist,
    this.id,
    this.parentId,
    this.name,
  });

  factory CityItemModel.fromJson(Map<String, dynamic> json) {
    final List<CityItemModel>? childrenlist =
        json['ChildrenList'] is List ? <CityItemModel>[] : null;
    if (childrenlist != null) {
      for (final dynamic item in json['ChildrenList']!) {
        if (item != null) {
          tryCatch(() {
            childrenlist
                .add(CityItemModel.fromJson(asT<Map<String, dynamic>>(item)!));
          });
        }
      }
    }
    return CityItemModel(
      checked: asT<int?>(json['checked']),
      childrenlist: childrenlist,
      id: asT<int?>(json['id']),
      parentId: asT<int?>(json['parentId']),
      name: asT<String?>(json['name']),
    );
  }

  int? checked;
  List<CityItemModel>? childrenlist;
  int? id;
  int? parentId;
  String? name;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'checked': checked,
        'ChildrenList': childrenlist,
        'id': id,
        'parentId': parentId,
        'name': name,
      };
}
