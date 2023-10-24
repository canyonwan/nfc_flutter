import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/privacy_policy_controller.dart';

class PrivacyPolicyView extends GetView<PrivacyPolicyController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PrivacyPolicyView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'PrivacyPolicyView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
