import 'package:exchange/common/utils/utils.dart';
import 'package:exchange/common/values/values.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

import 'random_generator.dart';

void main() {
  final randomGenerator = RandomGenerator();
  String? id; // Make `id` nullable to check its initialization

  setUpAll(() async {
    Get.testMode = true;
  });

  tearDownAll(() {
    Get.reset();
  });

  group('Login Authentication and Authorization services', () {
    late String name;
    late String email;
    late String phone;
    late String password;

    setUp(() {
      name = randomGenerator.generateString(10);
      email = randomGenerator.generateEmail();
      phone = randomGenerator.generateString(10);
      password = randomGenerator.generateString(10);
    });

    // Test create profile functionality
    test('test create profile functionality', () async {
      var response = await HttpUtil().post(
        APIConstants.createProfileUrl,
        data: {
          "email": "leo3@gmail.com",
          "name": "tester3",
          "password": 123456,
          "phone": 123456
        },
      );
      expect(response["code"], 200);
      expect(response["data"]["email"], email);
      expect(response["data"]["name"], name);
      expect(response["data"]["phone"], phone);
      id = response["data"]["id"]; // Initialize `id` here
    });

    // Test update profile functionality
    test('Update profile functionality', () async {
      // Ensure `id` is initialized before proceeding
      if (id == null) {
        throw Exception("Profile not created, ID is null");
      }

      var responseUpdateProfile = await HttpUtil().post(
        APIConstants.updateProfile,
        data: {
          "id":
              id, // Use `id` directly here since we know it's been initialized
          "email": email,
          "name": name,
          "password": password,
          "phone": phone
        },
      );
      expect(responseUpdateProfile["code"], 200);
      expect(responseUpdateProfile["data"]["email"], email);
      expect(responseUpdateProfile["data"]["name"], name);
      expect(responseUpdateProfile["data"]["phone"], phone);
    });

    // Further tests for delete, get user, login, etc. can follow the same pattern
  });
}
