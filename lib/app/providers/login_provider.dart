import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '/app/models/useinfo_model.dart';

///
///
class LoginProvider {
  static const loginMode = "LOGINMODE";
  static const loginToken = "token";

  bool isLogin() {
    UserInfoModel? member = getMember();
    return member != null;
  }

  UserInfoModel? getMember() {
    return getLogin();
  }

  void saveLogin(UserInfoModel member) {
    SharedPreferences sp = Get.find<SharedPreferences>();
    sp.setString(loginMode, jsonEncode(member.toJson()));

    if (member.token != null) {
      sp.setString(loginToken, member.token!);
    }
  }

  UserInfoModel? getLogin() {
    SharedPreferences sp = Get.find<SharedPreferences>();
    try {
      String? json = sp.getString(loginMode);
      if (json != null) {
        if (json == "") {
          return null;
        }
        return UserInfoModel.fromJson(jsonDecode(json));
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  String? getToken() {
    SharedPreferences sp = Get.find<SharedPreferences>();
    return sp.getString(loginToken);
  }

  void cleanLogin() {
    SharedPreferences sp = Get.find<SharedPreferences>();
    sp.remove(loginMode);
    sp.remove(loginToken);
  }
}
