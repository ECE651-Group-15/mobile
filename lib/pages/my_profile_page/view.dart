import 'package:exchange/common/routes/names.dart';
import 'package:exchange/pages/my_profile_page/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../common/store/user.dart';

class MyProfilePage extends StatelessWidget {
  MyProfilePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text('User Profile'),
      ),
      body: ListView(
        children: [
          UserHeaderSection(), // 用户头像和信息部分
          QuickLinksSection(), // 快速链接部分
          ProfileDetailsSection(), // 个人详情部分
          AccountSettingsSection(), // 账户设置部分
        ],
      ),
    );
  }
}

class UserHeaderSection extends StatelessWidget {
  UserStore userStore = Get.find<UserStore>();
  UserHeaderSection({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(
              userStore.customerProfilesDetails['avatar'] ??
                  'https://gravatar.com/avatar/default?s=400&d=robohash&r=x',
            ),
          ),
          const SizedBox(
              width:
                  16), // Provide some spacing between the avatar and the text
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userStore.customerProfilesDetails['name'] ?? 'No Name',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(
                    height: 4), // Provide some spacing between the texts
                Text(
                  userStore.customerProfilesDetails['email'] ?? 'No Email',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                Text(
                  userStore.customerProfilesDetails['phone'] ?? 'No Phone',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class QuickLinksSection extends StatelessWidget {
  UserStore userStore = Get.find<UserStore>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          ListTile(
            leading: Icon(Icons.person),
            title: Text('My public page'),
            onTap: () {
              Get.toNamed(AppRoutes.userProfile,
                  arguments: userStore.customerProfilesDetails);
            },
          ),
          // ...更多ListTile组件
        ],
      ),
    );
  }
}

class ProfileDetailsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          ListTile(
            title: Text('Edit Profile'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              Get.toNamed(AppRoutes.editProfile);
            },
          ),
          // ...更多ListTile组件
        ],
      ),
    );
  }
}

Future<void> _showDeleteAccountConfirmation(BuildContext context) async {
  final bool? confirmed = await showDialog<bool>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: const Text('Delete Account'),
      content: const Text(
          'Are you sure you want to delete your account? This action cannot be undone.'),
      actions: <Widget>[
        TextButton(
          onPressed: () =>
              Navigator.of(context).pop(false), // User presses "No"
          child: const Text('No'),
        ),
        TextButton(
          onPressed: () =>
              Navigator.of(context).pop(true), // User presses "Yes"
          child: const Text('Yes'),
        ),
      ],
    ),
  );

  if (confirmed ?? false) {
    // User confirmed deletion
    final MyProfileController controller = Get.find<MyProfileController>();

    // If deleteAccount is asynchronous, use await
    await controller
        .deleteAccount(); // Assuming 'deleteAccount' is the method name

    // Navigate to another page after account deletion
    Get.back(); // Replace '/someRoute' with the actual route you want to navigate to
  }
}

class AccountSettingsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          ListTile(
            title: Text('Manage account'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () => _showDeleteAccountConfirmation(context),
          ),
          ListTile(
            title: Text('Notification preferences'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {},
          ),
          // ...更多ListTile组件
        ],
      ),
    );
  }
}
