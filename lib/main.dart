import 'dart:io';

// import 'package:amap_location_fluttify/amap_location_fluttify.dart';
import 'package:amap_location_fluttify/amap_location_fluttify.dart';
import 'package:bruno/bruno.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluwx/fluwx.dart';
import 'package:get/get.dart';
import 'package:jpush_flutter/jpush_flutter.dart';
import 'package:mallxx_app/app/components/hide_keyboard.dart';
// import 'package:live_flutter_plugin/v2_tx_live_premier.dart';
import 'package:mallxx_app/const/colors.dart';
import 'package:mallxx_app/utils.dart';
import 'package:meiqia_sdk_flutter/meiqia_sdk_flutter.dart';
import 'package:oktoast/oktoast.dart';
import 'package:tobias/tobias.dart' as tobias;

import 'app/routes/app_pages.dart';
import 'application.dart';
import 'lan/Message.dart';

///
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AmapLocation.instance.updatePrivacyShow(true);
  await AmapLocation.instance.updatePrivacyAgree(true);
  await AmapLocation.instance.init(iosKey: 'ff69dc69063804b94a28ebb5e03d405a');
  // AMapFlutterLocation.updatePrivacyShow(true, true);
  // AMapFlutterLocation.updatePrivacyAgree(true);
  // AMapFlutterLocation.setApiKey(
  //     "87596967ecfff9885019384f67c2949c", "ff69dc69063804b94a28ebb5e03d405a");
  await AppUtils.requestPermission();
  await Application.init();
  await initWXLogin();
  await initMeiqia();
  // await setupLicense();
  // await initYsCloud();
  await tobias.isAliPayInstalled();
  if (Platform.isAndroid) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Color(0xffeeeeee),
    ));
    // SystemChrome.setEnabledSystemUIOverlays([]);
  }
  runApp(App());
}

final JPush jpush = new JPush();

Future<void> initPlatformState() async {
  try {
    jpush.addEventHandler(
        onReceiveNotification: (Map<String, dynamic> message) async {},
        onOpenNotification: (Map<String, dynamic> message) async {
          Get.toNamed(Routes.MESSAGE_CENTER);
          jpush.clearAllNotifications();
          jpush.setBadge(0);
        },
        onReceiveMessage: (Map<String, dynamic> message) async {},
        onReceiveNotificationAuthorization:
            (Map<String, dynamic> message) async {},
        onNotifyMessageUnShow: (Map<String, dynamic> message) async {});
  } on PlatformException {}

  jpush.setAuth(enable: true);
  jpush.setup(
    appKey: "6621ace68dffa504fc41e86a", //你自己应用的 AppKey
    channel: "theChannel",
    production: true,
    debug: true,
  );
  jpush.applyPushAuthority(
      new NotificationSettingsIOS(sound: true, alert: true, badge: true));

  // Platform messages may fail, so we use a try/catch PlatformException.
  jpush.getRegistrationID().then((rid) {
    print("flutter get registration id : $rid");
  });
}

Future<void> initWXLogin() async {
  await registerWxApi(
      appId: 'wx8e0fdf7fe83b6ecf', //查看微信开放平台
      doOnAndroid: true,
      doOnIOS: true,
      universalLink: 'https://com.nongfucang.shopper' //查看微信开放平台
      );
}

Future<void> initMeiqia() async {
  await MQManager.init(appKey: '5a9380993113d0d2f8eaca52ad5a9dea');
}

/// 腾讯云License管理页面(https://console.cloud.tencent.com/live/license)
// Future<void> setupLicense() async {
//   var licenseUrl =
//       'https://license.vod2.myqcloud.com/license/v2/1259663678_1/v_cube.license';
//   var licenseKey = 'd9b30eb5f64bdb8d0700b57cd4335e96';
//   await V2TXLivePremier.setLicence(licenseUrl, licenseKey);
// }
//
// Future<void> initYsCloud() async {
//   await FlutterYs7.initSdk('a6d24dcd3aba4e65ac833c0e08ddd3a3');
// }

class App extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<App> with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    initPlatformState();
    EasyRefresh.defaultHeaderBuilder = () => ClassicHeader(
          dragText: '下拉刷新',
          armedText: '松开刷新',
          readyText: '刷新中...',
          processingText: 'Refreshing...'.tr,
          processedText: 'Succeeded'.tr,
          noMoreText: 'No more'.tr,
          failedText: 'Failed'.tr,
          messageText: 'Last updated at %T'.tr,
        );
    EasyRefresh.defaultFooterBuilder = () => ClassicFooter(
          dragText: 'Pull to load'.tr,
          armedText: 'Release ready'.tr,
          readyText: 'Loading...'.tr,
          processingText: 'Loading...'.tr,
          processedText: 'Succeeded'.tr,
          noMoreText: 'No more'.tr,
          failedText: 'Failed'.tr,
          messageText: 'Last updated at %T'.tr,
        );
    BrnInitializer.register(
      allThemeConfig: BrnAllThemeConfig(
        commonConfig: BrnCommonConfig(
          brandPrimary: kAppColor,
        ),
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(375, 702),
        builder: (context, child) => OKToast(
              radius: 6,
              textPadding:
                  EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
              child: HideKeyboard(
                child: GetMaterialApp(
                  // routingCallback: (Routing? routing) {
                  //   final RootController _rootController =
                  //       Get.put(RootController());
                  //   if (routing?.previous == '/root' && routing?.isBack == true) {
                  //     // _rootController.toFarm();
                  //   }
                  // },
                  title: "农副仓",
                  debugShowCheckedModeBanner: false,
                  initialRoute: AppPages.INITIAL,
                  getPages: AppPages.routes,
                  translations: Messages(),
                  // locale: Get.deviceLocale,
                  // supportedLocales: [Locale('en'), Locale('zh', 'CN')],
                  locale: const Locale("zh", "CN"),
                  // locale: Get.deviceLocale,
                  // fallbackLocale: const Locale("zh", "CN"),
                  theme: ThemeData(
                    brightness: Brightness.light,
                    primarySwatch: Colors.blue,
                    primaryColor: kAppColor,
                    scaffoldBackgroundColor: Color(0xffECECEC),
                    appBarTheme: const AppBarTheme(
                      iconTheme: IconThemeData(color: KWhiteColor),
                      backgroundColor: kAppColor,
                      titleTextStyle:
                          TextStyle(color: KWhiteColor, fontSize: 20.0),
                      elevation: 0.5,
                    ),
                    bottomNavigationBarTheme:
                        const BottomNavigationBarThemeData(
                      backgroundColor: Color(0xfffbfbfb),
                      selectedItemColor: Colors.black,
                      unselectedItemColor: Color(0xff7b7b7b),
                      selectedLabelStyle: TextStyle(fontSize: 12),
                    ),
                  ),
                  builder: EasyLoading.init(),
                ),
              ),
            ));
  }
}
