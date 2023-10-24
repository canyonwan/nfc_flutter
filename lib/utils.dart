import 'package:permission_handler/permission_handler.dart';

class AppUtils {
  /// 动态申请定位权限
  static Future<bool> requestPermission() async {
    // 申请权限
    bool hasLocationPermission = await requestLocationPermission();
    await requestStoragePermission();
    await requestPhotosPermission();

    if (hasLocationPermission) {
      print("定位权限申请通过");
      return true;
    } else {
      print("定位权限申请不通过");
      return false;
    }
  }

  /// 申请定位权限
  /// 授予定位权限返回true， 否则返回false
  static Future<bool> requestLocationPermission() async {
    //获取当前的权限
    var status = await Permission.location.status;
    if (status == PermissionStatus.granted) {
      //已经授权
      return true;
    } else {
      //未授权则发起一次申
      status = await Permission.location.request();
      if (status == PermissionStatus.granted) {
        return true;
      } else {
        return false;
      }
    }
  }

// 申请安卓调用相册权限
  static Future<bool> requestStoragePermission() async {
    //获取当前的权限
    var status = await Permission.storage.status;
    var photosStatus = await Permission.photos.status;
    if (status == PermissionStatus.granted) {
      //已经授权
      return true;
    } else {
      //未授权则发起一次申
      status = await Permission.storage.request();
      if (status == PermissionStatus.granted) {
        return true;
      } else {
        return false;
      }
    }
  }

  static Future<bool> requestPhotosPermission() async {
    //获取当前的权限
    var status = await Permission.photos.status;
    if (status == PermissionStatus.granted) {
      //已经授权
      return true;
    } else {
      //未授权则发起一次申
      status = await Permission.storage.request();
      if (status == PermissionStatus.granted) {
        return true;
      } else {
        return false;
      }
    }
  }
}
