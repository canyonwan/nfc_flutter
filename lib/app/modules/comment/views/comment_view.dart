import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/comment_controller.dart';

class CommentView extends GetView<CommentController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CommentView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'CommentView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
