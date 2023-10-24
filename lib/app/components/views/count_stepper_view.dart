import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

typedef onValueChange = void Function(int value);

class CountStepper extends StatefulWidget {
  int count;
  final TextEditingController textEditingController;
  final onValueChange onIncrement;
  final onValueChange onDecrement;

  CountStepper(
      {Key? key,
      required this.count,
      required this.onIncrement,
      required this.onDecrement,
      required this.textEditingController})
      : super(key: key);

  @override
  State<CountStepper> createState() => _CountStepperState();
}

class _CountStepperState extends State<CountStepper> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      margin: EdgeInsets.symmetric(vertical: 14.h),
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xff666666)),
        borderRadius: BorderRadius.circular(6.w),
      ),
      child: Row(
        children: [_decrement, _count, _increment],
      ),
    );
  }

  Widget get _decrement {
    return GestureDetector(
      // onTap: () => controller.onDecrement(1, 1),
      onTap: () {
        if (widget.count > 1) {
          setState(() {
            widget.count--;
          });
        }
        widget.onDecrement(widget.count);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 6.5.h),
        decoration: BoxDecoration(
          border: Border(right: BorderSide(color: Color(0xff666666))),
        ),
        child: Text(
          '-',
          style: TextStyle(fontSize: 18.sp, color: Color(0xff999999)),
        ),
      ),
    );
  }

  Widget get _count {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        child: TextField(
          controller: widget.textEditingController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.zero,
            isDense: true,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
          ),
        ),
      ),
    );
  }

  Widget get _increment {
    return GestureDetector(
      // onTap: () => controller.onIncrement(1, id),
      onTap: () {
        // if (!widget.isEnable) {
        //   print("禁止响应");
        //   return;
        // }
        setState(() {
          widget.count++;
        });
        widget.onDecrement(widget.count);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 6.5.h),
        decoration: BoxDecoration(
          border: Border(left: BorderSide(color: Color(0xff666666))),
        ),
        child: Text(
          '+',
          style: TextStyle(fontSize: 18.sp, color: Color(0xff999999)),
        ),
      ),
    );
  }
}
