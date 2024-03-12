import 'package:exchange/common/routes/names.dart';
import 'package:exchange/common/store/store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:exchange/pages/home/index.dart';
import 'controller.dart';

class HomePage extends StatelessWidget {
  final HomeController controller = Get.put<HomeController>(HomeController());
  @override
  Widget build(BuildContext context) {
    UserStore userStore = Get.find<UserStore>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Assuming SearchMain is the route name for your search screen
              Get.toNamed(AppRoutes.SearchMain);
            },
          ),
        ],
      ),

      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     if (userStore.isLogin) {
      //       Get.toNamed(AppRoutes.createPost);
      //     } else {
      //       EasyLoading.showInfo('Please log in first');
      //     }
      //   },
      //   child: const Icon(Icons.add),
      // ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: RefreshIndicator(
            onRefresh: () => controller.refreshUI(),
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
                                  bool isStared;
                                  if (userStore.isLogin) {
                                    isStared = controller
                                        .isStared(item['listingDetails']['id']);
                                  } else {
                                    isStared = false;
                                  }
                                  // bool isStared = controller.state.staredLists.contains(item['id']);
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
                                          color: isStared
                                              ? Colors.red
                                              : Colors.grey,
                                        ),
                                      ),
                                    ),
                                    onPressed: () {
                                      if (userStore.isLogin) {
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
                                      } else {
                                        EasyLoading.showInfo(
                                            'Please log in first');
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
                                item['listingDetails']['title'] ?? 'No title',
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
      ),
    );
  }
}
