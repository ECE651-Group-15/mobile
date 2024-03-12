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
  List<Data>? data;

  SearchMainResponseEntity({this.code, this.data});

  SearchMainResponseEntity.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['price'] = this.price;
    data['longitude'] = this.longitude;
    data['latitude'] = this.latitude;
    data['category'] = this.category;
    data['customerId'] = this.customerId;
    data['status'] = this.status;
    data['images'] = this.images;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['customersWhoStarred'] = this.customersWhoStarred;
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
