
import 'package:exchange/common/utils/utils.dart';
import 'package:exchange/common/values/values.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

import 'random_generator.dart';

void main() {
  final RandomGenerator randomGenerator = RandomGenerator();
 // final Random random = Random();

  String? sharedId; // Variable to store the shared profile ID
  // Variables to store the initial password and email for reuse
  late String initialPassword;
  late String initialEmail;
  String? postId;//
  setUpAll(() async {
    // Generate dynamic values for each field using RandomGenerator
    String name = randomGenerator.generateString(10);
    //initialEmail = 'leo3@uwaterloo.ca';
    //initialPassword = '123456';
    initialEmail = randomGenerator.generateEmail(); // Store initial email
    initialPassword =
        randomGenerator.generateString(10); // Store initial password
    String phone = randomGenerator.generateString(10);
    // Use HttpUtil to create a profile with dynamically generated data and store its ID
    var response = await HttpUtil().post(
      APIConstants.createProfileUrl,
      data: {
        "name": name,
        "email": initialEmail,
        "password": initialPassword,
        "phone": phone,
      },
    );
    if (response["code"] == 200) {
      sharedId =
      response["data"]["id"]; // Store the ID for use in subsequent tests
    } else {
      throw Exception("Failed to create profile in setup");
    }
  });

  tearDownAll(() {
    Get.reset(); // Perform any cleanup, if necessary
  });
  group('Post Operations', () {
    test('Update profile with dynamically generated data', () async {
      // if (sharedId == null) throw Exception("Profile ID is not available");

      //String newName = randomGenerator.generateString(10);
      //String newPhone = randomGenerator.generateString(10);

      var updateResponse = await HttpUtil().post(
        APIConstants.createPost,
        data: {
          "title": "Ipad Pro 15 Inch",
          "description": "Used for only 2 years",
          "price": 1200,
          "longitude": -0.118092,
          "latitude": 51.509865,
          "category": "ELECTRONICS",
          "customerId": sharedId,
          "status": "ACTIVE",
          "images": []
        },
      );
      expect(updateResponse["code"], 200);
      postId =
      updateResponse["data"]["id"];
      expect(updateResponse["data"]["customerId"], sharedId);


      // Add more assertions as necessary
    });
    test('update listing', () async {
      // if (sharedId == null) throw Exception("Profile ID is not available");

      String title = randomGenerator.generateString(10);
      //String newPhone = randomGenerator.generateString(10);

      var updateResponse = await HttpUtil().post(
        APIConstants.updateListing, // Corrected string interpolation
        data: {
          "id": postId,
          "title": title,
          "description": randomGenerator.generateString(10),
          "price": randomGenerator.number(10),
          "longitude": randomGenerator.generateDouble(10.0, 16.0),
          "latitude": randomGenerator.generateDouble(10.0, 100.0),
          "category": 'BOOKS',
          "customerId": sharedId,
          "status": "INACTIVE",
          "images": []
        },
      );
      expect(updateResponse["code"], 200);
      expect(updateResponse["data"]["id"], postId);


      // Add more assertions as necessary
    });

    // Add further tests for different operations on the profile
  });
}
