import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/order_deliver_controller.dart';

class OrderDeliverView extends GetView<OrderDeliverController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('OrderDeliverView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'OrderDeliverView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
