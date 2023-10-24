import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/country_region_controller.dart';

class CountryRegionView extends GetView<CountryRegionController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CountryRegionView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'CountryRegionView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
