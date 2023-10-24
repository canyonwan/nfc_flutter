import 'package:better_video_player/better_video_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mallxx_app/app/models/find_model_entity.dart';
import 'package:mallxx_app/const/colors.dart';

/// video item
class FindVideoPlayView extends StatefulWidget {
  final FindItemModel model;
  final int playingIndex; // 正在播放的
  final int index; // 当前数据项
  final VoidCallback onVideoClick;

  const FindVideoPlayView(
      {Key? key,
      required this.playingIndex,
      required this.index,
      required this.onVideoClick,
      required this.model})
      : super(key: key);

  @override
  State<FindVideoPlayView> createState() => _FindVideoPlayViewState();
}

class _FindVideoPlayViewState extends State<FindVideoPlayView>
    with AutomaticKeepAliveClientMixin {
  BetterVideoPlayerController playerController = BetterVideoPlayerController();

  @override
  void dispose() {
    playerController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant FindVideoPlayView oldWidget) {
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

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: AspectRatio(
        aspectRatio: 16.0 / 9.0,
        child: Stack(
          fit: StackFit.expand,
          children: [
            if (widget.playingIndex != widget.index)
              Image.network(widget.model.image!, fit: BoxFit.cover),
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
                  child: const Icon(Icons.play_arrow,
                      color: KWhiteColor, size: 60),
                ),
                onPressed: widget.onVideoClick,
              ),
            // video player
            if (widget.playingIndex == widget.index)
              BetterVideoPlayer(
                controller: playerController,
                dataSource: BetterVideoPlayerDataSource(
                  BetterVideoPlayerDataSourceType.network,
                  widget.model.videoReturn!,
                ),
                configuration: BetterVideoPlayerConfiguration(
                  placeholder:
                      Image.network(widget.model.image!, fit: BoxFit.contain),
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => widget.playingIndex == widget.index;
}
