
import 'dart:math';

import 'package:exchange/pages/edit_post/index.dart';
import 'package:exchange/common/routes/names.dart';
import 'package:exchange/pages/mine/view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:integration_test/integration_test.dart';
import 'package:exchange/main.dart' as app;
import 'package:flutter_oss_aliyun/flutter_oss_aliyun.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:mockito/mockito.dart';

class MockImagePicker extends Mock implements ImagePicker {}

class MockNetworkClient extends Mock implements Client {} // 假设你有一个网络客户端类用于上传图片

class MockState extends Mock implements EditPostState {} // 假设你的状态类

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group(
    'end to end test',
        () {
          final mockImagePicker = MockImagePicker();
          final mockNetworkClient = MockNetworkClient();
          final mockState = MockState();
      testWidgets(
        'Edit Post Test',
            (tester) async {
          app.main();
          await tester.pumpAndSettle();
          Get.toNamed(AppRoutes.mine);
          await tester.pumpAndSettle(); // 等待导航动画完成
          await tester.tap(find.text('Login'));
          await tester.pumpAndSettle(); // 等待导航动画完成
          // 以下是登录测试，与你之前的代码相同
          await Future.delayed(const Duration(seconds: 2));
          await tester.enterText(find.byType(TextField).at(0), 'leo@uwaterloo.ca');
          await Future.delayed(const Duration(seconds: 2));
          await tester.enterText(find.byType(TextField).at(1), '123456');
          await Future.delayed(const Duration(seconds: 2));
          await tester.tap(find.byType(ElevatedButton));
          await Future.delayed(const Duration(seconds: 2));
          await tester.pumpAndSettle();
          await tester.pumpAndSettle();
          await tester.pumpAndSettle();

          await tester.tap(find.text('My Post'));
          await tester.pumpAndSettle(); // 等待导航动画完成
          await tester.pumpAndSettle(); // 等待导航动画完成

          await Future.delayed(const Duration(seconds: 4));

          final Finder popupMenuButtonFinder = find.byIcon(Icons.more_vert).at(0);
          await tester.tap(popupMenuButtonFinder);
          await tester.pumpAndSettle(); // Wait for the menu to open.
          await Future.delayed(const Duration(seconds: 2));

          final Finder SoldOptionFinder = find.text('Edit').at(0);
          await tester.tap(SoldOptionFinder);
          await tester.pumpAndSettle(); // Wait for any actions to complete after selection.
          await tester.pumpAndSettle();// Wait for any actions to complete after selection.
          await Future.delayed(const Duration(seconds: 2));

          final Finder deleteImageButtonFinder = find.byIcon(Icons.cancel);
          await tester.tap(deleteImageButtonFinder);
          await tester.pumpAndSettle();

          var response = await http.get(Uri.parse("https://picsum.photos/50"));
          var bytes = response.bodyBytes;
          final editPostController = Get.find<EditPostController>();
          await editPostController.uploadImage(XFile.fromData(bytes));
          await tester.pumpAndSettle();
          await tester.pumpAndSettle();
          await tester.pumpAndSettle();
          await tester.pumpAndSettle();
          await tester.pumpAndSettle();
          await tester.pumpAndSettle();
          await tester.pumpAndSettle();
          await tester.pumpAndSettle();
          await tester.pumpAndSettle();
          await Future.delayed(const Duration(seconds: 10));


              // Wait for any navigation or dialog to complete
              await tester.tap(find.text('Edit'));
              await tester.pumpAndSettle(); // Wait for any navigation or dialog to complete
              await tester.pumpAndSettle();
              await Future.delayed(const Duration(seconds: 2));









            },
      );

      // 对于登录失败的测试，可以采用类似的逻辑进行导航和验证
    },
  );
}
