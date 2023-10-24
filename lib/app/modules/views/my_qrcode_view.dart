import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mallxx_app/app/models/qr_code_model.dart';

class MyQrcodeView extends GetView {
  final MyQRCodeDataModel data;

  const MyQrcodeView(this.data, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('${data}');
    return Scaffold(
      appBar: AppBar(title: const Text('我的二维码'), centerTitle: true),
      body: Column(
        children: [
          Center(
            child: Image.network('${data.yiImg}'),
          ),
          Center(
            child: Image.network('${data.erImg}', width: 220.w),
          ),
        ],
      ),
    );
  }
}
