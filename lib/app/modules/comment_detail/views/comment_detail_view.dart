import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/comment_detail_controller.dart';

class CommentDetailView extends GetView<CommentDetailController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CommentDetailView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'CommentDetailView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
