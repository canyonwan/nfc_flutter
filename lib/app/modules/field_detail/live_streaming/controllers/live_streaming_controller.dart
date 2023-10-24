import 'package:get/get.dart';

// import 'package:live_flutter_plugin/v2_tx_live_code.dart';
// import 'package:live_flutter_plugin/v2_tx_live_player.dart';
// import 'package:live_flutter_plugin/v2_tx_live_player_observer.dart';

class LiveStreamingController extends GetxController {
  int? localViewId;

  bool isPlaying = false;
  String liveUrl = '';

  // V2TXLivePlayer? livePlayer;

  @override
  void onInit() {
    liveUrl = Get.arguments['liveUrl'];
    initPlayer();
    super.onInit();
  }

  @override
  void onClose() {
    // livePlayer?.removeListener(onPlayerObserver);
    // livePlayer?.stopPlay();
    // livePlayer?.destroy();
    super.onClose();
  }

  /// 初始化V2TXLivePlayer
  Future<void> initPlayer() async {
    // livePlayer = await V2TXLivePlayer.create();
    // livePlayer?.addListener(onPlayerObserver);
  }

  void onViewCreated(viewId) {
    localViewId = viewId;
    update();
  }

  /// Player 回调
  // onPlayerObserver(V2TXLivePlayerListenerType type, param) {}

  /// 开始拉流
  Future<void> startPlay() async {
    if (isPlaying) {
      return;
    }
    if (localViewId != null) {
      // var code = await livePlayer?.setRenderViewID(localViewId!);
      // if (code != V2TXLIVE_OK) {
      // } else {
      // 生成拉流url RTMP/TRTC/Led
      // 开始拉流
      // V2TXLiveCode code = await livePlayer!.startPlay(liveUrl);
      // V2TXLiveCode code = await livePlayer!.startLivePlay(liveUrl);
      // isPlaying = code == V2TXLIVE_OK;
      // update(['updateLivePlaying']);
      // }
    }
  }

  /// 停止拉流
  Future<void> stopPlay() async {
    //   V2TXLiveCode code = await livePlayer!.stopPlay();
    //   isPlaying = !(code == V2TXLIVE_OK);
    //   update(['updateLivePlaying']);
  }
}
