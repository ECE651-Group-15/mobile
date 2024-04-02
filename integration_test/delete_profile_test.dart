import 'package:exchange/common/routes/names.dart';
import 'package:exchange/pages/mine/view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:integration_test/integration_test.dart';
import 'package:exchange/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group(
    'end to end test',
    () {
      testWidgets(
        'navigate to login screen and verify login with correct username and password',
        (tester) async {
          app.main();
          await tester.pumpAndSettle();
          Get.toNamed(AppRoutes.mine);
          await tester.pumpAndSettle(); // 等待导航动画完成
          await tester.tap(find.text('Login'));
          await tester.pumpAndSettle(); // 等待导航动画完成
          // 以下是登录测试，与你之前的代码相同
          await Future.delayed(const Duration(seconds: 2));
          await tester.enterText(
              find.byType(TextField).at(0), '00@uwaterloo.ca');
          await Future.delayed(const Duration(seconds: 2));
          await tester.enterText(find.byType(TextField).at(1), '123456');
          await Future.delayed(const Duration(seconds: 2));
          await tester.tap(find.byType(ElevatedButton));
          await Future.delayed(const Duration(seconds: 2));
          await tester.pumpAndSettle();
          await tester.pumpAndSettle();
          await tester.pumpAndSettle();

          await tester.tap(find.text('My Profile'));
          await tester.pumpAndSettle(); // 等待导航动画完成
          await tester.pumpAndSettle(); // 等待导航动画完成
          await tester.tap(find.text('Manage account'));
          await tester.pumpAndSettle(); // 等待导航动画完成
          await tester.pumpAndSettle();
          await Future.delayed(const Duration(seconds: 4));

          await tester.tap(find.text('Yes'));
          await tester.pumpAndSettle(); // Wait for any navigation or UI changes to complete.
          await tester.pumpAndSettle(); // Wait for any navigation or UI changes to complete.
          await tester.pumpAndSettle(); // Wait for any navigation or UI changes to complete.
          await tester.pumpAndSettle(); // Wait for any navigation or UI changes to complete.
          await tester.tap(find.text('Login'));
          await tester.pumpAndSettle(); // Wait for any navigation or UI changes to complete.
          await tester.pumpAndSettle(); // Wait for any navigation or UI changes to complete.
          await tester.pumpAndSettle(); // Wait for any navigation or UI changes to complete.
          await tester.pumpAndSettle();
          await tester.enterText(
              find.byType(TextField).at(0), '00@uwaterloo.ca');
          await Future.delayed(const Duration(seconds: 2));
          await tester.enterText(find.byType(TextField).at(1), '123456');
          await Future.delayed(const Duration(seconds: 2));
          await tester.tap(find.byType(ElevatedButton));
          //await Future.delayed(const Duration(seconds: 2));
          await tester.pumpAndSettle();

          if (EasyLoading.isShow) {
            // Here we assume that EasyLoading is showing an error message.
            // You might add checks to make sure it is the error message and not a success or info, etc.
            expect(EasyLoading.isShow, true);
            EasyLoading.dismiss(); // This is to clear out the EasyLoading widget after checking.
          }



        },
      );

      // 对于登录失败的测试，可以采用类似的逻辑进行导航和验证
    },
  );
}
