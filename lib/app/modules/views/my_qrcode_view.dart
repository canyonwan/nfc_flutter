import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mallxx_app/app/models/qr_code_model.dart';

class MyQrcodeView extends GetView {
  final MyQRCodeDataModel data;

  const MyQrcodeView(this.data, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('识别码'), centerTitle: true),
      body: Center(
        child: Column(
          children: [
            Image.network('${data.yiImg}',width: 220.w),
            Image.network('${data.erImg}', width: 220.w),
          ],
        ),
      ),
    );
  }
}
