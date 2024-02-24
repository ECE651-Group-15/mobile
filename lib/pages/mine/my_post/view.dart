import 'package:exchange/common/routes/names.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'index.dart';

class MyPostPage extends GetView<MyPostController> {
  MyPostPage({Key? key}) : super(key: key);
  @override
  final MyPostController controller = Get.find<MyPostController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Post")),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // 假设 AppRoutes.createPost 是你定义的路由
          Get.toNamed(AppRoutes.createPost);
        },
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder<List<dynamic>>(
            future: controller.fetchCustomerPostedListings(
                "b16f6fd7-fbe1-4665-8d03-ea8ec63ef78b", 0),
            builder:
                (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                // 假设 items 是从 snapshot.data 获取的数据
                var items = snapshot.data ?? [];
                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 8.0,
                    crossAxisSpacing: 8.0,
                  ),
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    var item = items[index];
                    return GestureDetector(
                      onTap: () {
                        Map<String, dynamic> newList = {};
                        newList['listingDetails']={};
                        newList['customerProfilesDetails']={};
                        newList['listingDetails']=item;
                        Get.toNamed(AppRoutes.postDetails, arguments: newList);
                      },
                      onLongPress: () {
                        controller.showOptions(context,item['id']); // 长按时调用_showOptions函数
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
                                    image: NetworkImage(items[index]['images']
                                            .isNotEmpty
                                        ? 'https://ece-651.oss-us-east-1.aliyuncs.com/${items[index]['images'][0]}'
                                        : 'https://ece-651.oss-us-east-1.aliyuncs.com/default-image.jpg'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text(
                                items[index]['title'],
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }
}