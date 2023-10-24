import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/my_assets_controller.dart';

class MyAssetsView extends GetView<MyAssetsController> {
  const MyAssetsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MyAssetsView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'MyAssetsView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
