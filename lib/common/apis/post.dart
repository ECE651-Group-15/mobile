import 'package:exchange/common/entities/post.dart';
import 'package:exchange/common/utils/utils.dart';
import 'package:exchange/common/values/values.dart';

class PostApi {
  static Future<DeleteUserResponseEntity> deleteUser(
      DeleteUserRequestEntity req) async {
    String? profileId = req.profileId;
    String url =
        '${APIConstants.baseUrl}/v1/api/profile/delete-profile/$profileId';
    var response = await HttpUtil().post(
      url,
      data: req.toJson(),
    );
    // print(response);
    return DeleteUserResponseEntity.fromJson(response);
  }

  static Future<SearchMainResponseEntity> searchMain(
      SearchMainRequestEntity req) async {
    var response = await HttpUtil().post(
      '${APIConstants.baseUrl}/v1/api/listings/search-listing',
      data: req.toJson(),
    );
    // print(response);
    return SearchMainResponseEntity.fromJson(response);
  }

  static Future<EditProfileResponseEntity> editProfile(
      EditProfileRequestEntity req) async {
    var response = await HttpUtil().post(
      '${APIConstants.baseUrl}/v1/api/profile/update-profile',
      data: req.toJson(),
    );
    print(response);
    return EditProfileResponseEntity.fromJson(response);
  }

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

  static Future<StarListingResponseEntity> starPost(
      StarListingRequestEntity req) async {
    var response = await HttpUtil().post(
      '${APIConstants.baseUrl}/v1/api/listing-profile/star-listing',
      data: req.toJson(),
    );
    // print(response);
    return StarListingResponseEntity.fromJson(response);
  }

  static Future<UnstarPostResponseEntity> unStarPost(
      UnstarPostRequestEntity req) async {
    var response = await HttpUtil().post(
      '${APIConstants.baseUrl}/v1/api/listing-profile/unstar-listing',
      data: req.toJson(),
    );
    // print(response);
    return UnstarPostResponseEntity.fromJson(response);
  }

  static Future<GetProfileResponseEntity> getProfile(
      GetProfileRequestEntity req) async {
    // 确保req对象中有customerId属性，并且已经被赋值
    String? customerId = req.customerId;

    // 动态构造URL，插入customerId
    String url =
        '${APIConstants.baseUrl}/v1/api/profile/get-profile/$customerId';

    var response = await HttpUtil().post(
      url,
      data: req.toJson(),
    );
    // print(response);
    return GetProfileResponseEntity.fromJson(response);
  }

  static Future<LoginResponseEntity> logInPost(LoginRequestEntity req) async {
    var response = await HttpUtil().post(
      '${APIConstants.baseUrl}/v1/api/profile/login',
      data: req.toJson(),
    );
    print(response);
    return LoginResponseEntity.fromJson(response);
  }

  static Future<CheckEmailResponseEntity> checkEmail(
      CheckEmailRequestEntity req) async {
    var response = await HttpUtil().post(
      '${APIConstants.baseUrl}/v1/api/profile/check-email',
      data: req.toJson(),
    );
    // print(response);
    return CheckEmailResponseEntity.fromJson(response);
  }

  static Future<FetchPostedListingsResponseEntity> fetchListings(
      FetchPostedListingsRequestEntity req) async {
    var response = await HttpUtil().post(
      '${APIConstants.baseUrl}/v1/api/listing-profile/get-listing-page',
      data: req.toJson(),
    );
    return FetchPostedListingsResponseEntity.fromJson(response);
  }

  static Future<MarkAsSoldResponseEntity> markAsSold(
      MarkAsSoldRequestEntity req) async {
    var response = await HttpUtil().post(
      '${APIConstants.baseUrl}/v1/api/listings/update-listing',
      data: req.toJson(),
    );
    return MarkAsSoldResponseEntity.fromJson(response);
  }

  static Future<GetCompletedOrderResponseEntity> getCompletedOrder(
      GetCompletedOrderRequestEntity req) async {
    var response = await HttpUtil().post(
      '${APIConstants.baseUrl}/v1/api/listing-profile/get-customer-completed-listings',
      data: req.toJson(),
    );
    return GetCompletedOrderResponseEntity.fromJson(response);
  }
}
