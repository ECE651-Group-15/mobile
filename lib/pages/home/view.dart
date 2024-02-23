import 'package:exchange/common/routes/names.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:exchange/pages/home/index.dart';
import '../image_post/view.dart';
import 'controller.dart';

class HomePage extends StatelessWidget {
  final HomeController controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home Page")),
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
          child: Obx(() {
            var items = controller.state.listings;
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
              ),
              itemCount: items.length,
              itemBuilder: (context, index) {
                var item = items[index];
                String listingId = item['listingDetails']['id'].toString();
                return GridTile(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Expanded(
                        child: Stack(
                          children: [
                            GestureDetector(
                              onTap: (){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          PostDetailsPage(item: item)),
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        item['listingDetails']['images']?.isNotEmpty == true
                                            ? 'https://ece-651.oss-us-east-1.aliyuncs.com/${item['listingDetails']['images'][0]}'
                                            : 'https://ece-651.oss-us-east-1.aliyuncs.com/default-image.jpg'
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 6, // 距离顶部8单位
                              right: 6, // 距离右侧8单位
                              child: Obx(() {
                                // 将 isFavorite 的计算移动到 Obx 内部
                                bool isFavorite = controller.state.favorites[listingId] ?? false;
                                return IconButton(
                                icon: Container(
                                  width: 36, // 设置圆圈大小
                                  height: 36,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200], // 灰色背景
                                    shape: BoxShape.circle, // 圆形
                                  ),
                                  child: Center( // 确保图标位于容器中心
                                    child: Icon(
                                      isFavorite ? Icons.favorite : Icons.favorite_border,
                                      color: isFavorite ? Colors.red : Colors.grey, // 更新爱心颜色为灰色而非透明
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  controller.toggleFavorite(listingId);
                                  // starListing('b16f6fd7-fbe1-4665-8d03-ea8ec63ef78b', listingId);
                                },
                                );
                              }),
                            ),

                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          item['listingDetails']['title'] ?? 'No title',
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }),
        ),
      ),
    );
  }
}
