class PostData {
  String? id;
  String? title;
  String? description;
  double? price;
  double? longitude;
  double? latitude;
  String? category;
  String? customerId;
  String? status;
  List<String>? images;
  String? createdAt;
  String? updatedAt;
  List<String>? customersWhoStarred;

  PostData(
      {this.id,
        this.title,
        this.description,
        this.price,
        this.longitude,
        this.latitude,
        this.category,
        this.customerId,
        this.status,
        this.images,
        this.createdAt,
        this.updatedAt,
        this.customersWhoStarred});

  PostData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    price = json['price'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    category = json['category'];
    customerId = json['customerId'];
    status = json['status'];
    images = json['images']?.cast<String>() ?? [];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    customersWhoStarred = json['customersWhoStarred']?.cast<String>() ?? [];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['price'] = price;
    data['longitude'] = longitude;
    data['latitude'] = latitude;
    data['category'] = category;
    data['customerId'] = customerId;
    data['status'] = status;
    data['images'] = images;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['customersWhoStarred'] = customersWhoStarred;
    return data;
  }
}

class UserData {
  String? id;
  String? name;
  String? email;
  String? avatar;
  String? phone;
  double? longitude;
  double? latitude;
  List<String>? postedListingIds;
  List<String>? starredListIds;

  UserData({
    this.id,
    this.name,
    this.email,
    this.avatar,
    this.phone,
    this.longitude,
    this.latitude,
    this.postedListingIds,
    this.starredListIds,
  });

  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    avatar = json['avatar'];
    phone = json['phone'];
    longitude = json['longitude']?.toDouble();
    latitude = json['latitude']?.toDouble();
    postedListingIds = json['postedListingIds']?.cast<String>() ?? [];
    starredListIds = json['starredListIds']?.cast<String>() ?? [];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['avatar'] = avatar;
    data['phone'] = phone;
    data['longitude'] = longitude;
    data['latitude'] = latitude;
    data['postedListingIds'] = postedListingIds;
    data['starredListIds'] = starredListIds;
    return data;
  }
}

class Data {
  String? id;
  String? title;
  String? description;
  double? price;
  double? longitude;
  double? latitude;
  String? category;
  String? customerId;
  String? status;
  List<String>? images;
  String? createdAt;
  String? updatedAt;
  List<String>? customersWhoStarred;

  Data(
      {this.id,
        this.title,
        this.description,
        this.price,
        this.longitude,
        this.latitude,
        this.category,
        this.customerId,
        this.status,
        this.images,
        this.createdAt,
        this.updatedAt,
        this.customersWhoStarred});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    price = json['price'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    category = json['category'];
    customerId = json['customerId'];
    status = json['status'];
    images = json['images'].cast<String>();
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    customersWhoStarred = json['customersWhoStarred'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['price'] = price;
    data['longitude'] = longitude;
    data['latitude'] = latitude;
    data['category'] = category;
    data['customerId'] = customerId;
    data['status'] = status;
    data['images'] = images;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['customersWhoStarred'] = customersWhoStarred;
    return data;
  }
}

class ListingData {
  List<ListingDetails>? listingDetails;

  ListingData({this.listingDetails});

