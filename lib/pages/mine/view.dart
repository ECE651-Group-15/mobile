import 'package:exchange/pages/mine/my_post/My_Post.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'index.dart';
import 'login_Pages/login.dart';
import 'package:exchange/pages/mine/My_Stars_Page/Stars_Page.dart';
class MinePage extends GetView<MineController> {
  const MinePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Setting")),
      body: SafeArea(
        child: Column(
          children: [
            const CircleAvatar(
              radius: 48,
              backgroundImage: NetworkImage('https://picsum.photos/200'),
            ),
            ListTile(
              leading: const Icon(Icons.post_add_outlined),
              title: const Text("My Post"),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MyPostPage()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.star_border_outlined),
              title: const Text("My Stars"),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context)=> StarsPage()),
                );
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
              onTap: () {},
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
                    MaterialPageRoute(builder: (context)=>LoginScreen()),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}
