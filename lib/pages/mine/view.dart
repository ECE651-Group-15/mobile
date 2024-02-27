import 'package:exchange/pages/login_Pages/controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import '../../common/routes/names.dart';
import 'index.dart';
import '../login_Pages/view.dart';
import '../mine/Aboutus.dart';

class MinePage extends GetView<MineController> {
  MinePage({Key? key}) : super(key: key);
  // final MineController myController = Get.put(MineController());
  @override
  Widget build(BuildContext context) {
    // final HomeController homeController = Get.find();
    final logInController = Get.find<LoginController>();
    return Scaffold(
      appBar: AppBar(title: const Text("Setting")),
      body: SafeArea(
        child: Obx(
          () => Column(
            children: [
              CircleAvatar(
                radius: 48,
                backgroundImage: NetworkImage(
                  logInController.state.isLogin
                      ? logInController.state.avatar
                      : 'https://gravatar.com/avatar/36769e13dec8dd6619228ab1113427f8?s=400&d=mp&r=x',
                ),
              ),
              ListTile(
                leading: const Icon(Icons.post_add_outlined),
                title: const Text("My Post"),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  if (logInController.state.isLogin) {
                    Get.toNamed(AppRoutes.myPost);
                  } else {
                    EasyLoading.showInfo('Please log in first');
                  }
                },
              ),
              ListTile(
                leading: const Icon(Icons.star_border_outlined),
                title: const Text("My Stars"),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  if (logInController.state.isLogin) {
                    Get.toNamed(AppRoutes.myLikedPost);
                  } else {
                    EasyLoading.showInfo('Please log in first');
                  }
                },
              ),
              ListTile(
                leading: const Icon(Icons.account_circle),
                title: const Text("My Profile"),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  if (logInController.state.isLogin) {
                    Get.toNamed(AppRoutes.myProfile);
                  } else {
                    EasyLoading.showInfo('Please log in first');
                  }
                },
              ),
              ListTile(
                leading: const Icon(Icons.shopping_bag_outlined),
                title: const Text("Completed Orders"),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {},
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.info_outline),
                title: const Text("About Us"),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AboutUsPage()),
                  );
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.logout_outlined,
                  color: logInController.state.isLogin
                      ? Colors.red
                      : Colors.purple,
                ),
                title: Text(
                  logInController.state.isLogin ? "Logout" : "Login",
                  style: TextStyle(
                    color: logInController.state.isLogin
                        ? Colors.red
                        : Colors.purple,
                  ),
                ),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  if (logInController.state.isLogin) {
                    logInController.state.isLogin = false;
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
