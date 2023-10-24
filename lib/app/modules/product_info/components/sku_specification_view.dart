import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:mallxx_app/app/modules/product_info/components/sku_util.dart';
import 'package:mallxx_app/const/colors.dart';

import '../../../models/sku_specification_model.dart';
import '/app/components/number_item.dart';
import '/app/components/photo_preview.dart';
import '/app/models/product_model.dart';

typedef clickItem = void Function(SkuStock? sku, String value);
typedef clickFinish = void Function(SkuStock? sku, int count);

class SkuSpecificationView extends StatefulWidget {
  final List<SkuStock>? skuStock;
  final List<ProductAttribute>? productAttribute;
  final List<ProductAttrValue>? productAttrValue;
  final clickItem? onClickItem;
  final clickFinish? onclickFinish;
  final SkuStock? initSkut;

  const SkuSpecificationView({
    Key? key,
    this.skuStock,
    this.productAttrValue,
    this.productAttribute,
    this.onClickItem,
    this.onclickFinish,
    this.initSkut,
  }) : super(key: key);

  @override
  _SelectSpecificationsViewState createState() =>
      _SelectSpecificationsViewState();
}

class _SelectSpecificationsViewState extends State<SkuSpecificationView>
    with AutomaticKeepAliveClientMixin {
  late final SkuUtil _skuUtil = SkuUtil(
    initSku: widget.initSkut,
    skuStock: widget.skuStock,
    productAttrValue: widget.productAttrValue,
    productAttribute: widget.productAttribute,
  );

  SkuStock? _defaultSkuStock;

  String _selectText = "请选择";

  int _count = 1;

  @override
  void initState() {
    super.initState();

    _defaultSkuStock = widget.initSkut;
    _setSelectText();
  }

  @override
  bool get wantKeepAlive => true;

  void _setSelectText() {
    Map selectMap = _skuUtil.getSelectedSpec();
    String text = "";
    if (selectMap.isNotEmpty) {
      text = "已选 ";
      for (var k in selectMap.keys) {
        if (selectMap[k] != "") {
          text += k + ": " + selectMap[k] + " ";
        }
      }
    }

    if (text.length <= 3) {
      _selectText = "请选择";
    } else {
      _selectText = text;
    }
  }

  void _onClickItem() {
    SkuStock? sku = _skuUtil.getSelectedSku();
    if (sku != null) {
      _defaultSkuStock = sku;
    }

    _setSelectText();
    if (widget.onClickItem != null) {
      widget.onClickItem!(sku, _selectText);
    }
  }

  void _onFinish() {
    if (widget.onclickFinish != null) {
      widget.onclickFinish!(_defaultSkuStock, _count);
    }

    Get.back();
  }

  List<Widget> _createSpecifiction() {
    List<Widget> _list = [];

    List specList = _skuUtil.getSpec();
    for (int i = 0; i < specList.length; i++) {
      SkuSpecification item = specList[i];
      List<Widget> _valueList = [];

      Widget _title = Container(
        alignment: Alignment.centerLeft,
        margin: const EdgeInsets.only(left: 10, bottom: 10, top: 10),
        child: Text(
          item.name,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
      );
      _list.add(_title);

      for (SpecificationValue _value in item.values) {
        Widget _valueWidget = GestureDetector(
          onTap: () {
            if (_value.isOptional == false) return;
            setState(() {
              _skuUtil.setSelect(item.values, _value.name, item.name);
              _onClickItem();
            });
          },
          child: Container(
            decoration: BoxDecoration(
              color: _value.isOptional
                  ? _value.isSelected
                      ? const Color.fromRGBO(252, 237, 235, 1)
                      : const Color.fromRGBO(242, 242, 242, 1)
                  : const Color.fromRGBO(242, 242, 242, 1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                width: 0.5,
                color: _value.isSelected
                    ? const Color(0xFFFF6732)
                    : const Color(0xFFF7F7F7),
              ),
            ),
            alignment: Alignment.center,
            height: 35,
            width: 115,
            child: Text(
              _value.name,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                decoration: _value.isOptional
                    ? TextDecoration.none
                    : TextDecoration.lineThrough,
                color: _value.isOptional
                    ? _value.isSelected
                        ? const Color(0xFFFF6732)
                        : const Color(0xff333333)
                    : const Color.fromRGBO(191, 191, 191, 1),
              ),
            ),
          ),
        );

        _valueList.add(_valueWidget);
      }

      Widget _wrap = Container(
        margin: const EdgeInsets.only(left: 10),
        child: Wrap(
          spacing: 10,
          runSpacing: 5,
          children: _valueList,
        ),
      );

      _list.add(_wrap);
    }
    return _list;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.topRight,
              child: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(
                  Icons.close,
                  size: 25,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 10, right: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      if (_defaultSkuStock!.pic != null) {
                        Get.to(
                            () => PhotoPreView(
                                index: 0, images: [_defaultSkuStock!.pic!]),
                            transition: Transition.fadeIn);
                      }
                    },
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: const BoxDecoration(
                        color: Color(0xffeeeeee),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: _defaultSkuStock?.pic != null &&
                              _defaultSkuStock?.pic != ""
                          ? Image.network(_defaultSkuStock!.pic!)
                          : Container(),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    height: 120,
                    width: MediaQuery.of(context).size.width - 140,
                    margin: const EdgeInsets.only(left: 10),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _defaultSkuStock?.price != null
                              ? "price".trArgs(["${_defaultSkuStock!.price}"])
                              : "",
                          style:
                              const TextStyle(fontSize: 25, color: Colors.red),
                        ),
                        Text(
                          _selectText,
                          softWrap: true,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style:
                              const TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                        if (_defaultSkuStock?.lockStock != null)
                          if (_defaultSkuStock!.lockStock! >=
                              _defaultSkuStock!.stock!)
                            Text(
                              "low".tr,
                              style: TextStyle(fontSize: 12, color: Colors.red),
                            )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: _createSpecifiction(),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "quantity".tr,
                    style: const TextStyle(fontSize: 14),
                  ),
                  NumberItem(
                    number: _count,
                    isEnable: true,
                    addClick: (value) {
                      setState(() {
                        _count = value;
                      });
                    },
                    subClick: (value) {
                      setState(() {
                        _count = value;
                      });
                    },
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
        Positioned(
            bottom: 40,
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    _onFinish();
                  },
                  child: Container(
                    width: 350,
                    height: 40,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                      color: Colors.red,
                    ),
                    // width: double.infinity,
                    alignment: Alignment.center,
                    child: Text(
                      "finish".tr,
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: KWhiteColor),
                    ),
                  ),
                ),
              ],
            )),
      ],
    );
  }
}
