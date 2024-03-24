import 'package:exchange/common/routes/names.dart';
import 'package:exchange/pages/mine/view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:integration_test/integration_test.dart';
import 'package:exchange/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end to end test', () {
    testWidgets(
      'navigate to login screen and verify login with correct username and password',
          (WidgetTester tester) async {
        app.main();
        await tester.pumpAndSettle();

        // 确保使用 GetMaterialApp 或在 app.main() 中正确设置环境
        Get.toNamed(AppRoutes.mine);
        await tester.pumpAndSettle(); // 等待导航动画完成

        await tester.tap(find.text('Login'));
        await tester.pumpAndSettle(); // 等待导航动画完成

        // 输入用户名和密码
        await tester.enterText(find.byType(TextField).at(0), 'test@uwaterloo.ca');
        await tester.enterText(find.byType(TextField).at(1), '123456');

        await tester.tap(find.byType(ElevatedButton));
        await tester.pumpAndSettle();
        await Future.delayed(const Duration(seconds: 2));

        // 进入我的帖子页面
        await tester.tap(find.text('My Post'));
        await tester.pumpAndSettle(); // 等待导航动画完成
        await Future.delayed(const Duration(seconds: 2));

        // 查找并点击GridView中的第一个GridTile
        final Finder firstGridTile = find.byType(GridTile).at(0);
        await tester.tap(firstGridTile);
        await tester.pumpAndSettle(); // 等待点击事件处理完毕
        Get.close(2);
        await Future.delayed(const Duration(seconds: 2));
        await Future.delayed(const Duration(seconds: 2));

        await tester.tap(find.text('My Stars'));
        await tester.pumpAndSettle(); // 等待导航动画完成
        final Finder secondGridTile = find.byType(GridTile).at(0);
        await tester.tap(firstGridTile);
        await tester.pumpAndSettle();
        Get.close(2);
        await tester.tap(find.text('Completed Orders '));
        await tester.pumpAndSettle(); // 等待导航动画完成
        final Finder thirdGridTile = find.byType(GridTile).at(0);
        await tester.tap(firstGridTile);
        await tester.pumpAndSettle();
        Get.close(2);
        expect(find.text('Setting'), findsOneWidget);

          },
    );
  });
}
