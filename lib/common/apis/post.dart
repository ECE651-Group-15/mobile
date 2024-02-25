import 'package:exchange/common/entities/post.dart';
import 'package:exchange/common/utils/utils.dart';
import 'package:exchange/common/values/values.dart';

class PostApi {
  static Future<CreatePostResponseEntity> createPost(
      CreatePostRequestEntity req) async {
    var response = await HttpUtil().post(
      '${APIConstants.baseUrl}/v1/api/listings/create-listing',
      data: req.toJson(),
    );
    print(response);
    return CreatePostResponseEntity.fromJson(response);
  }
}
