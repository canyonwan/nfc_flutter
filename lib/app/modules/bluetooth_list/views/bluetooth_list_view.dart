import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

import 'package:get/get.dart';

import '../controllers/bluetooth_list_controller.dart';
import 'ScanScreen.dart';
import 'bluetooth_off_screen.dart';

class BluetoothListView extends GetView<BluetoothListController> {
  const BluetoothListView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Widget screen = controller.adapterState == BluetoothAdapterState.on
        ? const ScanScreen()
        : BluetoothOffScreen(adapterState: controller.adapterState);

    return Scaffold(
      appBar: AppBar(title: const Text('蓝牙列表'), centerTitle: true),
      body: screen,
    );
  }
}
