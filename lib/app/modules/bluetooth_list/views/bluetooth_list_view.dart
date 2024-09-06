import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/bluetooth_list_controller.dart';

class BluetoothListView extends GetView<BluetoothListController> {
  const BluetoothListView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BluetoothListView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'BluetoothListView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
