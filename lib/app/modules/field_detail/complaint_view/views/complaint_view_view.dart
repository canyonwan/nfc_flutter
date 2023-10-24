import 'package:flutter/material.dart';

import 'package:bruno/bruno.dart';
import 'package:get/get.dart';

import '../controllers/complaint_view_controller.dart';

class ComplaintViewView extends GetView<ComplaintViewController> {
  const ComplaintViewView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('投诉'), centerTitle: true),
      body: GetBuilder<ComplaintViewController>(builder: (c) {
        return BrnNormalFormGroup(
          children: [
            BrnTextInputFormItem(
              autofocus: true,
              title: "手机号",
              hint: "请输入手机号",
              onChanged: (String newValue) {
                c.phone = newValue;
              },
            ),
            BrnInputText(
              autoFocus: false,
              maxHeight: 200,
              minHeight: 30,
              minLines: 1,
              maxLength: 100,
              textInputAction: TextInputAction.newline,
              maxHintLines: 20,
              hint: '请输入投诉内容',
              padding: EdgeInsets.fromLTRB(20, 10, 20, 14),
              onTextChange: (text) {
                c.content = text;
              },
              onSubmit: (text) {
                c.content = text;
              },
            ),
            BrnBottomButtonPanel(
              mainButtonName: '确定提交',
              mainButtonOnTap: () {
                c.onComplain();
              },
            )
          ],
        );
      }),
    );
  }
}
