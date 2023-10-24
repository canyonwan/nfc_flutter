import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/land_list_controller.dart';

class LandListView extends GetView<LandListController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MessageCenterView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'MessageCenterView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
