import 'package:exchange/common/routes/names.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:exchange/pages/home/index.dart';
import 'controller.dart';

class HomePage extends StatelessWidget {
  final HomeController controller = Get.find<HomeController>();
  // final MineController mineController = Get.find();

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
                              onTap: () {
                                Get.toNamed(AppRoutes.postDetails,
                                    arguments: item);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0),
                                  image: DecorationImage(
                                    image: NetworkImage(item['listingDetails']
                                                    ['images']
                                                ?.isNotEmpty ==
                                            true
                                        ? 'https://ece-651.oss-us-east-1.aliyuncs.com/${item['listingDetails']['images'][0]}'
                                        : 'https://ece-651.oss-us-east-1.aliyuncs.com/default-image.jpg'),
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
                                bool isStared = controller
                                    .isStared(item['listingDetails']['id']);
                                //传入controller检查是否已经点赞过了
                                return IconButton(
                                  icon: Container(
                                    width: 36, // 设置圆圈大小
                                    height: 36,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[200], // 灰色背景
                                      shape: BoxShape.circle, // 圆形
                                    ),
                                    child: Center(
                                      // 确保图标位于容器中心
                                      child: Icon(
                                        isStared
                                            ? Icons.star
                                            : Icons.star_border,
                                        color:
                                            isStared ? Colors.red : Colors.grey,
                                      ),
                                    ),
                                  ),
                                  onPressed: () {
                                    //点赞功能
                                    // controller.toggleFavorite(listingId);
                                    if (!isStared) {
                                      controller.starListing(listingId);
                                      controller.state.staredLists
                                          .add(listingId);
                                    } else {
                                      //取消点赞功能
                                      controller.unStarListing(listingId);
                                      controller.state.staredLists
                                          .remove(listingId);
                                    }
                                  },
                                );
                              }),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start, // 左对齐
                          children: [
                            Text(
                              '\$${item['listingDetails']['price'].toString()}',
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
                );
              },
            );
          }),
        ),
      ),
    );
  }
}
