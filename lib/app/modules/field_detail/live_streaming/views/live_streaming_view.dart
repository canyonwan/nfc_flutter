import 'package:flutter/material.dart';
import 'package:get/get.dart';

// import 'package:live_flutter_plugin/widget/v2_tx_live_video_widget.dart';

import '../controllers/live_streaming_controller.dart';

class LiveStreamingView extends GetView<LiveStreamingController> {
  const LiveStreamingView({Key? key}) : super(key: key);

  /// 视频渲染View Widget
  Widget _renderView() {
    return GetBuilder<LiveStreamingController>(builder: (c) {
      return Container(
        color: Colors.black,
        // child: V2TXLiveVideoWidget(
        //   onViewCreated: (viewId) {
        //     c.onViewCreated(viewId);
        //   },
        // ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('FieldLiveView'), centerTitle: true),
      body: ConstrainedBox(
        constraints: const BoxConstraints.expand(),
        child: Stack(
          alignment: Alignment.center,
          fit: StackFit.expand,
          children: [
            _renderView(),
            _buildPlayButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildPlayButton() {
    return GetBuilder<LiveStreamingController>(
        id: 'updateLivePlaying',
        builder: (c) {
          return Positioned(
            bottom: 40.0,
            left: 20,
            width: 100,
            child: ElevatedButton(
              child: Text(
                c.isPlaying ? '停止拉流' : '开始拉流',
                style: const TextStyle(fontSize: 15),
              ),
              onPressed: () {
                c.isPlaying ? c.stopPlay() : c.startPlay();
              },
            ),
          );
        });
  }
}
