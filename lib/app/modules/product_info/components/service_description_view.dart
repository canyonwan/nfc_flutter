import 'package:flutter/material.dart';

import 'package:get/get.dart';

class ServiceDescriptionView extends StatelessWidget {
  const ServiceDescriptionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(
              width: 50,
            ),
            Expanded(
              flex: 1,
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  "service_description".tr,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(
                Icons.close,
                size: 25,
              ),
            )
          ],
        ),
        Container(
          height: 1,
          width: double.infinity,
          color: Colors.grey,
        ),
        Container(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
          child: const Text(
            "30天无忧退货",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
          child: const Text(
            "自收到商品之日起30天内，可在线申请无忧退货服务（内裤、食品等特殊商品除外）。",
            style: TextStyle(
              fontSize: 14,
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
          child: const Text(
            "48小时快速退款",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
          child: const Text(
            "收到退货包裹并确认无误后，将在48小时内办理退款，退款将原路返回，不同银行处理时间不同，预计1-5个工作日到账。",
            style: TextStyle(
              fontSize: 14,
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
          child: const Text(
            "满88元免邮费",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
          child: const Text(
            "单笔订单金额(不含运费)满88元可免邮费，不满88元，单笔订单收取10元邮费。",
            style: TextStyle(
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }
}
