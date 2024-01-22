import 'package:exchange/common/routes/routes.dart';
import 'package:exchange/common/store/store.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// 检查是否登录
class RouteAuthMiddleware extends GetMiddleware {
  // priority 数字小优先级高
  @override
  int? priority = 0;

  RouteAuthMiddleware({required this.priority});

  @override
  RouteSettings? redirect(String? route) {
    if (UserStore.to.isLogin ||
        route == AppRoutes.login ||
        route == AppRoutes.initial) {
      return null;
    } else {
      Future.delayed(
        const Duration(seconds: 1),
        () => Get.snackbar("提示", "请登录后使用"),
      );
      return const RouteSettings(name: AppRoutes.login);
    }
  }
}
