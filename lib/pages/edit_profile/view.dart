import 'package:exchange/pages/edit_profile/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:exchange/pages/edit_profile/controller.dart';

class EditProfileScreen extends StatelessWidget {
  final EditProfileController controller = Get.put(EditProfileController());

  EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
            // Email input field
            TextField(
              controller: controller.emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                hintText: 'Enter your email',
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
                controller.state.email = controller.emailController.text;
                controller.state.phone = controller.phoneController.text;
                bool success = await controller.editProfile();
                if (success) {
                  // Optionally, show a success message or perform other actions upon successful profile update
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
