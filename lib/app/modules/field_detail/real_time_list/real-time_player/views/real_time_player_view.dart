import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_ys7/flutter_ys7.dart';
import 'package:get/get.dart';
import 'package:mallxx_app/const/colors.dart';

import '../controllers/real_time_player_controller.dart';

class RealTimePlayerView extends GetView<RealTimePlayerController> {
  const RealTimePlayerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<RealTimePlayerController>(builder: (c) {
        return Stack(
          children: [
            // Ys7VideoView(),
            Positioned(
              bottom: 0,
              right: 110.w,
              child: IconButton(
                icon: Icon(Icons.fullscreen_exit_outlined),
                color: KWhiteColor,
                onPressed: () {
                  c.exitFullScreen();
                },
              ),
            ),
          ],
        );
      }),
    );
  }
}
