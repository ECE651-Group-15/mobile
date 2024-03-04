import 'package:exchange/common/entities/post.dart';
import 'package:exchange/pages/edit_profile/state.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../../common/store/user.dart';
import '../../common/apis/post.dart';

class EditProfileController extends GetxController {
  EditProfileControllerState state = EditProfileControllerState();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  UserStore userStore = Get.find<UserStore>();

  Future<bool> editProfile() async {
    String name = nameController.text.trim();
    String email = emailController.text.trim();
    String phone = phoneController.text.trim();

    // Construct the request entity with updated fields
    EditProfileRequestEntity req = EditProfileRequestEntity(
        id: userStore.customerProfilesDetails['id'],
        password: userStore.password,
        name: state.name,
        email: state.email,
        avatar: userStore.customerProfilesDetails['avatar'],
        phone: state.phone,
        longitude: userStore.customerProfilesDetails['longitude'],
        latitude: userStore.customerProfilesDetails['latitude']);

    try {
      EasyLoading.show(status: 'Updating profile...');
      EditProfileResponseEntity res = await PostApi.editProfile(req);
      if (res.code == 200 && res.data != null) {
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
    // Initialize text controllers if you want to prefill them, for example:
    // nameController.text = userStore.customerProfilesDetails['name'];
    // emailController.text = userStore.customerProfilesDetails['email'];
    // phoneController.text = userStore.customerProfilesDetails['phone'];
  }

  @override
  void onClose() {
    // Dispose controllers when the controller is removed from memory
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.onClose();
  }
}
