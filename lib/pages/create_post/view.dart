import 'dart:io';

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
                onPressed: () {
                  // Handle the action when the "Create" button is pressed.
                  // Add your logic here.
                },
                child: Text(
                  "Create",
                  style: TextStyle(
                    color: const Color.fromARGB(
                        255, 250, 7, 7), // Customize the text color
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
                  ElevatedButton(
                    onPressed: () async {
                      final XFile? image =
                          await picker.pickImage(source: ImageSource.gallery);
                    },
                    child: Text("Choose an Image"),
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
