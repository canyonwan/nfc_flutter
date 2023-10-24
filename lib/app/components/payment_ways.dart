import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:mallxx_app/const/colors.dart';

typedef onClick = Future Function(String wayCode);

class PaymentWays extends StatefulWidget {
  String wayCode;
  final onClick onChooseWay;
  PaymentWays({Key? key, required this.wayCode, required this.onChooseWay})
      : super(key: key);

  @override
  State<PaymentWays> createState() => _PaymentWaysState();
}

class _PaymentWaysState extends State<PaymentWays> {
  List<WayModel> ways = [
    WayModel('微信', '1'),
    WayModel('其他', '2'),
    WayModel('支付宝', '3'),
    WayModel('余额', '4'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('请选择支付方式')),
      body: Container(
        color: KWhiteColor,
        child: ListView.separated(
          separatorBuilder: (_, __) => Divider(),
          itemCount: ways.length,
          itemBuilder: (_, int idx) {
            if (ways.length == idx) {
              return Container(
                child: Text(
                  '确定',
                  style: TextStyle(),
                ),
              );
            }
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    ways[idx].wayName,
                    style:
                        TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
                  ),
                  Checkbox(
                    tristate: true,
                    shape: const CircleBorder(),
                    activeColor: kAppColor,
                    checkColor: KWhiteColor,
                    hoverColor: KWhiteColor,
                    focusColor: kAppColor,
                    side: const BorderSide(color: Colors.grey, width: 1),
                    value: widget.wayCode == ways[idx].wayCode,
                    onChanged: (bool? value) {
                      setState(() {
                        widget.wayCode = ways[idx].wayCode;
                      });
                      widget.onChooseWay(ways[idx].wayCode);
                    },
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class WayModel {
  String wayName, wayCode;
  WayModel(this.wayName, this.wayCode);
}
