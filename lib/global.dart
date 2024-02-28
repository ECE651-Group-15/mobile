import 'package:exchange/pages/home/controller.dart';
import 'package:exchange/pages/mine/controller.dart';
import 'package:exchange/pages/my_post/controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'common/services/storage.dart';
import 'common/store/store.dart';
import 'pages/login_Pages/controller.dart';
/// 全局静态数据
class Global {
  /// 初始化
  static Future init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    setSystemUi();
    // Loading();

    await Get.putAsync<StorageService>(() => StorageService().init());
    Get.put<ConfigStore>(ConfigStore());
    Get.put<UserStore>(UserStore());
    // Get.put<HomeController>(HomeController());
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
