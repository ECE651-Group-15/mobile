import 'package:exchange/common/routes/names.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controller.dart';
import 'package:exchange/common/style/color.dart';
class OutlinedTextBox extends StatelessWidget {
  final String text;

  OutlinedTextBox({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.only(bottom: 12),
      child: Container(
        width: screenWidth - 32,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey.shade300,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 18,
            color: Color.fromARGB(255, 0, 0, 0),
          ),
        ),
      ),
    );
  }
}

class PostDetailsPage extends StatefulWidget {
  @override
  _PostDetailsPageState createState() => _PostDetailsPageState();
}

class _PostDetailsPageState extends State<PostDetailsPage> {
  final ImagePostController controller = Get.find<ImagePostController>();
  final PageController _pageController = PageController();
  int _currentPage = 0; // 用于追踪当前页面索引

  @override
  Widget build(BuildContext context) {
    var detailedPost = controller.state.detailedPost.value;
    final images = detailedPost['listingDetails']?['images'] as List<dynamic>? ?? [];
    final title = detailedPost['listingDetails']?['title'] ?? 'Default Title';
    final price = detailedPost['listingDetails']?['price'] ?? '';
    final category = detailedPost['listingDetails']?['category'] ?? '';
    final description = detailedPost['listingDetails']?['description'] ?? '';

    final customerName =
        detailedPost['customerProfilesDetails']?['name'] ?? 'No Name Provided';
    final customerAvatarUrl = detailedPost['customerProfilesDetails']
    ?['avatar'] ??
        'https://example.com/default_avatar.png';
    return Scaffold(
      appBar: AppBar(
        title: Text('Post Details'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {

        },
        child: const Icon(Icons.star),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            if (images.isNotEmpty)
              Container(
                height: MediaQuery.of(context).size.height / 2,
                child: Stack(
                  children: [
                    PageView.builder(
                      controller: _pageController,
                      itemCount: images.length,
                      itemBuilder: (context, index) {
                        return Image.network(
                          'https://ece-651.oss-us-east-1.aliyuncs.com/${images[index]}',
                          fit: BoxFit.contain,
                        );
                      },
                      onPageChanged: (int index) {
                        setState(() {
                          _currentPage = index;
                        });
                      },
                    ),
                    Positioned(
                      bottom: 8,
                      left: 0,
                      right: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(images.length, (index) {
                          return Container(
                            width: 8,
                            height: 8,
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _currentPage == index ? AppColor.myColor : Colors.grey,
                            ),
                          );
                        }),
                      ),
                    ),
                  ],
                ),
              ),
            // 其他widget...
            const SizedBox(height: 16),
            OutlinedTextBox(text: 'Title: $title'),
            OutlinedTextBox(text: 'Price: \$$price'),
            OutlinedTextBox(text: 'Category: $category'),
            OutlinedTextBox(text: 'Description: $description'),
            Padding(
              padding: EdgeInsets.only(bottom: 12),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: (){
                      Get.toNamed(AppRoutes.userProfile, arguments: detailedPost['customerProfilesDetails']);
                    },
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(customerAvatarUrl),
                      radius: 40,
                    ),
                  ),
                  SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Name: $customerName', style: TextStyle(fontSize: 18)),
                      // 其他个人信息
                    ],
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly, // 按钮之间均匀分布
          children: <Widget>[
            Expanded( // 使用Expanded让按钮填充可用空间
              child: TextButton(
                onPressed: () {
                  // Send offer 的逻辑
                },
                style: TextButton.styleFrom(
                  foregroundColor: AppColor.myColor, backgroundColor: Colors.white, // 设置文字颜色
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // 设置圆角大小
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16), // 增加按钮的高度
                ),
                child: const Text('Send Offer'),
              ),
            ),
            Expanded( // 使用Expanded让按钮填充可用空间
              child: TextButton(
                onPressed: () {
                  // Chat 的逻辑
                },
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: AppColor.myColor, // 设置文字颜色
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // 设置圆角大小
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16), // 增加按钮的高度
                ),
                child: const Text('Chat'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

