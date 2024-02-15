import 'dart:io';

import 'package:exchange/common/routes/names.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'index.dart';
import 'widgets/widgets.dart';

class CreatePostPage extends GetView<CreatePostController> {
  CreatePostPage({Key? key}) : super(key: key);
  // 主视图
  final ImagePicker picker = ImagePicker();

  Widget _buildView() {
    return const HelloWidget();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CreatePostController>(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Create Post"),
            actions: [
              TextButton(
                onPressed: () {},
                child: const Text(
                  "Create",
                  style: TextStyle(
                    color: Color.fromARGB(255, 250, 7, 7),
                  ),
                ),
              ),
            ],
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                      hintText: "Title",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    decoration: InputDecoration(
                      hintText: "Description",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    decoration: InputDecoration(
                      hintText: "Category",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    decoration: InputDecoration(
                      hintText: "Price",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    icon: Icon(
                      Icons.add_a_photo,
                      size: 20,
                    ),
                    label: Text('Upload photo'),
                    onPressed: () async {
                      final XFile? image =
                          await picker.pickImage(source: ImageSource.gallery);
                      // this.handleUploadImage(image);
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 56),
                      backgroundColor: Colors.grey[300],
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        child: const Text("Save Draft"),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Get.toNamed(AppRoutes.home);
                        },
                        child: const Text("Go back to main page"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
