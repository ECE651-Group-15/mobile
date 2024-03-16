import 'package:exchange/common/utils/utils.dart';
import 'package:exchange/common/values/values.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

import 'random_generator.dart';

void main() {
  final RandomGenerator randomGenerator = RandomGenerator();

  Get.testMode = true;
  String? sharedId;
  late String initialPassword;
  late String initialEmail;

  setUpAll(() async {
    String name = randomGenerator.generateString(10);
    initialEmail = randomGenerator.generateEmail(); // Store initial email
    initialPassword = randomGenerator.generateString(10); // Store initial password
    String phone = randomGenerator.generateString(10);

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
      sharedId = response["data"]["id"]; // Store the ID for use in subsequent tests
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

      String newName = randomGenerator.generateString(10);
      String newPhone = randomGenerator.generateString(10);

      var updateResponse = await HttpUtil().post(
        APIConstants.login,
        data: {
          "email": initialEmail,
          "password": initialPassword
        },
      );
      expect(updateResponse["code"], 200);
      expect(updateResponse["data"]["email"], initialEmail);

    });

  });
}
