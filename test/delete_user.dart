import 'package:exchange/common/utils/utils.dart';
import 'package:exchange/common/values/values.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

import 'random_generator.dart';

void main() {
  final RandomGenerator randomGenerator = RandomGenerator();

  Get.testMode = true;
  String? sharedId; // Variable to store the shared profile ID
  // Variables to store the initial password and email for reuse
  late String initialPassword;
  late String initialEmail;

  setUpAll(() async {
    // Generate dynamic values for each field using RandomGenerator
    String name = randomGenerator.generateString(10);
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

  group('Profile operations', () {
    test('Update profile with dynamically generated data', () async {
      if (sharedId == null) throw Exception("Profile ID is not available");

      //String newName = randomGenerator.generateString(10);
      //String newPhone = randomGenerator.generateString(10);

      var updateResponse = await HttpUtil().post(
        "${APIConstants.deleteProfile}/$sharedId", // Corrected string interpolation
        data: {
          "id": sharedId,
        },
      );
      expect(updateResponse["code"], 200);
      expect(updateResponse["data"]["id"], sharedId);

      // Add more assertions as necessary
    });

    // Add further tests for different operations on the profile
  });
}
