import 'package:exchange/common/routes/names.dart';
import 'package:exchange/pages/mine/view.dart';
import 'package:flutter/material.dart';
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
              find.byType(TextField).at(0), 'z39yu@uwaterloo.ca');
          await Future.delayed(const Duration(seconds: 2));
          await tester.enterText(find.byType(TextField).at(1), '123456');
          await Future.delayed(const Duration(seconds: 2));
          await tester.tap(find.byType(ElevatedButton));
          await Future.delayed(const Duration(seconds: 2));
          await tester.pumpAndSettle();

          await tester.tap(find.text('My Profile'));
          await tester.pumpAndSettle(); // 等待导航动画完成
          await Future.delayed(const Duration(seconds: 2));
          await tester.tap(find.text('My public page'));
          await tester.pumpAndSettle(); // 等待导航动画完成
          await Future.delayed(const Duration(seconds: 2));
          expect(find.text('User\'s page'), findsOneWidget);
        },
      );

      // 对于登录失败的测试，可以采用类似的逻辑进行导航和验证
    },
  );
}
