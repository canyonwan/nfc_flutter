//-------------------//
//VIDEO EDITOR SCREEN//
//-------------------//
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:mallxx_app/app/modules/video_upload/views/widgets/export_result.dart';
import 'package:mallxx_app/const/colors.dart';
import 'package:oktoast/oktoast.dart';
import 'package:video_editor/video_editor.dart';

import '../../root/providers/field_provider.dart';
import 'export_service.dart';

class VideoEditorView extends StatefulWidget {
  const VideoEditorView({key, required this.file});

  final File file;

  @override
  State<VideoEditorView> createState() => _VideoEditorViewState();
}

class _VideoEditorViewState extends State<VideoEditorView> {
  final _exportingProgress = ValueNotifier<double>(0.0);
  final _isExporting = ValueNotifier<bool>(false);
  final double height = 60;

  late final VideoEditorController _controller = VideoEditorController.file(
    widget.file,
    minDuration: const Duration(seconds: 1),
    maxDuration: const Duration(seconds: 100),
  );

  @override
  void initState() {
    super.initState();
    _controller.initialize(aspectRatio: 9 / 16).then((_) {
      if (_controller.videoDuration.inSeconds > 120) {
        showToast('视频时长不能超过2分钟');
        Navigator.pop(context);
        return;
      }
      setState(() {});
    }).catchError((error) {
      // handle minumum duration bigger than video duration error
      Navigator.pop(context);
    }, test: (e) => e is VideoMinDurationError);
  }

  @override
  void dispose() async {
    _exportingProgress.dispose();
    _isExporting.dispose();
    _controller.dispose();
    ExportService.dispose();
    super.dispose();
  }

  final FieldProvider fieldProvider = Get.find<FieldProvider>();

