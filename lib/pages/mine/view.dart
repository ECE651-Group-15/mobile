import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import '../../common/routes/names.dart';
import '../../common/store/user.dart';
import 'index.dart';
import '../mine/Aboutus.dart';

class MinePage extends GetView<MineController> {
  const MinePage({Key? key}) : super(key: key);
  // final MineController myController = Get.put(MineController());
  @override
  Widget build(BuildContext context) {
    UserStore userStore = Get.find<UserStore>();
    return Scaffold(
      appBar: AppBar(title: const Text("Setting")),
      body: SafeArea(
        child: Obx(
          () => Column(
            children: [
              CircleAvatar(
                radius: 48,
                backgroundImage: NetworkImage(
                  userStore.isLogin && userStore.customerProfilesDetails['avatar'] != null
                      ? userStore.customerProfilesDetails['avatar']
                      : 'https://gravatar.com/avatar/36769e13dec8dd6619228ab1113427f8?s=400&d=mp&r=x',
                ),
              ),
              ListTile(
                leading: const Icon(Icons.account_circle),
                title: const Text("My Profile"),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  if (userStore.isLogin) {
                    Get.toNamed(AppRoutes.myProfile);
                  } else {
                    EasyLoading.showInfo('Please log in first');
                  }
                },
              ),
              ListTile(
                leading: const Icon(Icons.post_add_outlined),
                title: const Text("My Post"),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  if (userStore.isLogin) {
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
                  if (userStore.isLogin) {
                    Get.toNamed(AppRoutes.myLikedPost);
                  } else {
                    EasyLoading.showInfo('Please log in first');
                  }
                },
              ),

              ListTile(
                leading: const Icon(Icons.shopping_bag_outlined),
                title: const Text("Completed Orders"),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  Get.toNamed(AppRoutes.completedOrder);
                },
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
                  color: userStore.isLogin
                      ? Colors.red
                      : Colors.purple,
                ),
                title: Text(
                  userStore.isLogin ? "Logout" : "Login",
                  style: TextStyle(
                    color: userStore.isLogin
                        ? Colors.red
                        : Colors.purple,
                  ),
                ),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  if (userStore.isLogin) {
                    userStore.isLogin = false;
                  } else {
                    Get.toNamed(AppRoutes.login);
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
