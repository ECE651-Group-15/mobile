import 'dart:io'; // Add this line to import dart:io
import 'package:exchange/pages/edit_profile/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../common/store/user.dart';
import '../my_profile_page/controller.dart'; // Import for picking images

class EditProfileScreen extends StatelessWidget {
  EditProfileController controller = Get.put(EditProfileController());
  final myController = Get.find<MyProfileController>();
  final ImagePicker picker = ImagePicker();
  EditProfileScreen({Key? key}) : super(key: key); // Updated for null safety
  UserStore userStore = Get.find<UserStore>();
  @override
  Widget build(BuildContext context) {
    // Using Obx here to listen to changes in controller state
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Get.back(),
        ),
        title: const Text('Edit Profile'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Avatar display and picker button
            Obx(() => Column(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(controller.state.avatar),
                      radius: 60,
                    ),
                    TextButton(
                      onPressed: () async {
                        // Ensure the onPressed method is marked as async
                        final XFile? image =
                            await picker.pickImage(source: ImageSource.gallery);
                        if (image != null) {
                          // Only upload the image if it's not null
                          controller.uploadImage(image);
                        }
                      },
                      child: const Text('Change Avatar'),
                    ),
                  ],
                )),
            const SizedBox(height: 16),
            // Name input field
            TextField(
              controller: controller.nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
                hintText: 'Enter your name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            // Phone input field
            TextField(
              controller: controller.phoneController,
              decoration: const InputDecoration(
                labelText: 'Phone',
                hintText: 'Enter your phone number',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            // Save button
            ElevatedButton(
              onPressed: () async {
                controller.state.name = controller.nameController.text;
                controller.state.phone = controller.phoneController.text;
                bool success = await controller.editProfile();
                myController.loadData();
                if (success) {
                  Get.back(); // Go back to the previous screen or navigate as needed
                }
              },
              style: ElevatedButton.styleFrom(
                minimumSize:
                    const Size.fromHeight(50), // Sets the height of the button
                backgroundColor: const Color(
                    0xFF00008B), // Sets the background color of the button
              ),
              child: const Text(
                'Save Changes',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
