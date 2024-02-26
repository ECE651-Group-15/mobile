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
          Get.toNamed(AppRoutes.createPost);
        },
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Obx(() {
            if (controller.state.postedListings.isEmpty) {
              return const Center(
                child: Text('No liked posts to display.'),
              );
              // return const Center(child: CircularProgressIndicator());
            } else {
              var items = controller.state.postedListings;
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
                      Map<String, dynamic> newList = {
                        'listingDetails': item,
                        'customerProfilesDetails': {}, // Placeholder for now
                      };
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
                                  image: NetworkImage(item['images'].isNotEmpty
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
                                  CrossAxisAlignment.start, // 左对齐
                              children: [
                                Text(
                                  '\$${item['price'].toString()}',
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 20, // 更大的字体
                                    fontWeight: FontWeight.bold, // 加粗
                                  ),
                                ),
                                SizedBox(height: 4), // 添加一点空间
                                Text(
                                  item['title'] ?? 'No title',
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 16, // 标题字体大小
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          }),
        ),
      ),
    );
  }
}
