import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/image_text_upload_controller.dart';

class ImageTextUploadView extends GetView<ImageTextUploadController> {
  const ImageTextUploadView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ImageTextUploadView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'ImageTextUploadView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
