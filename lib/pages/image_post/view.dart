import 'package:exchange/common/routes/names.dart';
import 'package:exchange/pages/image_post/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImagePostPage extends GetView<ImagePostController> {
  const ImagePostPage({Key? key}) : super(key: key);

  Widget _buildView(BuildContext context) {
    const edgeInsetsPadding = EdgeInsets.only(left: 16.0, right: 16.0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Image.network('https://picsum.photos/500/600'),
                ),
                const Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Tokeshimi Mirror'),
                          Text('\$90'),
                          Divider(color: Color.fromARGB(17, 0, 0, 0)),
                          Text('Description',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15)),
                          Text('This is an Image'),
                          Divider(color: Color.fromARGB(17, 0, 0, 0)),
                          Text('Highlights',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15)),
                          Text('For Sale By:              Owner'),
                          Divider(color: Color.fromARGB(17, 0, 0, 0)),
                          Text('Location',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15)),
                          Text('Ottawa'),
                        ]))
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: ElevatedButton(
            onPressed: () {
              Get.toNamed(AppRoutes.home);
            },
            child: const Text(
              'Back to home page',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ImagePostController>(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(title: const Text("Image Post")),
          body: SafeArea(
            child: _buildView(context),
          ),
        );
      },
    );
  }
}
