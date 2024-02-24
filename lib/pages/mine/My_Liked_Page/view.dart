import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../common/routes/names.dart';
import 'index.dart';
class LikedPage extends GetView<MyLikedPostController> {
   LikedPage({Key? key}) : super(key: key);
   @override
  final MyLikedPostController controller = Get.find<MyLikedPostController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Liked Post")),
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
            future: controller.fetchStarredListings(
                "b16f6fd7-fbe1-4665-8d03-ea8ec63ef78b", 1,1),
            builder: (BuildContext context,
                AsyncSnapshot<List<dynamic>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
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
                        // 导航并传递参数
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
                                    image: NetworkImage(
                                        items[index]['images'].isNotEmpty
                                            ? 'https://ece-651.oss-us-east-1.aliyuncs.com/${items[index]['images'][0] }'
                                            : 'https://ece-651.oss-us-east-1.aliyuncs.com/default-image.jpg'
                                    ),
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