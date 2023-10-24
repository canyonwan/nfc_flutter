import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/my_comment_controller.dart';

class MyCommentView extends GetView<MyCommentController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MyCommentView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'MyCommentView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
