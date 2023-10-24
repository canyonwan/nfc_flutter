import 'package:better_video_player/better_video_player.dart';
import 'package:bruno/bruno.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mallxx_app/app/models/field_detail_model.dart';
import 'package:mallxx_app/const/colors.dart';

import '../controllers/field_detail_controller.dart';

class LiveActionRecordsView extends StatefulWidget {
  final List<LiveActionItemModel> recordList;
  int totalPage;

  LiveActionRecordsView(
      {Key? key, required this.recordList, required this.totalPage})
      : super(key: key);

  @override
  State<LiveActionRecordsView> createState() => _LiveActionRecordsViewState();
}

class _LiveActionRecordsViewState extends State<LiveActionRecordsView> {
  int _playingIndex = -1;
  int page = 1;

  Future<void> onLoadMore(FieldDetailController c) async {
    ++page;
    await c.getFieldDetail(page: page, onlyChangeLive: true);
    if (page >= widget.totalPage) {
      c.liveActionEasyRefreshController.finishLoad(IndicatorResult.noMore);
    } else {
      c.liveActionEasyRefreshController.finishLoad(IndicatorResult.success);
    }
    // if (widget.totalPage == page) {
    //   c.liveActionEasyRefreshController.finishLoad(IndicatorResult.noMore);
    // } else {
    //
    // }
  }

  void onZoomImage(String img) {
    Get.dialog(
      Center(
        child: Container(
            margin: EdgeInsets.all(10.w),
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.w),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(width: 40.w),
                    Text(
                      '查看大图',
                      style: TextStyle(color: Colors.black, fontSize: 16.sp),
                    ),
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: Icon(
                        Icons.close,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.w),
                GestureDetector(
                  onTap: () => Get.back(),
                  child: Image.network(img),
                ),
              ],
            )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FieldDetailController>(builder: (c) {
      return EasyRefresh.builder(
          controller: c.liveActionEasyRefreshController,
          onLoad: () => onLoadMore(c),
          childBuilder: (context, physic) {
            return CustomScrollView(
              physics: physic,
              slivers: [
                SliverToBoxAdapter(
                  child: _buildTagItem(c)
                      .paddingOnly(top: 14.w, left: 12.w, right: 12.w),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => _buildItem(index, c),
                    childCount: widget.recordList.length,
                  ),
                ),
              ],
            );
          });
    });
  }

  double _getTagWidth(context, {int rowCount: 4}) {
    double leftRightPadding = 40;
    double rowItemSpace = 12;
    return MediaQuery.of(context).size.width -
        leftRightPadding -
        rowItemSpace * (rowCount - 1) / rowCount;
  }

  Widget _buildTagItem(FieldDetailController c) {
    return c.labelList.isNotEmpty
        ? BrnSelectTag(
            tags: c.labelList.map((e) => e.name).toList(),
            spacing: 10,
            softWrap: false,
            fixWidthMode: false,
            isSingleSelect: true,
            tagWidth: _getTagWidth(context),
            initTagState: [
              c.labelList
                  .map((e) => e.id.toString())
                  .toList()
                  .contains(c.labels),
            ],
            onSelect: (selectedIndexes) {
              c.onFilterRecordList(selectedIndexes);
            }).paddingOnly(bottom: 20.h)
        : SizedBox();
  }

  Container _buildItem(int idx, FieldDetailController c) {
    return Container(
      // padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
      padding: EdgeInsets.only(bottom: 20.w, left: 12.w, right: 12.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widget.recordList[idx].type == 1
              ? _buildImageWall(widget.recordList[idx].images!)
              : VideoItemWidget(
                  model: widget.recordList[idx],
                  index: idx,
                  playingIndex: _playingIndex,
                  onVideoClick: () {
                    setState(() {
                      _playingIndex = idx;
                    });
                  },
                ),
          Text.rich(
            TextSpan(
              text: '${widget.recordList[idx].content}\t\t\t\t\t\t\t\t\t',
              style: TextStyle(fontSize: 15.sp),
              children: [
                TextSpan(
                  text: '${widget.recordList[idx].createtime}',
                  style: TextStyle(color: kAppSubGrey99Color, fontSize: 11.sp),
                ),
              ],
            ),
          ).paddingOnly(top: 10.w),
          if (widget.recordList[idx].ifControl == 2)
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                    onPressed: () => c.onDeleteRecord(widget.recordList[idx]),
                    child: Text(
                      '删除',
                      style: TextStyle(color: Colors.redAccent),
                    )),
                BrnBigGhostButton(
                  width: 80,
                  title: '编辑',
                  onTap: () => c.onEditRecord(widget.recordList[idx]),
                )
              ],
            )
        ],
      ),
    );
  }

// 图片墙
  Widget _buildImageWall(List<String> images) {
    return GridView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.only(bottom: 10.h),
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1,
        mainAxisSpacing: 10.w,
        crossAxisSpacing: 10.w,
      ),
      itemCount: images.length,
      itemBuilder: (_, int index) {
        return GestureDetector(
          onTap: () => onZoomImage(images[index]),
          child: Image.network(images[index],
              width: 120.w, height: 120.w, fit: BoxFit.cover),
        );
      },
    );
  }
}

/// video item
class VideoItemWidget extends StatefulWidget {
  final LiveActionItemModel model;
  final int playingIndex; // 正在播放的
  final int index; // 当前数据项
  final VoidCallback onVideoClick;

  const VideoItemWidget(
      {Key? key,
      required this.playingIndex,
      required this.index,
      required this.onVideoClick,
      required this.model})
      : super(key: key);

  @override
  State<VideoItemWidget> createState() => _VideoItemWidgetState();
}

class _VideoItemWidgetState extends State<VideoItemWidget>
    with AutomaticKeepAliveClientMixin {
  BetterVideoPlayerController playerController = BetterVideoPlayerController();

  @override
  void dispose() {
    playerController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant VideoItemWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.playingIndex == oldWidget.index &&
        widget.playingIndex != widget.index) {
      final oldPlayerController = playerController;
      Future.delayed(Duration(milliseconds: 500), () {
        oldPlayerController.dispose();
      });
      playerController = BetterVideoPlayerController();
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return AspectRatio(
      aspectRatio: 16.0 / 9.0,
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (widget.playingIndex != widget.index)
            Image.network(widget.model.videoImage!, fit: BoxFit.cover),
          // play button
          if (widget.playingIndex != widget.index)
            CupertinoButton(
              padding: EdgeInsets.zero,
              child: Container(
                // constraints: BoxConstraints.tightFor(width: 60, height: 60),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black26,
                ),
                child:
                    const Icon(Icons.play_arrow, color: KWhiteColor, size: 40),
              ),
              onPressed: widget.onVideoClick,
            ),
          // video player
          if (widget.playingIndex == widget.index)
            BetterVideoPlayer(
              controller: playerController,
              dataSource: BetterVideoPlayerDataSource(
                BetterVideoPlayerDataSourceType.network,
                widget.model.videoFile!,
              ),
              configuration: BetterVideoPlayerConfiguration(
                placeholder: Image.network(widget.model.videoImage!,
                    fit: BoxFit.contain),
              ),
            ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => widget.playingIndex == widget.index;
}
