import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:mallxx_app/const/colors.dart';

import 'category_model.dart';

class SideFilterView extends StatefulWidget {
  final Function(dynamic data, double minPrice, double maxPrice)? onCallback;
  double minPrice = 0.0;
  double maxPrice = 0.0;
  SideFilterView(
      {Key? key,
      this.onCallback,
      required this.maxPrice,
      required this.minPrice})
      : super(key: key);

  @override
  _SideFilterViewState createState() => _SideFilterViewState();
}

class _SideFilterViewState extends State<SideFilterView> {
  bool seletect = false;
  late final TextEditingController minController;
  late final TextEditingController maxController;

  @override
  void initState() {
    super.initState();
    minController = TextEditingController(
        text: widget.minPrice > 0 ? widget.minPrice.toString() : "");
    maxController = TextEditingController(
        text: widget.maxPrice > 0 ? widget.maxPrice.toString() : "");
  }

  @override
  void dispose() {
    super.dispose();
    minController.dispose();
    maxController.dispose();
  }

  Widget _sideSectionTitle(String title, List<CategoryFilterItem> list) {
    List array = [];
    List test = [];

    for (var element in list) {
      if (element.seletecd) {
        array.add(element.name);
        test.join(element.name);
      }
    }

    return Container(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Row(
            children: [
              SizedBox(
                width: 200,
                child: Text(
                  array.isNotEmpty ? array.toString() : "",
                  style: TextStyle(color: Colors.red),
                  textAlign: TextAlign.right,
                  maxLines: 1,
                  overflow: TextOverflow.clip,
                ),
              ),
              list != null && list.length > 6
                  ? InkWell(
                      onTap: () {
                        setState(() {
                          seletect = !seletect;
                        });
                      },
                      child: seletect == true
                          ? Icon(Icons.arrow_drop_down)
                          : Icon(Icons.arrow_drop_up),
                    )
                  : const Text("")
            ],
          )
        ],
      ),
    );
  }

  Widget _sideItem(List<CategoryFilterItem> list) {
    List actionList = [];
    for (var val in list) {
      actionList.add(val);
    }

    List temp = list;
    if (seletect && list.length > 6) {
      temp = actionList;
    }

    return Container(
      padding: const EdgeInsets.only(top: 5),
      child: Wrap(
        spacing: 10,
        runSpacing: 5,
        children: temp.asMap().keys.map((e) {
          CategoryFilterItem item = temp[e];

          return InkWell(
            onTap: () {
              setState(() {
                bool sel = item.seletecd;
                if (!sel) {
                  item.seletecd = true;
                } else {
                  item.seletecd = false;
                }
              });
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                  width: 0.5,
                  color: item.seletecd ? Colors.red : Colors.transparent,
                ),
              ),
              alignment: Alignment.center,
              height: 36,
              width: 90,
              child: Chip(
                backgroundColor: item.seletecd
                    ? Color.fromRGBO(245, 245, 245, 0.2)
                    : Color.fromRGBO(240, 240, 240, 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                label: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      child: Container(
                        width: double.infinity,
                        child: Text(
                          "###",
                          style: TextStyle(color: Colors.transparent),
                        ),
                      ),
                    ),
                    Text(
                      "${item.name}",
                      style: TextStyle(
                          fontSize: 12,
                          color: item.seletecd ? Colors.red : Colors.black),
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _sideTextItem(String hintText, void Function(String) onChange,
      TextEditingController controller) {
    return Container(
      alignment: Alignment.center,
      height: 30,
      width: 125,
      decoration: BoxDecoration(
        color: Color.fromRGBO(240, 240, 240, 1),
        borderRadius: BorderRadius.circular(40),
      ),
      child: TextField(
        keyboardType: TextInputType.number,
        controller: controller,
        onChanged: onChange,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 12),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.only(left: 0, top: 0),
            counterText: '',
            hintText: hintText,
            hintStyle: TextStyle(
              color: Colors.black38,
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(10),
            )),
      ),
    );
  }

  Widget _priceItem() {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: Row(
        children: [
          _sideTextItem(
            "最低价",
            (value) {
              setState(() {
                widget.minPrice = double.tryParse(value) ?? 0.0;
              });
            },
            minController,
          ),
          const SizedBox(
            width: 10,
          ),
          Container(
            width: 10,
            height: 1,
            color: Colors.black,
          ),
          const SizedBox(
            width: 10,
          ),
          _sideTextItem(
            "最高价",
            (value) {
              setState(() {
                widget.maxPrice = double.tryParse(value) ?? 0.0;
              });
            },
            maxController,
          ),
        ],
      ),
    );
  }

  Widget _filterCondition() {
    return SizedBox(
      height: MediaQuery.of(context).size.height - 90,
      child: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // _sideSectionTitle("aaa", filterList),
              // _sideItem(filterList),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Column(
            children: [
              _sideSectionTitle("价格区间", []),
              _priceItem(),
            ],
          )
        ],
      ),
    );
  }

  Widget _filterBottom() {
    return Positioned(
      bottom: 34,
      height: 80,
      child: Container(
        decoration: const BoxDecoration(
            border: Border(
                top: BorderSide(
          width: 1,
          color: Colors.black12,
        ))),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {},
              child: Container(
                color: KWhiteColor,
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width * 0.78 / 2,
                child: const Text(
                  "重置",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Get.back(result: "success");
                if (widget.onCallback != null) {
                  widget.onCallback!({}, widget.minPrice, widget.maxPrice);
                }
              },
              child: Container(
                alignment: Alignment.center,
                color: Colors.red,
                width: MediaQuery.of(context).size.width * 0.78 / 2,
                child: const Text(
                  "确定",
                  style: TextStyle(fontSize: 18, color: KWhiteColor),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _sideFilter() {
    return Stack(
      children: [_filterBottom(), _filterCondition()],
    );
  }

  @override
  Widget build(BuildContext context) {
    return _sideFilter();
  }
}
