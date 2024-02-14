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
                  child: Text('This is an image'),
                )
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
              'View Seller Listings',
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
