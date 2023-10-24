import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/account_security_controller.dart';

class AccountSecurityView extends GetView<AccountSecurityController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AccountSecurityView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'AccountSecurityView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
