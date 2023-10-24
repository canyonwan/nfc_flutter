import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'category_model.dart';

typedef Callback = void Function(String sort);

class FlterHeaderView extends StatefulWidget {
  final Callback? callback;
  FlterHeaderView({Key? key, required this.scoffoldKey, this.callback})
      : super(key: key);

  final GlobalKey<ScaffoldState> scoffoldKey;
  @override
  _FlterHeaderViewState createState() => _FlterHeaderViewState();
}

class _FlterHeaderViewState extends State<FlterHeaderView>
    with AutomaticKeepAliveClientMixin {
  List<CategoryFilterItem> filterList = [
    CategoryFilterItem(
        name: "默认", id: 1, sort: 1, fileds: "def", seletecd: true),
    CategoryFilterItem(
        name: "销量", id: 2, sort: 1, fileds: "sale", seletecd: false),
    CategoryFilterItem(
        name: "价格", id: 3, sort: 1, fileds: "price", seletecd: false),
    CategoryFilterItem(name: "筛选", id: 4, sort: 1, fileds: "", seletecd: false),
  ];

  int count = 0;
  int salecount = 0;

  @override
  void initState() {
    super.initState();
    // if (widget.callback != null) widget.callback!("def");
  }

  Widget _upArrow() {
    if ((count + 1) % 2 == 0) {
      return Image.asset(
        "assets/icons/upSeletecd.png",
        fit: BoxFit.fill,
      );
    } else {
      return Image.asset(
        "assets/icons/up.png",
        fit: BoxFit.fill,
      );
    }
  }

  Widget _upArrow1() {
    if ((salecount + 1) % 2 == 0) {
      return Image.asset(
        "assets/icons/upSeletecd.png",
        fit: BoxFit.fill,
      );
    } else {
      return Image.asset(
        "assets/icons/up.png",
        fit: BoxFit.fill,
      );
    }
  }

  /// 处理下箭头逻辑
  Widget _downArrow() {
    if (count == 2) {
      return Image.asset(
        "assets/icons/downSeletecd.png",
        fit: BoxFit.fill,
      );
    } else {
      return Image.asset(
        "assets/icons/down.png",
        fit: BoxFit.fill,
      );
    }
  }

  /// 处理下箭头逻辑
  Widget _downArrow1() {
    if (salecount == 2) {
      return Image.asset(
        "assets/icons/downSeletecd.png",
        fit: BoxFit.fill,
      );
    } else {
      return Image.asset(
        "assets/icons/down.png",
        fit: BoxFit.fill,
      );
    }
  }

  Widget _filteHeaders(BuildContext context) {
    return Positioned(
      height: 50,
      width: MediaQuery.of(context).size.width,
      child: Container(
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 1,
              color: Colors.black12,
            ),
          ),
        ),
        child: Row(
          children: filterList.asMap().keys.map((index) {
            var item = filterList[index];

            return Expanded(
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  setState(() {
                    for (var item in filterList) {
                      item.seletecd = false;
                    }

                    if (item.id == 4) {
                      widget.scoffoldKey.currentState?.openEndDrawer();
                      item.seletecd = true;
                    } else if (item.id == 3) {
                      count++;
                      if (count == 3 || count == 0) {
                        count = 0;
                        item.seletecd = false;
                        if (widget.callback != null) widget.callback!("def");
                      } else {
                        item.seletecd = true;
                        if (widget.callback != null) {
                          String fileds = item.fileds;
                          if ((count + 1) % 2 == 0) {
                            fileds += "+";
                          }

                          if (count == 2) {
                            fileds += "-";
                          }
                          widget.callback!(fileds);
                        }
                      }
                    } else if (item.id == 2) {
                      salecount++;
                      if (salecount == 3 || salecount == 0) {
                        salecount = 0;
                        item.seletecd = false;
                        if (widget.callback != null) widget.callback!("def");
                      } else {
                        item.seletecd = true;
                        if (widget.callback != null) {
                          String fileds = item.fileds;
                          if ((salecount + 1) % 2 == 0) {
                            fileds += "+";
                          }

                          if (salecount == 2) {
                            fileds += "-";
                          }
                          widget.callback!(fileds);
                        }
                      }
                    } else {
                      item.seletecd = true;
                      if (widget.callback != null)
                        widget.callback!(item.fileds);
                    }
                  });
                },
                child: Stack(
                  children: [
                    SizedBox(
                      height: double.infinity,
                      width: double.infinity,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            item.name,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: item.seletecd == true
                                  ? Colors.red
                                  : Colors.black87,
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          item.id == 2
                              ? SizedBox(
                                  height: 40,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: 4,
                                        width: 6,
                                        child: _upArrow1(),
                                      ),
                                      const SizedBox(
                                        height: 2.0,
                                      ),
                                      SizedBox(
                                        height: 4,
                                        width: 6,
                                        child: _downArrow1(),
                                      )
                                    ],
                                  ),
                                )
                              : Container(),
                          item.id == 3
                              ? SizedBox(
                                  height: 40,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: 4,
                                        width: 6,
                                        child: _upArrow(),
                                      ),
                                      const SizedBox(
                                        height: 2.0,
                                      ),
                                      SizedBox(
                                        height: 4,
                                        width: 6,
                                        child: _downArrow(),
                                      )
                                    ],
                                  ),
                                )
                              : Container(),
                          item.id == 4
                              ? SizedBox(
                                  height: 15,
                                  width: 12,
                                  child: item.seletecd == true
                                      ? Image.asset(
                                          "assets/icons/filterSeletecd.png",
                                          fit: BoxFit.fill,
                                        )
                                      : Image.asset(
                                          "assets/icons/filter.png",
                                          fit: BoxFit.fill,
                                        ),
                                )
                              : Container(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
            //Text(value["title"]);
          }).toList(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _filteHeaders(context);
  }

  @protected
  bool get wantKeepAlive => true;
}