  void _showErrorSnackBar(String message) =>
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          duration: const Duration(seconds: 1),
        ),
      );

  void _exportVideo() async {
    _exportingProgress.value = 0;
    _isExporting.value = true;

    final config = VideoFFmpegVideoEditorConfig(_controller);

    await ExportService.runFFmpegCommand(
      await config.getExecuteConfig(),
      onProgress: (stats) {
        _exportingProgress.value =
            config.getFFmpegProgress(stats.getTime().ceil());
      },
      onError: (e, s) => _showErrorSnackBar("视频导出错误${e} :("),
      onCompleted: (file) async {
        _isExporting.value = false;
        if (!mounted) return;
        EasyLoading.show(status: '上传中');
        debugPrint('file: $file');
        var res = await fieldProvider.uploadVideo(file);
        debugPrint('res: $res');
        if (res.code == 200) {
          Get.back(result: res.data);
          // params.videoImage = res.data.imageUrl;
          // params.videoFile = res.data.fileUrl;
        } else {
          showToast('上传失败:${res.msg}');
          EasyLoading.dismiss();
        }
      },
    );
  }

  void _exportCover() async {
    final config = CoverFFmpegVideoEditorConfig(_controller);
    final execute = await config.getExecuteConfig();
    if (execute == null) {
      _showErrorSnackBar("Error on cover exportation initialization.");
      return;
    }

    await ExportService.runFFmpegCommand(
      execute,
      onError: (e, s) => _showErrorSnackBar("Error on cover exportation :("),
      onCompleted: (cover) {
        if (!mounted) return;

        showDialog(
          context: context,
          builder: (_) => CoverResultPopup(cover: cover),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: _controller.initialized
            ? SafeArea(
                child: Stack(
                  children: [
                    Column(
                      children: [
                        _topNavBar(),
                        Expanded(
                          child: DefaultTabController(
                            length: 1,
                            child: Column(
                              children: [
                                Expanded(
                                  child: TabBarView(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    children: [
                                      Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          CropGridViewer.preview(
                                              controller: _controller),
                                          AnimatedBuilder(
                                            animation: _controller.video,
                                            builder: (_, __) => AnimatedOpacity(
                                              opacity:
                                                  _controller.isPlaying ? 0 : 1,
                                              duration: kThemeAnimationDuration,
                                              child: GestureDetector(
                                                onTap: _controller.video.play,
                                                child: Container(
                                                  width: 40,
                                                  height: 40,
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: Colors.white,
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: const Icon(
                                                    Icons.play_arrow,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      CoverViewer(controller: _controller)
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 200,
                                  margin: const EdgeInsets.only(top: 10),
                                  child: Column(
                                    children: [
                                      TabBar(
                                        indicatorColor: kAppColor,
                                        tabs: [
                                          Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: const [
                                                Padding(
                                                    padding: EdgeInsets.all(5),
                                                    child: Icon(
                                                        Icons.content_cut)),
                                                Text('裁剪')
                                              ]),
                                          // Row(
                                          //   mainAxisAlignment:
                                          //       MainAxisAlignment.center,
                                          //   children: const [
                                          //     Padding(
                                          //         padding: EdgeInsets.all(5),
                                          //         child:
                                          //             Icon(Icons.video_label)),
                                          //     Text('封面')
                                          //   ],
                                          // ),
                                        ],
                                      ),
                                      Expanded(
                                        child: TabBarView(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          children: [
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: _trimSlider(),
                                            ),
                                            // _coverSelection(),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                ValueListenableBuilder(
                                  valueListenable: _isExporting,
                                  builder: (_, bool export, Widget? child) =>
                                      AnimatedSize(
                                    duration: kThemeAnimationDuration,
                                    child: export ? child : null,
                                  ),
                                  child: AlertDialog(
                                    title: ValueListenableBuilder(
                                      valueListenable: _exportingProgress,
                                      builder: (_, double value, __) => Text(
                                        "正在导出视频 ${(value * 100).ceil()}%",
                                        style: const TextStyle(fontSize: 12),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              )
            : const Center(child: CircularProgressIndicator()),
      ),
    );
  }

  Widget _topNavBar() {
    return SafeArea(
      child: SizedBox(
        height: height,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.arrow_back_ios),
                tooltip: '退出',
              ),
            ),
            // const VerticalDivider(endIndent: 22, indent: 22),
            // Expanded(
            //   child: IconButton(
            //     onPressed: () =>
            //         _controller.rotate90Degrees(RotateDirection.left),
            //     icon: const Icon(Icons.rotate_left),
            //     tooltip: 'Rotate unclockwise',
            //   ),
            // ),
            // Expanded(
            //   child: IconButton(
            //     onPressed: () =>
            //         _controller.rotate90Degrees(RotateDirection.right),
            //     icon: const Icon(Icons.rotate_right),
            //     tooltip: 'Rotate clockwise',
            //   ),
            // ),
            // Expanded(
            //   child: IconButton(
            //     onPressed: () => Navigator.push(
            //       context,
            //       MaterialPageRoute<void>(
            //         builder: (context) => CropPage(controller: _controller),
            //       ),
            //     ),
            //     icon: const Icon(Icons.crop),
            //     tooltip: 'Open crop screen',
            //   ),
            // ),
            // const VerticalDivider(endIndent: 22, indent: 22),
            Expanded(
              child: IconButton(
                onPressed: _exportVideo,
                icon: const Icon(Icons.drive_folder_upload_outlined),
                tooltip: '导出',
              ),
              // child: PopupMenuButton(
              //   tooltip: '导出',
              //   icon: const Icon(Icons.drive_folder_upload_outlined),
              //   itemBuilder: (context) => [
              //     // PopupMenuItem(
              //     //   onTap: _exportCover,
              //     //   child: const Text('Export cover'),
              //     // ),
              //     PopupMenuItem(
              //       onTap: _exportVideo,
              //       child: const Text('导出视频'),
              //     ),
              //   ],
              // ),
            ),
          ],
        ),
      ),
    );
  }

  String formatter(Duration duration) => [
        duration.inMinutes.remainder(60).toString().padLeft(2, '0'),
        duration.inSeconds.remainder(60).toString().padLeft(2, '0')
      ].join(":");

  List<Widget> _trimSlider() {
    return [
      AnimatedBuilder(
        animation: Listenable.merge([
          _controller,
          _controller.video,
        ]),
        builder: (_, __) {
          final int duration = _controller.videoDuration.inSeconds;
          final double pos = _controller.trimPosition * duration;

          return Padding(
            padding: EdgeInsets.symmetric(horizontal: height / 4),
            child: Row(children: [
              Text(formatter(Duration(seconds: pos.toInt()))),
              const Expanded(child: SizedBox()),
              AnimatedOpacity(
                opacity: _controller.isTrimming ? 1 : 0,
                duration: kThemeAnimationDuration,
                child: Row(mainAxisSize: MainAxisSize.min, children: [
                  Text(formatter(_controller.startTrim)),
                  const SizedBox(width: 10),
                  Text(formatter(_controller.endTrim)),
                ]),
              ),
            ]),
          );
        },
      ),
      Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.symmetric(vertical: height / 4),
        child: TrimSlider(
          controller: _controller,
          height: height,
          horizontalMargin: height / 4,
          child: TrimTimeline(
            controller: _controller,
            padding: const EdgeInsets.only(top: 10),
          ),
        ),
      )
    ];
  }

  Widget _coverSelection() {
    return SingleChildScrollView(
      child: Center(
        child: Container(
          margin: const EdgeInsets.all(15),
          child: CoverSelection(
            controller: _controller,
            size: height + 10,
            quantity: 8,
            selectedCoverBuilder: (cover, size) {
              return Stack(
                alignment: Alignment.center,
                children: [
                  cover,
                  Icon(
                    Icons.check_circle,
                    color: const CoverSelectionStyle().selectedBorderColor,
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
