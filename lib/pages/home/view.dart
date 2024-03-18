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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: RefreshIndicator(
            onRefresh: () => controller.refreshUI(),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 8.0,
                  crossAxisSpacing: 8.0,
                ),
                itemCount: controller.state.listings.length,
                itemBuilder: (context, index) {
                  var item = controller.state.listings[index];
                  String? listingId = item.listingDetails?.id;
                  // controller.checkIfStared(listingId!);
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
                                      arguments: item.toJson());
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.0),
                                    image: DecorationImage(
                                      image: NetworkImage(item.listingDetails?.images
                                                  ?.isNotEmpty ==
                                              true
                                          ? 'https://ece-651.oss-us-east-1.aliyuncs.com/${item.listingDetails!.images?[0]}'
                                          : 'https://ece-651.oss-us-east-1.aliyuncs.com/default-image.jpg'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 6,
                                right: 6,
                                child: Obx(() {
                                  bool isStared = controller.state.staredLists.contains(listingId);
                                  return IconButton(
                                    icon: Container(
                                      width: 36,
                                      height: 36,
                                      decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        shape: BoxShape.circle,
                                      ),
                                      child: Center(
                                        child: Icon(
                                          isStared
                                              ? Icons.star
                                              : Icons.star_border,
                                          color:isStared
                                              ? Colors.red
                                              : Colors.grey,
                                        ),
                                      ),
                                    ),
                                    onPressed: () {
                                      if (userStore.isLogin) {
                                             isStared
                                            ? controller.unStarListing(listingId!)
                                            : controller.starListing(listingId!);
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
                                '\$${item.listingDetails?.price}',
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 20, // 更大的字体
                                  fontWeight: FontWeight.bold, // 加粗
                                ),
                              ),
                              const SizedBox(height: 4), // 添加一点空间
                              Text(
                                item.listingDetails?.title ?? 'No title',
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
                controller: controller.scrollController,
              )
          ),
        ),
      ),
    );
  }
}
