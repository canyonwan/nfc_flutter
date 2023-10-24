import 'package:flutter/material.dart';

import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

import '/app/models/product_model.dart';
import 'productItem_view.dart';

class RecommandListView extends StatefulWidget {
  RecommandListView({Key? key, required this.list}) : super(key: key);

  List<Product> list;
  @override
  _RecommandListState createState() => _RecommandListState();
}

class _RecommandListState extends State<RecommandListView> {
  ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    // final List<String> _list = widget.list;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10, top: 5),
          child: Text(
            "home_like".tr,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        //商品列表
        StaggeredGridView.countBuilder(
          // physics: AlwaysScrollableScrollPhysics(),
          // padding: const EdgeInsets.only(top: 0),
          // primary: true,
          shrinkWrap: true,
          controller: _scrollController,
          crossAxisCount: 4,
          crossAxisSpacing: 2,
          mainAxisSpacing: 2,
          itemCount: widget.list.length,
          itemBuilder: (context, index) {
            return ProductItemView(item: widget.list[index]);
          },
          staggeredTileBuilder: (index) => const StaggeredTile.fit(2),
        ),
      ],
    );
  }
}
