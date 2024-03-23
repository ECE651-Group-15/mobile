import 'package:exchange/pages/application/bindings.dart';
import 'package:exchange/pages/application/view.dart';
import 'package:exchange/pages/create_post/bindings.dart';
import 'package:exchange/pages/create_post/view.dart';
import 'package:exchange/pages/edit_profile/view.dart';
import 'package:exchange/pages/home/index.dart';
import 'package:exchange/pages/image_post/bindings.dart';
import 'package:exchange/pages/image_post/view.dart';
import 'package:exchange/pages/message/index.dart';
import 'package:exchange/pages/mine/index.dart';
import 'package:exchange/pages/login_Pages/index.dart';
import 'package:exchange/pages/searched_post/bindings.dart';
import 'package:exchange/pages/searched_post/view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../pages/completed_order_page/index.dart';
import '../../pages/my_profile_page/index.dart';
import '../../pages/user_profile_page/index.dart';
import 'routes.dart';
import 'package:exchange/pages/my_post/index.dart';
import 'package:exchange/pages/My_Liked_Page/index.dart';
import 'package:exchange/pages/sign_up_pages/index.dart';
import 'package:exchange/pages/edit_post/index.dart';

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
      page: () => HomePage(),
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
      page: () => MinePage(),
      binding: MineBinding(),
    ),

    GetPage(
      name: AppRoutes.createPost,
      page: () => CreatePostPage(),
      binding: CreatePostBinding(),
    ),
    GetPage(
      name: AppRoutes.postDetails,
      page: () => PostDetailsPage(),
      binding: ImagePostBinding(),
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => LoginScreen(),
    ),
    GetPage(
      name: AppRoutes.myPost,
      page: () => MyPostPage(),
      binding: MyPostBinding(),
    ),
    GetPage(
      name: AppRoutes.myLikedPost,
      page: () => LikedPage(),
      binding: MyLikedPostBinding(),
    ),

    GetPage(
      name: AppRoutes.signUpEmail,
      page: () => EmailInputScreen(),
      binding: SignupBinding(),
    ),

    GetPage(
      name: AppRoutes.signUpName,
      page: () => NameInputScreen(),
      binding: SignupBinding(),
    ),

    GetPage(
      name: AppRoutes.signUpPwd,
      page: () => SignUpPassword(),
      binding: SignupBinding(),
    ),

    GetPage(
      name: AppRoutes.editPost,
      page: () => EditPostPage(),
      binding: EditPostBinding(),
    ),

    GetPage(
      name: AppRoutes.myProfile,
      page: () => MyProfilePage(),
      binding: MyProfileBinding(),
    ),

    GetPage(
      name: AppRoutes.userProfile,
      page: () => UserProfilePage(),
      binding: UserProfileBinding(),
    ),
    GetPage(
      name: AppRoutes.editProfile,
      page: () => EditProfileScreen(),
      binding: EditPostBinding(),
    ),
    GetPage(
      name: AppRoutes.SearchMain,
      page: () => SearchMainScreen(),
      binding: SearchMainBinding(),
    ),
    GetPage(
      name: AppRoutes.completedOrder,
      page: () => CompletedOrderScreen(),
      binding: CompletedOrderBinding(),
    )
  ];

// static final unknownRoute = GetPage(
//   name: AppRoutes.NotFound,
//   page: () => NotfoundView(),
// );
}
