import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:mallxx_app/const/colors.dart';

class CommentView extends StatefulWidget {
  const CommentView({Key? key}) : super(key: key);

  @override
  _CommentState createState() => _CommentState();
}

class _CommentState extends State<CommentView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: KWhiteColor,
      ),
      // height: 100,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "evaluation".trArgs(["5"]),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              GestureDetector(
                onTap: () {},
                child: Text(
                  "view_all".tr,
                  style: const TextStyle(color: Colors.red, fontSize: 12),
                ),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(top: 6),
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                        "http://static.a22c.com/202202222126144839.jpeg",
                      ),
                    ),
                    const SizedBox(width: 6),
                    Column(
                      children: [
                        Text("T****l"),
                        Text(
                          "6个月前",
                          style:
                              const TextStyle(fontSize: 10, color: Colors.grey),
                        )
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 6,
                ),
                const Text(
                  "sldjflasjflkasjfjsdlfkjlwjjlj实力的姐夫老师的姐夫来上课姐夫老师姐夫旅顺口姐夫老师剪短发了开始点击三大纪律说发了三大姐夫老师的姐夫蓝色短裤姐夫胃痉挛付尾款姐夫洛杉矶风湿，",
                  style: TextStyle(
                    overflow: TextOverflow.ellipsis,
                  ),
                  maxLines: 2,
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 6),
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                        "http://static.a22c.com/202202222126144839.jpeg",
                      ),
                    ),
                    Column(
                      children: [
                        Text("T****l"),
                        Text(
                          "6个月前",
                          style:
                              const TextStyle(fontSize: 12, color: Colors.grey),
                        )
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 6,
                ),
                const Text(
                  "sldjflasjflkasjfjsdlfkjlwjjlj实力的姐夫老师的姐夫来上课姐夫老师姐夫旅顺口姐夫老师剪短发了开始点击三大纪律说发了三大姐夫老师的姐夫蓝色短裤姐夫胃痉挛付尾款姐夫洛杉矶风湿，",
                  style: TextStyle(
                    overflow: TextOverflow.ellipsis,
                  ),
                  maxLines: 2,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
