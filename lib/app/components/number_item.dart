import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';

typedef clickCallback = void Function(int value);

class NumberItem extends StatefulWidget {
  int number;
  bool isEnable;
  final clickCallback addClick;
  final clickCallback subClick;

  NumberItem({
    Key? key,
    required this.number,
    required this.isEnable,
    required this.addClick,
    required this.subClick,
  }) : super(key: key);

  @override
  _NumberItemState createState() => _NumberItemState();
}

class _NumberItemState extends State<NumberItem> {
  Widget _leftNumber() {
    return GestureDetector(
      onTap: () {
        if (!widget.isEnable) {
          return;
        }
        if (widget.number == 0) {
          showToast('不能再减了!');
          return;
        }
        setState(() {
          widget.number--;
        });
        widget.subClick(widget.number);
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        decoration: BoxDecoration(
          borderRadius:
              const BorderRadius.horizontal(left: Radius.circular(10)),
          border: Border.all(width: 1, color: Colors.black12),
        ),
        child: Container(
          alignment: Alignment.center,
          width: 20,
          height: 20,
          child: const Text(
            "—",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _centerNumber() {
    return Container(
      decoration:
          BoxDecoration(border: Border.all(width: 1, color: Colors.black12)),
      child: Row(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            width: 40,
            height: 20,
            child: Text("${widget.number}"),
            decoration: const BoxDecoration(
              border: Border(
                  left: BorderSide(
                    width: 0.5,
                    color: Colors.black12,
                  ),
                  right: BorderSide(
                    width: 1,
                    color: Colors.black12,
                  )),
            ),
          ),
        ],
      ),
    );
  }

  Widget _rightNumber() {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        if (!widget.isEnable) {
          print("禁止响应");
          return;
        }
        setState(() {
          widget.number++;
        });
        widget.addClick(widget.number);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.horizontal(
            right: Radius.circular(10),
          ),
          border: Border.all(
            width: 1,
            color: Colors.black12,
          ),
        ),
        child: Row(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              width: 20,
              height: 20,
              child: const Text(
                "+",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _leftNumber(),
          _centerNumber(),
          _rightNumber(),
        ],
      ),
    );
  }
}
