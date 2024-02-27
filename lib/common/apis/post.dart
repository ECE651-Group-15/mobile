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

  static Future<EditPostResponseEntity> editPost(
      EditPostRequestEntity req) async {
    var response = await HttpUtil().post(
      '${APIConstants.baseUrl}/v1/api/listings/update-listing',
      data: req.toJson(),
    );
    print(response);
    return EditPostResponseEntity.fromJson(response);
  }

  static Future<UnstarPostResponseEntity> unStarPost(
      UnstarPostRequestEntity req) async {
    var response = await HttpUtil().post(
      '${APIConstants.baseUrl}/v1/api/listing-profile/unstar-listing',
      data: req.toJson(),
    );
    print(response);
    return UnstarPostResponseEntity.fromJson(response);
  }

  static Future<GetProfileResponseEntity> getProfile(
      GetProfileRequestEntity req) async {
    // 确保req对象中有customerId属性，并且已经被赋值
    String? customerId = req.customerId;

    // 动态构造URL，插入customerId
    String url = '${APIConstants.baseUrl}/v1/api/profile/get-profile/$customerId';

    var response = await HttpUtil().post(
      url,
      data: req.toJson(),
    );
    // print(response);
    return GetProfileResponseEntity.fromJson(response);
  }

  static Future<LoginResponseEntity> logInPost(
      LoginRequestEntity req) async {
    var response = await HttpUtil().post(
      '${APIConstants.baseUrl}/v1/api/profile/login',
      data: req.toJson(),
    );
    print(response);
    return LoginResponseEntity.fromJson(response);
  }

}
