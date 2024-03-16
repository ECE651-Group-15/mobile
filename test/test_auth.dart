import 'package:exchange/common/utils/utils.dart';
import 'package:exchange/common/values/values.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

import 'random_generator.dart';

void main() {
  final randomGenerator = RandomGenerator();

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

    // test create profile api
    test('test create profile functionality', () async {
      // send a request to create a user
      var response = await HttpUtil().post(
        APIConstants.createProfileUrl,
        data: {
          "email": email,
          "name": name,
          "password": password,
          "phone": phone
        },
      );

      expect(response["code"], 200);
      expect(response["data"]["email"], email);
      expect(response["data"]["name"], name);
      expect(response["data"]["phone"], phone);
    });

    // TODO: add more test for update user / delete user / get user / login ....
  });
}