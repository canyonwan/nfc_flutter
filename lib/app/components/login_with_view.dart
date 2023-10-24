import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluwx/fluwx.dart' as fluwx;
import 'package:oktoast/oktoast.dart';

class LoginWithView extends StatelessWidget {
  const LoginWithView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // GestureDetector(
          //   onTap: () {},
          //   child: Container(
          //     margin: EdgeInsets.symmetric(horizontal: 5),
          //     width: 30,
          //     height: 30,
          //     child: Image.asset(
          //       "assets/icons/google.png",
          //       // scale: 6,
          //     ),
          //   ),
          // ),
          // GestureDetector(
          //   onTap: () {},
          //   child: Container(
          //     margin: EdgeInsets.symmetric(horizontal: 5),
          //     width: 30,
          //     height: 30,
          //     child: Image.asset(
          //       "assets/icons/facebook.png",
          //       // scale: 6,
          //     ),
          //   ),
          // ),
          GestureDetector(
            onTap: () {
              fluwx
                  .sendWeChatAuth(
                      scope: "snsapi_userinfo", state: "wechat_sdk_demo_test")
                  .then((data) {
                if (!data) {
                  showToast("没有安装微信，请安装微信后使用该功能");
                }
                showToast("微信登录");
                print('微信登录：$data');
              });
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 5),
              width: 30,
              height: 30,
              child: Image.asset(
                "assets/icons/weichat.png",
                // scale: 6,
              ),
            ),
          ),
          if (Platform.isIOS)
            GestureDetector(
              onTap: () {},
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 5),
                width: 30,
                height: 30,
                child: Image.asset(
                  "assets/icons/ic_apple_round.png",
                  scale: 0.5,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
