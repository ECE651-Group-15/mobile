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
              find.byType(TextField).at(0), 'leo@uwaterloo.ca');
          await Future.delayed(const Duration(seconds: 2));
          await tester.enterText(find.byType(TextField).at(1), '123456');
          await Future.delayed(const Duration(seconds: 2));
          await tester.tap(find.byType(ElevatedButton));
          await Future.delayed(const Duration(seconds: 2));
          await tester.pumpAndSettle();

          await Future.delayed(const Duration(seconds: 2));
          Get.toNamed(AppRoutes.home);
          await tester.pumpAndSettle(); // Wait for the navigation animation to complete
          await tester.pumpAndSettle(); // Wait for the navigation animation to complete
          await tester.pumpAndSettle();
          final Finder firstGirdTileFinder = find.byType(GridTile).first;
// Wait for the navigation animation to complete
              await tester.tap(firstGirdTileFinder);
              await tester.pumpAndSettle();
              await tester.pumpAndSettle();
              await tester.pumpAndSettle();
              await tester.pumpAndSettle();
              await tester.pumpAndSettle();
              // 查找FloatingActionButton
              final fabFinder = find.byType(FloatingActionButton);
              // 确保FloatingActionButton出现在屏幕上
              expect(fabFinder, findsOneWidget);
              // 模拟点击按钮
              await tester.tap(fabFinder);
              // 触发一次动画或状态更新后的重绘
              await Future.delayed(const Duration(seconds: 2));
              final Finder starIconFinder = find.byIcon(Icons.star);
              // await tester.tap(starIconFinder);
              await tester.pumpAndSettle();
              await tester.pumpAndSettle();
              await tester.pumpAndSettle();
              await tester.pumpAndSettle();
              await tester.pumpAndSettle();
              Get.close(1);

              //final Finder starIconFinder = find.byIcon(Icons.star);
         // await tester.tap(starIconFinder.first);
          await tester.pumpAndSettle();
          await tester.pumpAndSettle(); // Wait for the navigation animation to complete
          await tester.pumpAndSettle(); // Wait for the navigation animation to complete
          await tester.pumpAndSettle(); // Wait for the navigation animation to complete
          await tester.pumpAndSettle(); // Wait for the navigation animation to complete
          await tester.pumpAndSettle(); // Wait for the navigation animation to complete
          Get.toNamed(AppRoutes.mine);
          await tester.pumpAndSettle(); // Wait for the navigation animation to complete
          await tester.pumpAndSettle(); // Wait for the navigation animation to complete
          await tester.pumpAndSettle(); //await tester.pumpAndSettle(); // Wait for the navigation animation to complete
          await tester.pumpAndSettle(); // Wait for the navigation animation to complete
          await tester.pumpAndSettle();
          await tester.tap(find.text('My Stars'));
          await tester.pumpAndSettle(); // Wait for the navigation animation to complete
          await tester.pumpAndSettle(); // Wait for the navigation animation to complete
          await tester.pumpAndSettle(); //await tester.pumpAndSettle(); // Wait for the navigation animation to complete
          await tester.pumpAndSettle(); // Wait for the navigation animation to complete
          await tester.pumpAndSettle();
          //final Finder firstGirdTileFinder = find.byType(GridTile).first;

// Tap on the first ListTile
           await tester.tap(firstGirdTileFinder);
           await tester.pumpAndSettle(); // Wait for the navigation animation to complete
            await tester.pumpAndSettle(); // Wait for the navigation animation to complete
            await tester.pumpAndSettle(); //await tester.pumpAndSettle(); // Wait for the navigation animation to complete
            await tester.pumpAndSettle(); // Wait for the navigation animation to complete
            await tester.pumpAndSettle();
            await tester.tap(starIconFinder);
            await tester.pumpAndSettle();
            await tester.pumpAndSettle(); // Wait for the navigation animation to complete
              await tester.pumpAndSettle(); // Wait for the navigation animation to complete
              await tester.pumpAndSettle(); // Wait for the navigation animation to complete
              await tester.pumpAndSettle(); // Wait for the navigation animation to complete
              await tester.pumpAndSettle();




            },
      );

      // 对于登录失败的测试，可以采用类似的逻辑进行导航和验证
    },
  );
}
