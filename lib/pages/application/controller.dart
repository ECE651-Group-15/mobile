import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'index.dart';

class ApplicationController extends GetxController {
  ApplicationController();

  final state = ApplicationState();

  // tab 页标题
  late final List<String> tabTitles;

  // 页控制器
  late final PageController pageController;

  // 底部导航项目
  late final List<BottomNavigationBarItem> bottomTabs;

  // tab栏动画
  void handleNavBarTap(int index) {
    pageController.jumpToPage(index);
  }

  // tab栏页码切换
  void handlePageChanged(int page) {
    state.page = page;
  }

  /// scheme 内部打开
  bool isInitialUriIsHandled = false;
  StreamSubscription? uriSub;

  // 第一次打开
  // Future<void> handleInitialUri() async {
  //   if (!isInitialUriIsHandled) {
  //     isInitialUriIsHandled = true;
  //     try {
  //       final uri = await getInitialUri();
  //       if (uri == null) {
  //         print('no initial uri');
  //       } else {
  //         // 这里获取了 scheme 请求
  //         print('got initial uri: $uri');
  //       }
  //     } on PlatformException {
  //       print('falied to get initial uri');
  //     } on FormatException catch (err) {
  //       print('malformed initial uri, ' + err.toString());
  //     }
  //   }
  // }

  // 程序打开时介入
  // void handleIncomingLinks() {
  //   if (!kIsWeb) {
  //     uriSub = uriLinkStream.listen((Uri? uri) {
  //       // 这里获取了 scheme 请求
  //       print('got uri: $uri');

  //       // if (uri!.pathSegments[1].toLowerCase() == 'category') {
  //       if (uri != null && uri.path == '/notify/category') {
  //         Get.toNamed(AppRoutes.Category);
  //       }
  //     }, onError: (Object err) {
  //       print('got err: $err');
  //     });
  //   }
  // }

  /// 在 widget 内存中分配后立即调用。
  @override
  void onInit() {
    super.onInit();

    tabTitles = ['Home', 'Chat', 'Setting'];
    bottomTabs = const [
      BottomNavigationBarItem(
        icon: Icon(Icons.home_outlined),
        activeIcon: Icon(Icons.home),
        label: "Home",
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.chat_outlined),
        activeIcon: Icon(Icons.chat),
        label: "Chat",
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.settings_outlined),
        activeIcon: Icon(Icons.settings),
        label: "Setting",
      ),
    ];
    pageController = PageController(initialPage: state.page);
  }

  /// 在 onInit() 之后调用 1 帧。这是进入的理想场所
  @override
  void onReady() {
    super.onReady();
  }

  /// 在 [onDelete] 方法之前调用。
  @override
  void onClose() {
    super.onClose();
  }

  /// dispose 释放内存
  @override
  void dispose() {
    uriSub?.cancel();
    pageController.dispose();
    super.dispose();
  }
}
