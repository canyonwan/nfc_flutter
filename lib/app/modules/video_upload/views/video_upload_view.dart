import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mallxx_app/const/colors.dart';

import '../controllers/video_upload_controller.dart';

class VideoUploadView extends GetView<VideoUploadController> {
  const VideoUploadView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text('视频发布')),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.w),
        child: GetBuilder<VideoUploadController>(builder: (c) {
          return ListView(
            children: [
              Row(
                children: [
                  Expanded(
                    child: BrnInputText(
                      maxHeight: 200,
                      minHeight: 20,
                      minLines: 1,
                      maxLength: 10,
                      textString: c.params.title,
                      textInputAction: TextInputAction.newline,
                      maxHintLines: 20,
                      hint: '编辑标题',
                      padding: EdgeInsets.fromLTRB(20, 10, 20, 14),
                      onTextChange: (text) {
                        c.params.title = text;
                      },
                    ),
                  ),
                  if (c.params.videoImage != '')
                    Container(
                      margin: EdgeInsets.only(right: 12.w),
                      width: 100.w,
                      height: 100.w,
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.w),
                      ),
                      child: Stack(
                        children: [
                          GestureDetector(
                            onTap: c.onUploadVideo,
                            child: Image(
                              image: NetworkImage(c.params.videoImage),
                              width: double.infinity,
                              height: 100.w,
                              fit: BoxFit.fill,
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: GestureDetector(
                              onTap: c.onUploadCover,
                              child: Container(
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(
                                    vertical: 6.h, horizontal: 4.w),
                                color: Color(0x90000000),
                                child: Text(
                                  '选封面',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12.sp,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  else
                    GestureDetector(
                      onTap: c.onUploadVideo,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 26.h, horizontal: 40.w),
                        decoration: BoxDecoration(
                          color: Color(0xffF7F8FA),
                          borderRadius: BorderRadius.circular(6.w),
                        ),
                        child: Icon(
                          Icons.camera_alt,
                          color: Color(0xffDCDEE0),
                          size: 30.w,
                        ),
                      ),
                    )
                ],
              ),
              Divider(),
              BrnInputText(
                  maxHeight: 80,
                  minHeight: 10,
                  minLines: 1,
                  maxLength: 10,
                  textString: c.params.weigh,
                  textInputAction: TextInputAction.newline,
                  maxHintLines: 20,
                  hint: '请输入排序，如0-99',
                  onTextChange: (text) {
                    controller.params.weigh = text;
                  }).paddingSymmetric(horizontal: 18.w),
              Divider(),
              Container(
                margin: EdgeInsets.only(left: 10.w),
                child: Wrap(
                  children: c.labelList.map((e) => TagItem(e)).toList(),
                ),
              ),
              Row(
                children: <Widget>[
                  SizedBox(width: 12.w),
                  BrnRadioButton(
                    radioIndex: 1,
                    isSelected: c.params.ifPrivate == 1,
                    child: Padding(
                      padding: EdgeInsets.only(left: 5),
                      child: Text("公开"),
                    ),
                    onValueChangedAtIndex: (index, value) {
                      c.onRadioChange(index);
                    },
                  ),
                  SizedBox(width: 20),
                  BrnRadioButton(
                    radioIndex: 2,
                    isSelected: c.params.ifPrivate == 2,
                    child: Padding(
                      padding: EdgeInsets.only(left: 5),
                      child: Text('私密'),
                    ),
                    onValueChangedAtIndex: (index, value) {
                      c.onRadioChange(index);
                    },
                  ),
                ],
              ).paddingSymmetric(vertical: 10.w),
              BrnBigMainButton(
                title: '确认发布',
                onTap: controller.onSubmit,
              ).paddingSymmetric(horizontal: 12.w, vertical: 20.w),
            ],
          );
        }),
      ),
    );
  }

  Widget TagItem(item) {
    return GestureDetector(
      onTap: () {
        controller.onSelectTags(item.id);
      },
      child: GetBuilder<VideoUploadController>(
        id: 'update_tag',
        builder: (c) {
          return Container(
            constraints: BoxConstraints(minWidth: 50.w),
            decoration: BoxDecoration(
              color: c.tagList.contains(item.id) ? (kAppColor) : Colors.white,
              borderRadius: BorderRadius.circular(4.w),
              border: Border.all(
                  color: c.tagList.contains(item.id)
                      ? Colors.transparent
                      : kAppColor,
                  width: 1.w),
            ),
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 5.w),
            margin: EdgeInsets.only(right: 10.w, bottom: 10.w),
            child: Center(
              widthFactor: 1,
              child: Text(
                item.name,
                style: TextStyle(
                  color: c.tagList.contains(item.id) ? Colors.white : kAppColor,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
