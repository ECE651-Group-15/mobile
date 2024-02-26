import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../common/routes/names.dart';
import '../home/controller.dart';
import 'index.dart';
import '../login_Pages/view.dart';
import '../mine/Aboutus.dart';

class MinePage extends GetView<MineController> {
  MinePage({Key? key}) : super(key: key);
  // final MineController myController = Get.put(MineController());
  final HomeController homeController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Setting")),
      body: SafeArea(
        child: Column(
          children: [
            Obx(
              () {
                return GestureDetector(
                  onTap: () {
                    // Get.toNamed(AppRoutes.myProfile);
                  },
                  child: CircleAvatar(
                    radius: 48,
                    backgroundImage: NetworkImage(
                      homeController.state.customerProfilesDetails['avatar'] !=
                                  null &&
                              homeController.state
                                  .customerProfilesDetails['avatar'].isNotEmpty
                          ? homeController
                              .state.customerProfilesDetails['avatar']
                          : 'https://gravatar.com/avatar/65bb0599e7c5db1d5ad407e43fac74cf?s=400&d=robohash&r=x',
                    ),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.post_add_outlined),
              title: const Text("My Post"),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                Get.toNamed(AppRoutes.myPost);
              },
            ),
            ListTile(
              leading: const Icon(Icons.star_border_outlined),
              title: const Text("My Stars"),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                Get.toNamed(AppRoutes.myLikedPost);
              },
            ),
            ListTile(
              leading: const Icon(Icons.account_circle),
              title: const Text("My Profile"),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                Get.toNamed(AppRoutes.myProfile);
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
              leading: const Icon(
                Icons.logout_outlined,
                color: Colors.red,
              ),
              title: const Text(
                "Logout",
                style: TextStyle(color: Colors.red),
              ),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
