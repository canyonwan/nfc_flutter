import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '/app/models/product_model.dart';

class AttributeView extends StatefulWidget {
  final List<Parameters> list;
  const AttributeView({Key? key, required this.list}) : super(key: key);

  @override
  _AttributeViewState createState() => _AttributeViewState();
}

class _AttributeViewState extends State<AttributeView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
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
                    "product_parameters".tr,
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
            color: Colors.grey,
            width: double.infinity,
            height: 1,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 2,
            // width: double.infinity,
            child: ListView.builder(
              itemCount: widget.list.length,
              itemBuilder: (context, index) {
                Parameters item = widget.list[index];
                return Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.black,
                        width: 0.2,
                      ),
                    ),
                  ),
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 2,
                        alignment: Alignment.center,
                        child: Text(
                          item.key!,
                          style: const TextStyle(
                            color: Colors.black54,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 2,
                        alignment: Alignment.center,
                        child: Text(
                          item.value!,
                          style: const TextStyle(
                            color: Colors.black54,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
