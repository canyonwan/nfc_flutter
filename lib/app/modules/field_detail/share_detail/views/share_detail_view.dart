import 'package:flutter/material.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/getwidget.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:mallxx_app/const/colors.dart';
import 'package:get/get.dart';

import '../controllers/share_detail_controller.dart';

class ShareDetailView extends GetView<ShareDetailController> {
  const ShareDetailView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('编辑详情'),
          centerTitle: true,
          actions: [
            GFButton(
              size: GFSize.MEDIUM,
              onPressed: controller.onSubmit,
              text: '提交',
              color: KWhiteColor,
              type: GFButtonType.transparent,
            ),
          ],
        ),
        body: GetBuilder<ShareDetailController>(builder: (_) {
          return Column(
            children: [
              HtmlEditor(
                controller: _.controller, //required
                callbacks: Callbacks(
                  onChangeContent: (String? changedContent) {
                    _.value = changedContent!;
                  },
                ),
                htmlEditorOptions: HtmlEditorOptions(
                  hint: "请输入说明",
                  initialText: _.detail,
                ),
                htmlToolbarOptions: HtmlToolbarOptions(
                  toolbarPosition: ToolbarPosition.aboveEditor,
                  toolbarType: ToolbarType.nativeExpandable,
                ),
              ),
            ],
          );
        }));
  }
}
