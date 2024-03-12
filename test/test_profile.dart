import 'package:exchange/common/services/storage.dart';
import 'package:exchange/common/store/user.dart';
import 'package:exchange/pages/edit_profile/controller.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

void main() {
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    Get.testMode = true;

    // Mock SharedPreferences with initial values
    // SharedPreferences.setMockInitialValues({
    //   // Assuming these keys match those used within your UserStore and StorageService
    //   'email': 'test@uwaterloo.ca',
    //   // Add other keys and values as necessary for initialization
    // });

    // Step 1: Initialize StorageService with mocked SharedPreferences
    await Get.putAsync(() async => StorageService().init());

    // Step 2: Initialize UserStore which now has access to the initialized StorageService
    Get.put(UserStore());

    Get.find<UserStore>().customerProfilesDetails.value = {
      'name': 'John Doe',
      'email': 'test@uwaterloo.ca',
      'phone': '123456789',
    };
  });

  tearDownAll(() {
    Get.reset();
  });

  group('EditProfileController Tests', () {
    late EditProfileController editProfileController;

    setUp(() {
      // Initialize EditProfileController
      editProfileController = EditProfileController();
    });

    test('loadUserInfo updates text controllers with UserStore data', () {
      // Precondition: Assuming UserStore's customerProfilesDetails already contains mock data

      // Act: Trigger loading of user info into controller's text fields
      editProfileController.loadUserInfo();

      // Assert: Text controllers should now contain the mock data from UserStore
      expect(editProfileController.nameController.text, 'John Doe');
      expect(editProfileController.emailController.text, 'test@uwaterloo.ca');
      expect(editProfileController.phoneController.text, '123456789');
      // Since the avatar is ignored, no need to test it here
    });
  });
}