  ListingData.fromJson(Map<String, dynamic> json) {
    if (json['listingDetails'] != null) {
      listingDetails = <ListingDetails>[];
      json['listingDetails'].forEach((v) {
        listingDetails!.add(ListingDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (listingDetails != null) {
      data['listingDetails'] =
          listingDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ListingDetails {
  Data? listingDetails;
  UserData? customerProfilesDetails;

  ListingDetails({this.listingDetails, this.customerProfilesDetails});

  ListingDetails.fromJson(Map<String, dynamic> json) {
    listingDetails = json['listingDetails'] != null
        ? Data.fromJson(json['listingDetails'])
        : null;
    customerProfilesDetails = json['customerProfilesDetails'] != null
        ? UserData.fromJson(json['customerProfilesDetails'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (listingDetails != null) {
      data['listingDetails'] = listingDetails!.toJson();
    }
    if (customerProfilesDetails != null) {
      data['customerProfilesDetails'] = customerProfilesDetails!.toJson();
    }
    return data;
  }
}

class OrderData {
  List<Data>? completedListings;

  OrderData({this.completedListings});

  OrderData.fromJson(Map<String, dynamic> json) {
    if (json['completedListings'] != null) {
      completedListings = <Data>[];
      json['completedListings'].forEach((v) {
        completedListings!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (completedListings != null) {
      data['completedListings'] =
          completedListings!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CreatePostRequestEntity {
  String? title;
  String? description;
  double? price;
  double? longitude;
  double? latitude;
  String? category;
  String? customerId;
  String? status;
  List<String>? images;

  CreatePostRequestEntity(
      {this.title,
      this.description,
      this.price,
      this.longitude,
      this.latitude,
      this.category,
      this.customerId,
      this.status,
      this.images});

  CreatePostRequestEntity.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    price = json['price'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    category = json['category'];
    customerId = json['customerId'];
    status = json['status'];
    images = json['images'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['title'] = title;
    data['description'] = description;
    data['price'] = price;
    data['longitude'] = longitude;
    data['latitude'] = latitude;
    data['category'] = category;
    data['customerId'] = customerId;
    data['status'] = status;
    data['images'] = images;
    return data;
  }
}

class CreatePostResponseEntity {
  int? code;
  PostData? data;

  CreatePostResponseEntity({this.code, this.data});

  CreatePostResponseEntity.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    data = json['data'] != null ? PostData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['code'] = code;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class DeleteUserRequestEntity {
  String? profileId;
  DeleteUserRequestEntity({this.profileId});
  DeleteUserRequestEntity.fromJson(Map<String, dynamic> json) {
    profileId = json['profileId'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['profileId'] = profileId;
    return data;
  }
}

class DeleteUserResponseEntity {
  int? code;
  UserData? data;

  DeleteUserResponseEntity({this.code, this.data});
  DeleteUserResponseEntity.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    data = json['data'] != null ? UserData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['code'] = code;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class EditPostRequestEntity {
  String? id;
  String? title;
  String? description;
  double? price;
  double? longitude;
  double? latitude;
  String? category;
  String? customerId;
  String? status;
  List<String>? images;

  EditPostRequestEntity(
      {this.id,
      this.title,
      this.description,
      this.price,
      this.longitude,
      this.latitude,
      this.category,
      this.customerId,
      this.status,
      this.images});

  EditPostRequestEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    price = json['price'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    category = json['category'];
    customerId = json['customerId'];
    status = json['status'];
    images = json['images'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['price'] = price;
    data['longitude'] = longitude;
    data['latitude'] = latitude;
    data['category'] = category;
    data['customerId'] = customerId;
    data['status'] = status;
    data['images'] = images;
    return data;
  }
}

class SearchMainRequestEntity {
  String? title;

  // Main constructor
  SearchMainRequestEntity({this.title});

  // Named constructor for initializing from JSON
  SearchMainRequestEntity.fromJson(Map<String, dynamic> json) {
    title = json['title'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['title'] = title;
    return data;
  }
}

class SearchMainResponseEntity {
  int? code;
  String? message;
  List<Data>? data;

  SearchMainResponseEntity({this.code, this.data});

  SearchMainResponseEntity.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class EditPostResponseEntity {
  int? code;
  PostData? data;

  EditPostResponseEntity({this.code, this.data});

  EditPostResponseEntity.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    data = json['data'] != null ? PostData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['code'] = code;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class UnstarPostRequestEntity {
  String? listingId;
  String? customerId;

  UnstarPostRequestEntity({
    this.listingId,
    this.customerId,
  });

  UnstarPostRequestEntity.fromJson(Map<String, dynamic> json) {
    listingId = json['listingId'];
    customerId = json['customerId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['listingId'] = listingId;
    data['customerId'] = customerId;
    return data;
  }
}

class UnstarPostResponseEntity {
  int? code;
  PostData? data;

  UnstarPostResponseEntity({this.code, this.data});

  UnstarPostResponseEntity.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    data = json['data'] != null ? PostData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['code'] = code;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class GetProfileRequestEntity {
  String? customerId;

  GetProfileRequestEntity({
    this.customerId,
  });

  GetProfileRequestEntity.fromJson(Map<String, dynamic> json) {
    customerId = json['customerId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['customerId'] = customerId;
    return data;
  }
}

class GetProfileResponseEntity {
  int? code;
  UserData? data;

  GetProfileResponseEntity({this.code, this.data});

  GetProfileResponseEntity.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    data = json['data'] != null ? UserData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['code'] = code;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class EditProfileRequestEntity {
  String? id;
  String? password;
  String? name;
  String? email;
  String? avatar;
  String? phone;
  double? longitude;
  double? latitude;

  EditProfileRequestEntity({
    this.id,
    this.password,
    this.name,
    this.email,
    this.avatar,
    this.phone,
    this.longitude,
    this.latitude,
  });

  EditProfileRequestEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    password = json['password'];
    name = json['name'];
    email = json['email'];
    avatar = json['avatar'];
    phone = json['phone'];
    longitude = json['longitude'];
    latitude = json['latitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['password'] = password;
    data['name'] = name;
    data['email'] = email;
    data['avatar'] = avatar;
    data['phone'] = phone;
    data['longitude'] = longitude;
    data['latitude'] = latitude;
    return data;
  }
}

class EditProfileResponseEntity {
  int? code;
  UserData? data;

  EditProfileResponseEntity({this.code, this.data});

  EditProfileResponseEntity.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    data = json['data'] != null ? UserData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['code'] = code;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class LoginRequestEntity {
  String? email;
  String? password;
  LoginRequestEntity({
    this.email,
    this.password,
  });

  LoginRequestEntity.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['email'] = email;
    data['password'] = password;
    return data;
  }
}

class LoginResponseEntity {
  int? code;
  UserData? data;

  LoginResponseEntity({this.code, this.data});

  LoginResponseEntity.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    data = json['data'] != null ? UserData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['code'] = code;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class CheckEmailRequestEntity {
  String? email;

  CheckEmailRequestEntity({this.email});

  CheckEmailRequestEntity.fromJson(Map<String, dynamic> json) {
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    return data;
  }
}

class CheckEmailResponseEntity {
  int? code;
  UserData? data;

  CheckEmailResponseEntity({this.code, this.data});

  CheckEmailResponseEntity.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    data = json['data'] != null ? UserData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['code'] = code;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class FetchPostedListingsRequestEntity {
  int? page;

  FetchPostedListingsRequestEntity({this.page});

  FetchPostedListingsRequestEntity.fromJson(Map<String, dynamic> json) {
    page = json['page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['page'] = page;
    return data;
  }
}

class FetchPostedListingsResponseEntity {
  int? code;
  ListingData? data;

  FetchPostedListingsResponseEntity({this.code, this.data});

  FetchPostedListingsResponseEntity.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    data = json['data'] != null ? ListingData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class StarListingRequestEntity {
  String? customerId;
  String? listingId;

  StarListingRequestEntity({this.customerId, this.listingId});

  StarListingRequestEntity.fromJson(Map<String, dynamic> json) {
    customerId = json['customerId'];
    listingId = json['listingId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['customerId'] = customerId;
    data['listingId'] = listingId;
    return data;
  }
}

class StarListingResponseEntity{
  int? code;
  PostData? data;

  StarListingResponseEntity({this.code, this.data});

  StarListingResponseEntity.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    data = json['data'] != null ? PostData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['code'] = code;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class MarkAsSoldRequestEntity  {
  String? id;
  String? title;
  String? description;
  double? price;
  double? longitude;
  double? latitude;
  String? category;
  String? customerId;
  String? status;
  List<String>? images;

  MarkAsSoldRequestEntity(
      { this.id,
        this.title,
        this.description,
        this.price,
        this.longitude,
        this.latitude,
        this.category,
        this.customerId,
        this.status,
        this.images, });

  MarkAsSoldRequestEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    price = json['price'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    category = json['category'];
    customerId = json['customerId'];
    status = json['status'];
    images = json['images'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] =id;
    data['title'] = title;
    data['description'] = description;
    data['price'] = price;
    data['longitude'] = longitude;
    data['latitude'] = latitude;
    data['category'] = category;
    data['customerId'] = customerId;
    data['status'] = status;
    data['images'] = images;
    return data;
  }
}

class MarkAsSoldResponseEntity {
  int? code;
  String? message;
  PostData? data;

  MarkAsSoldResponseEntity({this.code, this.data});

  MarkAsSoldResponseEntity.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    data = json['data'] != null ? PostData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['code'] = code;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class GetCompletedOrderRequestEntity {
  int? page;
  String? customerId;

  GetCompletedOrderRequestEntity({this.page, this.customerId});

  GetCompletedOrderRequestEntity.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    customerId = json['customerId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['page'] = page;
    data['customerId'] =customerId;
    return data;
  }
}

class GetCompletedOrderResponseEntity {
  int? code;
  String? message;
  OrderData? data;

  GetCompletedOrderResponseEntity({this.code, this.data});

  GetCompletedOrderResponseEntity.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    data = (json['data'] != null ? OrderData.fromJson(json['data']) : null);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

