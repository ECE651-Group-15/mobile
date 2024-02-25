import 'package:exchange/common/entities/post.dart';
import 'package:exchange/common/utils/utils.dart';
import 'package:exchange/common/values/values.dart';

class PostApi {
  static Future<CreatePostResponseEntity> createPost(
      CreatePostRequestEntity req) async {
    var response = await HttpUtil().post(
      '$serverApiEndpoint/v1/api/listings/create-listing',
      data: req.toJson(),
    );
    print(response);
    return CreatePostResponseEntity.fromJson(response);
  }

  static Future<EditPostResponseEntity> editPost(
      EditPostRequestEntity req) async {
    var response = await HttpUtil().post(
      '$serverApiEndpoint/v1/api/listings/update-listing',
      data: req.toJson(),
    );
    print(response);
    return EditPostResponseEntity.fromJson(response);
  }
}
