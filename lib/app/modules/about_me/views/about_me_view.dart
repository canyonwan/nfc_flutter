import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mallxx_app/app/modules/about_me/controllers/about_me_controller.dart';

class AboutMeView extends GetView<AboutMeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('关于农副仓'), centerTitle: true),
    );
  }
}
