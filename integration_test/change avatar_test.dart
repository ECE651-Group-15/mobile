import 'dart:async';

import 'package:dio/src/response.dart';
import 'package:exchange/common/routes/names.dart';
import 'package:exchange/pages/edit_profile/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:integration_test/integration_test.dart';
import 'package:exchange/main.dart' as app;
import 'package:image_picker/image_picker.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_oss_aliyun/flutter_oss_aliyun.dart';

class MockImagePicker extends Mock implements  ImagePicker{}
class MockNetworkClient extends Mock implements Client {}// 假设你有一个网络客户端类用于上传图片
class MockState extends Mock implements EditProfileControllerState {} // 假设你的状态类

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    // 初始化mock对象
    final mockImagePicker = MockImagePicker();
    final mockNetworkClient = MockNetworkClient();
    final mockState = MockState();

    testWidgets(
      'navigate to sign-up page and create account successfully',
          (tester) async {
        app.main();
        await tester.pumpAndSettle();
        Get.toNamed(AppRoutes.mine);
        await tester.pumpAndSettle(); // 等待导航动画完成
        await tester.tap(find.text('Login'));
        await tester.pumpAndSettle(); // 等待导航动画完成
        // 以下是登录测试，与你之前的代码相同
        await Future.delayed(const Duration(seconds: 2));
        await tester.enterText(find.byType(TextField).at(0), 'test@uwaterloo.ca');
        await Future.delayed(const Duration(seconds: 2));
        await tester.enterText(find.byType(TextField).at(1), '123456');
        await Future.delayed(const Duration(seconds: 2));
        await tester.tap(find.byType(ElevatedButton));
        await Future.delayed(const Duration(seconds: 2));
        await tester.pumpAndSettle();
        await Future.delayed(const Duration(seconds: 2));

        //expect(find.byType(MinePage), findsOneWidget);
        await tester.tap(find.text('My Profile'));
        await tester.pumpAndSettle(); // 等待导航动画完成
        await Future.delayed(const Duration(seconds: 2));
        await tester.tap(find.text('Edit Profile'));
        await tester.pumpAndSettle(); // 等待导航动画完成
        await Future.delayed(const Duration(seconds: 2));
        // 配置mock对象的行为
        // when(mockImagePicker.pickImage(source: ImageSource.gallery))
        //     .thenAnswer((_) async => XFile('/data/user/0/com.example.exchange/cache/8cf1c8d3-cdad-4f15-808c-a878818afee1/4043232_avatar_batman_comics_hero_icon.png'));
        // when(mockNetworkClient.putObject(any as List<int>, any as String))
        //     .thenAnswer((_) async => Future.value(); // 假设Response是你期望的返回类型
        await tester.pumpAndSettle(); // 等待导航动画完成
        await Future.delayed(const Duration(seconds: 2));
        // await tester.enterText(find.byType(TextField).at(0), 'l');
        // await Future.delayed(const Duration(seconds: 2));
        // await tester.enterText(find.byType(TextField).at(1), '1');
        // await Future.delayed(const Duration(seconds: 2));
        // await tester.tap(find.text('Save Changes'));
        // await tester.pumpAndSettle(); // Wait for save to complete and navigate back
        // await Future.delayed(const Duration(seconds: 2));

        expect(find.text('Edit Profile'), findsOneWidget);

      },
    );

    // You can add more tests for failure scenarios here
  });
}