import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:panorama/panorama.dart';

import 'package:mallxx_app/const/colors.dart';

import '../controllers/vr360_controller.dart';

class Vr360View extends GetView<Vr360Controller> {
  const Vr360View({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('全景互动'), centerTitle: true),
      body: GetBuilder<Vr360Controller>(builder: (c) {
        return c.currentUrl == ''
            ? Center(child: CircularProgressIndicator())
            : ConstrainedBox(
                constraints: const BoxConstraints.expand(),
                child: Stack(
                  alignment: Alignment.center,
                  fit: StackFit.expand,
                  children: [
                    Panorama(
                      zoom: 1,
                      child: Image.network(c.currentUrl),
                    ),
                    Positioned(
                      top: 20.w,
                      right: 20.w,
                      child: Container(
                        height: 200.h,
                        width: 100.w,
                        child: ListView.builder(
                          itemCount: c.vrList.length,
                          itemBuilder: (_, int index) {
                            return GestureDetector(
                              onTap: () =>
                                  c.changeVRUrl(c.vrList[index].image!),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 4.w, vertical: 6.w),
                                alignment: Alignment.center,
                                color: c.vrList[index].image == c.currentUrl
                                    ? Colors.black
                                    : Color.fromRGBO(255, 255, 255, .2),
                                child: Text(
                                  '${c.vrList[index].name}',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 12.sp, color: KWhiteColor),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    )
                  ],
                ),
              );
      }),
    );
  }
}
