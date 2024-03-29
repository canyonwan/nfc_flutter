import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mallxx_app/app/models/field_detail_model.dart';
import 'package:mallxx_app/const/colors.dart';

typedef onValueChangeCallback = void Function(OptionItemModel);

class BuildOptionItem extends StatefulWidget {
  final OptionItemModel item;
  final int disabled;
  final onValueChangeCallback onValueChange;

  const BuildOptionItem({
    Key? key,
    required this.item,
    required this.onValueChange,
    required this.disabled,
  }) : super(key: key);
  @override
  _BuildOptionItemState createState() => _BuildOptionItemState();
}

class _BuildOptionItemState extends State<BuildOptionItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10.w, bottom: 6.h),
      child: BrnRadioButton(
        crossAxisAlignment: CrossAxisAlignment.start,
        radioIndex: widget.item.id!,
        disable: widget.disabled != 1,
        isSelected: widget.item.ifCheck == 1,
        mainAxisSize: MainAxisSize.max,
        child: Expanded(
          child: Text(
            '${widget.item.id}. ${widget.item.name}',
            style: TextStyle(color: kAppGrey66Color, fontSize: 15.sp),
          ),
        ),
        onValueChangedAtIndex: (index, value) {
          widget.item.ifCheck = 1;
          widget.onValueChange(widget.item);
        },
      ),
    );
  }
}
