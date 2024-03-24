import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/routes/names.dart';
import 'controller.dart';

class UserProfilePage extends StatelessWidget {
  // final HomeController homeController = Get.find<HomeController>();
  final UserProfileController controller = Get.find<UserProfileController>();
  UserProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User's page"),
        centerTitle: false,
        // actions: [
        //   FilledButton.icon(
        //     onPressed: controller.startConversation,
        //     icon: const Icon(Icons.chat),
        //     label: const Text("Chat with seller"),
        //   ),
        //   const SizedBox(width: 10),
        // ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(
                      controller.profilesDetails['avatar'] ??
                          'https://gravatar.com/avatar/default?s=400&d=robohash&r=x',
                    ),
                  ),
                  SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        controller.profilesDetails['name'] ?? 'No name',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        controller.profilesDetails['email'] ?? 'No email',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Divider(
              color: Colors.grey,
              height: 20, // 分割线的高度，包括上下两端的空间
              thickness: 2, // 分割线的厚度
              indent: 100, // 分割线左端的空白区域
              endIndent: 100, // 分割线右端的空白区域
            ),
            const Padding(
              padding: EdgeInsets.all(1.0),
              child: Text(
                'All listings',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Divider(
              color: Colors.grey,
              height: 20, // 分割线的高度，包括上下两端的空间
              thickness: 2, // 分割线的厚度
              indent: 100, // 分割线左端的空白区域
              endIndent: 100, // 分割线右端的空白区域
            ),
            Obx(() {
              if (controller.state.postedListings.isEmpty) {
                return const Center(
                  child: Text('No my posts to display.'),
                );
                // return Center(child: CircularProgressIndicator());
              } else {
                return GridView.builder(
                  // 指定滑动类型为不可滚动，因为它已经在滚动视图内部
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 8.0,
                    crossAxisSpacing: 8.0,
                  ),
                  itemCount: controller.state.postedListings.length,
                  itemBuilder: (context, index) {
                    var item = controller.state.postedListings[index];
                    return Stack(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Map<String, dynamic> newList = {
                              'listingDetails': {},
                              'customerProfilesDetails': {},
                            };
                            newList['listingDetails'] = item;
                            Get.toNamed(AppRoutes.postDetails,
                                arguments: newList);
                          },
                          child: GridTile(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.0),
                                      image: DecorationImage(
                                        image: NetworkImage(item['images']
                                                .isNotEmpty
                                            ? 'https://ece-651.oss-us-east-1.aliyuncs.com/${item['images'][0]}'
                                            : 'https://ece-651.oss-us-east-1.aliyuncs.com/default-image.jpg'),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '\$${item['price'].toString()}',
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        item['title'] ?? 'No title',
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              }
            }),
            // SizedBox(
            //   width: double.infinity,
            //   child: FilledButton(
            //     onPressed: () {},
            //     child: const Text("Chat with seller"),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
