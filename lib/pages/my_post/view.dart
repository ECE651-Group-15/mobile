import 'package:exchange/common/routes/names.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'index.dart';

class MyPostPage extends GetView<MyPostController> {

  final MyPostController controller = Get.put<MyPostController>(MyPostController());
    MyPostPage({Key? key}) : super(key: key);
  // Get.put<MyPostController>(MyPostController());
  @override
  Widget build(BuildContext context) {

    // final MyPostController controller = Get.find<MyPostController>();
    return Scaffold(
      appBar: AppBar(title: const Text("My Post")),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed(AppRoutes.createPost),
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: Obx(() {
          if (controller.state.postedListings.isEmpty) {
            return const Center(
              child: Text('No my posts to display.'),
            );
            // return Center(child: CircularProgressIndicator());
          } else {
            return RefreshIndicator(
              onRefresh: () => controller.refreshUI(),
              child: GridView.builder(
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
                        onTap: () async {
                          Map<String, dynamic>? customerProfilesDetails =  await controller.getProfile(item['customerId']);
                          Map<String, dynamic> newList = {
                            'listingDetails': {},
                            'customerProfilesDetails': customerProfilesDetails,
                          };
                          newList['listingDetails'] = item;
                          Get.toNamed(AppRoutes.postDetails, arguments: newList);
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                      Positioned(
                        top: 6,
                        right: 6,
                        child: PopupMenuButton<String>(
                          icon: Container(
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              shape: BoxShape.circle,
                            ),
                            child: const Center(
                              child: Icon(Icons.more_vert, color: Colors.black),
                            ),
                          ),
                          onSelected: (String result) {
                            switch (result) {
                              case 'edit':
                                Get.toNamed(AppRoutes.editPost, arguments: item);
                                break;
                              case 'delete':
                                controller.showDeleteConfirmationDialog(
                                    context, item['id']);
                                break;
                              case 'markAsSold':
                                controller.markAsSold(item);
                                // 实现标记为已售功能的代码
                                break;
                            }
                          },
                          itemBuilder: (BuildContext context) =>
                              <PopupMenuEntry<String>>[
                            const PopupMenuItem<String>(
                              value: 'edit',
                              child: Text('Edit'),
                            ),
                            const PopupMenuItem<String>(
                              value: 'delete',
                              child: Text('Delete'),
                            ),
                            const PopupMenuItem<String>(
                              value: 'markAsSold',
                              child: Text('Mark as Sold'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            );
          }
        }),
      ),
    );
  }
}
