import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mallxx_app/const/colors.dart';

import '../controllers/image_text_upload_controller.dart';

class ImageTextUploadView extends GetView<ImageTextUploadController> {
  const ImageTextUploadView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('广告动态编辑')),
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.w),
        child: GetBuilder<ImageTextUploadController>(builder: (c) {
          return ListView(
            children: [
              BrnInputText(
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
              Divider(),
              BrnInputText(
                  maxHeight: 200,
                  minHeight: 20,
                  minLines: 1,
                  maxLength: 10,
                  textString: c.params.shareExplain,
                  textInputAction: TextInputAction.newline,
                  maxHintLines: 20,
                  hint: '编辑描述',
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 14),
                  onTextChange: (text) {
                    c.params.shareExplain = text;
                  }),
              Divider(),
              BrnInputText(
                maxHeight: 400,
                minHeight: 20,
                minLines: 8,
                maxLength: 1000,
                textString: c.params.content,
                textInputAction: TextInputAction.newline,
                maxHintLines: 20,
                hint: '编辑文字',
                padding: EdgeInsets.fromLTRB(20, 10, 20, 14),
                onTextChange: (text) {
                  c.params.content = text;
                },
              ),
              Divider(),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 20.w),
                child: GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 10.w,
                    crossAxisSpacing: 10.w,
                    childAspectRatio: 1.2,
                  ),
                  itemCount: c.imageList.length < c.maxUpload
                      ? c.imageList.length + 1
                      : c.imageList.length,
                  itemBuilder: (context, index) {
                    if (index == c.imageList.length) {
                      return GestureDetector(
                        onTap: c.onUploadImage,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(0xffF7F8FA),
                            borderRadius: BorderRadius.circular(7.w),
                          ),
                          child: Icon(Icons.camera_alt, color: Colors.grey),
                        ),
                      );
                    }
                    return Stack(
                      fit: StackFit.expand,
                      children: [
                        GestureDetector(
                          onTap: () {
                            c.onZoomImage(c.imageList[index]);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5.w),
                            ),
                            child: Image(
                              image: NetworkImage(c.imageList[index]),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        Positioned(
                          right: 0,
                          top: 0,
                          child: GestureDetector(
                            onTap: () {
                              c.onRemoveImage(index);
                            },
                            child: Container(
                              width: 20.w,
                              height: 20.w,
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(10.w),
                              ),
                              child: Icon(
                                Icons.close,
                                color: Colors.white,
                                size: 16.w,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              Divider(),
              Container(
                margin: EdgeInsets.only(left: 10.w, top: 20.w),
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
              ).paddingSymmetric(vertical: 20.w),
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
      child: GetBuilder<ImageTextUploadController>(
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
