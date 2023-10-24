import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/payment_options_controller.dart';

class PaymentOptionsView extends GetView<PaymentOptionsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PaymentOptionsView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'PaymentOptionsView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
