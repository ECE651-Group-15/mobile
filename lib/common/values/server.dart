// 后端服务线上地址
class APIConstants {
  static const String baseUrl =
      'http://ec2-18-223-182-150.us-east-2.compute.amazonaws.com:8080';
  static const String fetchCustomerPostedListingsUrl =
      '$baseUrl/v1/api/listing-profile/get-listing-page';
  static const String fetchUserStarredListsUrl =
      '$baseUrl/v1/api/profile/get-profile';
  static const String starListingUrl =
      '$baseUrl/v1/api/listing-profile/star-listing';
  static const String createProfileUrl =
      '$baseUrl/v1/api/profile/create-profile';
  static const String checkEmail = '$baseUrl/v1/api/profile/check-email';
  static const String customerPostedListings =
      '$baseUrl/v1/api/listing-profile/get-customer-posted-listings';
  static const String deleteListing = '$baseUrl/v1/api/listings/delete-listing';
  static const String starredListing =
      '$baseUrl/v1/api/listing-profile/starred-listings';
  static const String updateProfile = '$baseUrl/v1/api/profile/update-profile';
  static const String login = '$baseUrl/v1/api/profile/login';
}
