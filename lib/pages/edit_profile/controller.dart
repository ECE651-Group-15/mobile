import 'dart:typed_data';

import 'package:exchange/common/entities/post.dart';
import 'package:exchange/common/utils/oss.dart';
import 'package:exchange/pages/edit_profile/state.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart'; // Add this import for image picking
import '../../common/store/user.dart';
import '../../common/apis/post.dart';

class EditProfileController extends GetxController {
  EditProfileControllerState state = EditProfileControllerState();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  UserStore userStore = Get.find<UserStore>();
  final ImagePicker _picker = ImagePicker(); // For picking images
// Method to pick an image
  Future<void> pickAvatarImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      state.avatar = image.path; // Update avatar in the state
// Optionally, if you want to show the picked image immediately in your UI, you can update the UI here
    }
  }

  void uploadImage(XFile? file) async {
    if (file == null) {
      EasyLoading.showInfo("No image selected");
      return;
    }
    EasyLoading.show(
      status: 'uploading...',
      maskType: EasyLoadingMaskType.black,
      dismissOnTap: false,
    );
    try {
      Uint8List fileBytes = await file.readAsBytes();
      await client.putObject(
        fileBytes,
        file.name,
      );
      state.avatar =
          'https://ece-651.oss-us-east-1.aliyuncs.com/${file.name}'; // store image name in state array
      EasyLoading.showSuccess('upload image success');
    } catch (e) {
      EasyLoading.showError('upload image failed, try later');
    }
  }

  Future<bool> editProfile() async {
    String name = nameController.text.trim();
    String email = emailController.text.trim();
    String phone = phoneController.text.trim();
// Update request entity to include the selected avatar
    EditProfileRequestEntity req = EditProfileRequestEntity(
        id: userStore.customerProfilesDetails['id'],
        password: userStore.password,
        name: state.name,
        email: state.email,
        avatar: state.avatar, // Updated to use the selected avatar from state
        phone: state.phone,
        longitude: userStore.customerProfilesDetails['longitude'],
        latitude: userStore.customerProfilesDetails['latitude']);
    try {
      EasyLoading.show(status: 'Updating profile...');
      EditProfileResponseEntity res = await PostApi.editProfile(req);
      if (res.code == 200 && res.data != null) {
        userStore.customerProfilesDetails.value = res.data!.toJson();
        EasyLoading.showSuccess('Profile updated successfully');
// Update local user profile data if necessary
        return true;
      } else {
        EasyLoading.showError('Update failed: ');
        return false;
      }
    } catch (e) {
      print('Error : $e');
      EasyLoading.showError('Update failed: $e');
      return false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    loadUserInfo(); // Call this method to load user info and prefill the text fields
  }

  void loadUserInfo() {
    nameController.text = userStore.customerProfilesDetails['name'] ?? '';
    emailController.text = userStore.customerProfilesDetails['email'] ?? '';
    phoneController.text = userStore.customerProfilesDetails['phone'] ?? '';
    // Assuming avatar handling is ignored for now
    // If there are other fields to load, ensure they also safely handle potential nulls
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.onClose();
  }
}
