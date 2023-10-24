import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/change_pay_pwd_controller.dart';

class ChangePayPwdView extends GetView<ChangePayPwdController> {
  const ChangePayPwdView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ChangePayPwdView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'ChangePayPwdView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
