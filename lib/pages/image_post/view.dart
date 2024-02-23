import 'package:exchange/common/routes/names.dart';
import 'package:exchange/pages/image_post/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
          style: TextStyle(
            fontSize: 18,
            color: const Color.fromARGB(255, 0, 0, 0),
          ),
        ),
      ),
    );
  }
}

class PostDetailsPage extends StatelessWidget {
  final dynamic item;

  PostDetailsPage({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? title; // 可能为 null 的字符串
    title=item['listingDetails']['title'];
    title = title ?? 'default title'; // 如果为 null，使用默认字符串

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
                Container(
                  height: 200,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: item.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Image.network(
                          item['listingDetails']['images']
                              .isNotEmpty
                              ? 'https://ece-651.oss-us-east-1.aliyuncs.com/${item['listingDetails']['images'][0]}'
                              : 'https://ece-651.oss-us-east-1.aliyuncs.com/default-image.jpg',
                          width: 200,
                          height: 200,
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  ),
                ),
              SizedBox(height: 16),
              OutlinedTextBox(text: 'Title: ${item['listingDetails']['title']}'),
              OutlinedTextBox(text: 'Price: \$${item['listingDetails']['price']}'),
              OutlinedTextBox(text: 'Category: ${item['listingDetails']['category']}'),
              OutlinedTextBox(text: 'Description: ${item['listingDetails']['description']}'),
            ],
          ),
        ),
      ),
    );
  }
}

// class ImagePostPage extends GetView<ImagePostController> {
//   const ImagePostPage({Key? key}) : super(key: key);
//
//   Widget _buildView(BuildContext context) {
//     const edgeInsetsPadding = EdgeInsets.only(left: 16.0, right: 16.0);
//
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Expanded(
//           child: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(16),
//                   child: Image.network('https://picsum.photos/500/600'),
//                 ),
//                 const Padding(
//                     padding: EdgeInsets.all(16),
//                     child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text('Tokeshimi Mirror'),
//                           Text('\$90'),
//                           Divider(color: Color.fromARGB(17, 0, 0, 0)),
//                           Text('Description',
//                               style: TextStyle(
//                                   fontWeight: FontWeight.bold, fontSize: 15)),
//                           Text('This is an Image'),
//                           Divider(color: Color.fromARGB(17, 0, 0, 0)),
//                           Text('Highlights',
//                               style: TextStyle(
//                                   fontWeight: FontWeight.bold, fontSize: 15)),
//                           Text('For Sale By:              Owner'),
//                           Divider(color: Color.fromARGB(17, 0, 0, 0)),
//                           Text('Location',
//                               style: TextStyle(
//                                   fontWeight: FontWeight.bold, fontSize: 15)),
//                           Text('Ottawa'),
//                         ]))
//               ],
//             ),
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.all(16),
//           child: ElevatedButton(
//             onPressed: () {
//               Get.toNamed(AppRoutes.home);
//             },
//             child: const Text(
//               'Back to home page',
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<ImagePostController>(
//       builder: (_) {
//         return Scaffold(
//           appBar: AppBar(title: const Text("Image Post")),
//           body: SafeArea(
//             child: _buildView(context),
//           ),
//         );
//       },
//     );
//   }
// }
