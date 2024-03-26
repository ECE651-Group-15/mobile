import 'package:exchange/common/apis/post.dart';
import 'package:exchange/common/entities/post.dart';
import 'package:exchange/pages/completed_order_page/controller.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:exchange/common/entities/post.dart';
import 'package:exchange/common/utils/utils.dart';
import 'package:exchange/common/values/values.dart';

// 使用 mockito 自动生成 Mock 类
@GenerateMocks([PostApi])
void main() {
  // 初始化 mock 对象
  MockPostApi mockPostApi = MockPostApi();

  group('CompletedOrderController Tests', () {
    test('markAsAvailable marks item as available and refreshes listings', () async {
      final controller = CompletedOrderController();

      // 模拟网络请求的响应
      when(mockPostApi.markAsSold(any)).thenAnswer((_) async =>
          MarkAsSoldResponseEntity(code: 200));

      // 调用 markAsAvailable 方法
      await controller.markAsAvailable({
        'id': '123',
        'title': 'Test Title',
        'description': 'Test Description',
        'price': '100',
        'longitude': '0.0',
        'latitude': '0.0',
        'category': 'Test Category',
        'customerId': 'TestCustomerID',
        'status': 'ACTIVE',
        'images': ['TestImage']
      });

      // 验证 markAsSold 是否被正确调用
      verify(mockPostApi.markAsSold(any)).called(1);

      // 这里添加更多验证，比如状态是否更新
    });
  });
}

