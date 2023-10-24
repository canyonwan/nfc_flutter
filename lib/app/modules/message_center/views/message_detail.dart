import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:mallxx_app/app/models/notice_list_model.dart';
import 'package:mallxx_app/app/modules/root/providers/member_provider.dart';
import 'package:mallxx_app/const/colors.dart';

class MessageDetail extends StatefulWidget {
  final int id;
  final int type;

  const MessageDetail({Key? key, required this.id, required this.type})
      : super(key: key);

  @override
  State<MessageDetail> createState() => _MessageDetailState();
}

class _MessageDetailState extends State<MessageDetail> {
  MemberProvider memberProvider = Get.find<MemberProvider>();
  MessageDetailDataModel? data;

  @override
  void initState() {
    getMessageDetail();
    super.initState();
  }

  Future<void> getMessageDetail() async {
    final res = await memberProvider.queryMessageDetail(widget.type, widget.id);
    if (res.code == 200) {
      data = res.data!;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(data == null ? '' : data!.title!)),
      body: data == null
          ? BrnPageLoading()
          : Container(
              color: KWhiteColor,
              child: HtmlWidget(data?.content ?? ''),
            ),
    );
  }
}
