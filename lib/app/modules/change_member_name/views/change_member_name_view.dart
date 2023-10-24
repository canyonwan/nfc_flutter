import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:mallxx_app/const/colors.dart';

import '../controllers/change_member_name_controller.dart';

class ChangeMemberNameView extends GetView<ChangeMemberNameController> {
  const ChangeMemberNameView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('修改用户名'),
        centerTitle: true,
        actions: [
          GFButton(
            onPressed: controller.onSubmit,
            text: '提交',
            color: KWhiteColor,
            type: GFButtonType.transparent,
          ),
        ],
      ),
      body: GetBuilder<ChangeMemberNameController>(builder: (c) {
        return BrnInputText(
          textEditingController: c.textEditingController,
          autoFocus: true,
          maxHeight: 200,
          minHeight: 30,
          minLines: 1,
          maxLength: 100,
          textInputAction: TextInputAction.newline,
          maxHintLines: 20,
          hint: '请输入用户名',
          padding: EdgeInsets.fromLTRB(20, 10, 20, 14),
          onTextChange: (text) {
            c.name = text;
          },
          onSubmit: (text) {
            c.name = text;
          },
        );
      }),
    );
  }
}
