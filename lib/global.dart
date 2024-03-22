import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tencent_cloud_chat_sdk/enum/V2TimSDKListener.dart';
import 'package:tencent_cloud_chat_sdk/enum/log_level_enum.dart';
import 'package:tencent_cloud_chat_sdk/tencent_im_sdk_plugin.dart';

import 'common/services/storage.dart';
import 'common/store/store.dart';

/// 全局静态数据
class Global {
  static void initTimSdk() async {
    int sdkAppID = 1771000292;

    V2TimSDKListener sdkListener = V2TimSDKListener(
      onConnectFailed: (int code, String error) {
        print("onConnectFailed: $code, $error");
      },
      onConnectSuccess: () {
        print("onConnectSuccess");
      },
      onConnecting: () {
        print("onConnecting");
      },
    );

    TencentImSDKPlugin.v2TIMManager.initSDK(
      sdkAppID: 1771000292,
      loglevel: LogLevelEnum.V2TIM_LOG_DEBUG,
      listener: sdkListener,
    );
  }

  /// 初始化
  static Future init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    setSystemUi();
    // Loading();
    initTimSdk();

    await Get.putAsync<StorageService>(() => StorageService().init());
    Get.put<ConfigStore>(ConfigStore());
    Get.put<UserStore>(UserStore());
    // Get.put<HomeController>(HomeController());
    // Get.put<MyPostController>(MyPostController());
  }

  static void setSystemUi() {
    SystemUiOverlayStyle systemUiOverlayStyle = const SystemUiOverlayStyle(
        // statusBarColor: Colors.transparent,
        // statusBarBrightness: Brightness.light,
        // statusBarIconBrightness: Brightness.dark,
        // systemNavigationBarDividerColor: Colors.transparent,
        // systemNavigationBarColor: Colors.transparent,
        // systemNavigationBarIconBrightness: Brightness.light,
        // systemNavigationBarColor: Colors.white,
        // systemNavigationBarDividerColor: Colors.transparent,
        // systemNavigationBarIconBrightness: Brightness.dark,
        // statusBarColor: Colors.transparent,
        // statusBarBrightness: Brightness.light,
        // statusBarIconBrightness: Brightness.dark,
        );
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}
