import 'package:exchange/pages/application/bindings.dart';
import 'package:exchange/pages/application/view.dart';
import 'package:exchange/pages/create_post/bindings.dart';
import 'package:exchange/pages/create_post/view.dart';
import 'package:exchange/pages/home/index.dart';
import 'package:exchange/pages/image_post/bindings.dart';
import 'package:exchange/pages/image_post/view.dart';
import 'package:exchange/pages/message/index.dart';
import 'package:exchange/pages/mine/index.dart';
import 'package:exchange/pages/mine/login_Pages/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:exchange/pages/mine/login_Pages/sign_up_email.dart';
import 'routes.dart';

class AppPages {
  static const initial = AppRoutes.initial;
  static const application = AppRoutes.application;
  static final RouteObserver<Route> observer = RouteObservers();
  static List<String> history = [];

  static final List<GetPage> routes = [
    // 第一次打开APP时的欢迎页面
    // GetPage(
    //   name: AppRoutes.initial,
    //   page: () => const WelcomePage(),
    //   binding: WelcomeBinding(),
    //   middlewares: [
    //     RouteAuthMiddleware(priority: 1),
    //   ],
    // ),
    // // 登录认证页面
    // GetPage(
    //   name: AppRoutes.login,
    //   page: () => const LoginPage(),
    //   binding: LoginBinding(),
    // ),

    // 应用主页面
    GetPage(
      name: AppRoutes.application,
      page: () => const ApplicationPage(),
      binding: ApplicationBinding(),
      // middlewares: [
      //   RouteAuthMiddleware(priority: 1),
      // ],
    ),
    // 首页
    GetPage(
      name: AppRoutes.home,
      page: () =>  HomePage(),
      binding: HomeBinding(),
    ),
    // 聊天页面
    GetPage(
      name: AppRoutes.message,
      page: () => const MessagePage(),
      binding: MessageBinding(),
    ),
    // 我的页面
    GetPage(
      name: AppRoutes.mine,
      page: () =>  MinePage(),
      binding: MineBinding(),
    ),

    GetPage(
      name: AppRoutes.createPost,
      page: () => CreatePostPage(),
      binding: CreatePostBinding(),
    ),
    GetPage(
      name: AppRoutes.imagePost,
      page: () => ImagePostPage(),
      binding: ImagePostBinding(),
    ),
    GetPage(name: AppRoutes.login,
        page: ()=>  LoginScreen(),
    ),
    // GetPage(
    //     name: AppRoutes.signUpEmail,
    //     page: ()=> EmailInputScreen(),
    // ),
  ];

// static final unknownRoute = GetPage(
//   name: AppRoutes.NotFound,
//   page: () => NotfoundView(),
// );
}
