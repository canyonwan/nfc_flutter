import 'dart:convert';

import '/app/models/product_model.dart';
import '/app/models/sku_specification_model.dart';

class SkuUtil {
  final List<SkuSpecification> specifications = [];
  final List<SkuStock>? skuStock;
  final List<ProductAttribute>? productAttribute;
  final List<ProductAttrValue>? productAttrValue;
  final SkuStock? initSku;
  Map selectSpec = {};

  SkuUtil({
    required this.skuStock,
    required this.productAttribute,
    required this.productAttrValue,
    this.initSku,
  }) {
    initSeclectSpec();
    init();

    updateOptional();
  }

  void init() {
    if (productAttribute != null) {
      for (int i = 0; i < productAttribute!.length; i++) {
        ProductAttribute _item = productAttribute![i];
        Set<SpecificationValue> _values = {};
        if (_item.inputList!.isNotEmpty) {
          List<String> _inputList = _item.inputList!.split(",");
          _values.addAll(generateValues(_item.name!, _inputList));
        }
        _values.addAll(getEditOptions(_item.name!, _item.id!));
        specifications
            .add(SkuSpecification(name: _item.name!, values: _values));
      }
    }
  }

  void initSeclectSpec() {
    if (productAttrValue != null)
      for (int i = 0; i < productAttribute!.length; i++) {
        ProductAttribute _item = productAttribute![i];
        selectSpec[_item.name!] = "";
      }
  }

  void setSelect(Set<SpecificationValue> values, String name, String title) {
    selectSpec[title] = name;
    for (var item in values) {
      if (item.name == name) {
        item.isSelected = !item.isSelected;
        if (item.isSelected == false) {
          selectSpec[title] = "";
        }
      } else {
        item.isSelected = false;
      }
    }

    updateOptional();
  }

  SkuStock? getSelectedSku() {
    for (var k in selectSpec.keys) {
      if (selectSpec[k] == "") {
        return null;
      }
    }

    if (skuStock != null) {
      for (int i = 0; i < skuStock!.length; i++) {
        var sku = skuStock![i];
        List json = combSkuspData(sku);
        int j = 0;

        for (var k in selectSpec.keys) {
          if (json.contains(selectSpec[k]) && selectSpec[k] != "") {
            j++;
          } else if (selectSpec[k] == "") {
            j++;
          }
        }
        if (j == productAttribute!.length) {
          return sku;
        }
      }
    }
    return null;
  }

  Map getSelectedSpec() {
    return selectSpec;
  }

  void updateOptional() {
    for (var item in specifications) {
      for (var spec in item.values) {
        spec.isOptional = judgeOptional(item.name, spec.name);
      }
    }
  }

  List<String> combSkuspData(SkuStock sku) {
    List<String> result = [];
    if (sku.spData != null) {
      List spData = jsonDecode(sku.spData!);
      for (var item in spData) {
        result.add(item["value"]);
      }
    }

    return result;
  }

  Set<SpecificationValue> generateValues(String title, List<String> list) {
    Set<SpecificationValue> _values = {};
    for (int i = 0; i < list.length; i++) {
      _values.add(SpecificationValue(
        name: list[i],
        isSelected: defaultSelected(list[i]),
        isOptional: judgeOptional(title, list[i]),
      ));
    }

    return _values;
  }

  Set<SpecificationValue> getEditOptions(String title, int id) {
    Set<SpecificationValue> _values = {};
    if (productAttrValue != null && productAttrValue!.isNotEmpty) {
      for (var item in productAttrValue!) {
        if (item.productAttributeId == id) {
          if (item.value != null) {
            List<String> list = item.value!.split(",");
            for (int i = 0; i < list.length; i++) {
              _values.add(SpecificationValue(
                name: list[i],
                isSelected: defaultSelected(list[i]),
                isOptional: judgeOptional(title, list[i]),
              ));
            }
          }
        }
      }
    }

    return _values;
  }

  bool defaultSelected(String name) {
    if (initSku == null) {
      return false;
    }

    String? data = initSku?.spData;
    if (data != null) {
      List spData = jsonDecode(data);
      for (var item in spData) {
        if (item["value"] == name) {
          selectSpec[item["key"]] = item["value"];
          return true;
        }
      }
    }

    return false;
  }

  bool judgeOptional(String title, String name) {
    Map copySelectSpec = jsonDecode(jsonEncode(selectSpec));
    copySelectSpec[title] = name;
    if (skuStock != null && skuStock!.isNotEmpty) {
      for (int i = 0; i < skuStock!.length; i++) {
        var sku = skuStock![i];
        List json = combSkuspData(sku);
        int j = 0;

        for (var k in copySelectSpec.keys) {
          if (json.contains(copySelectSpec[k]) && copySelectSpec[k] != "") {
            j++;
          } else if (copySelectSpec[k] == "") {
            j++;
          }
        }
        if (j == productAttribute!.length) {
          return true;
        }
      }
    }
    return false;
  }

  List<SkuSpecification> getSpec() {
    return specifications;
  }
}
