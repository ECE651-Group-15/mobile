class StsAuthResponseEntity {
  int? code;
  Data? data;
  String? message;

  StsAuthResponseEntity({this.code, this.data, this.message});

  StsAuthResponseEntity.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['code'] = code;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = message;
    return data;
  }
}

class Data {
  Headers? headers;
  int? statusCode;
  Body? body;

  Data({this.headers, this.statusCode, this.body});

  Data.fromJson(Map<String, dynamic> json) {
    headers =
        json['headers'] != null ? Headers.fromJson(json['headers']) : null;
    statusCode = json['statusCode'];
    body = json['body'] != null ? Body.fromJson(json['body']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (headers != null) {
      data['headers'] = headers!.toJson();
    }
    data['statusCode'] = statusCode;
    if (body != null) {
      data['body'] = body!.toJson();
    }
    return data;
  }
}

class Headers {
  String? accessControlAllowOrigin;
  String? accessControlExposeHeaders;
  String? connection;
  String? contentLength;
  String? contentType;
  String? date;
  String? etag;
  String? keepAlive;
  String? xAcsRequestId;
  String? xAcsTraceId;

  Headers(
      {this.accessControlAllowOrigin,
      this.accessControlExposeHeaders,
      this.connection,
      this.contentLength,
      this.contentType,
      this.date,
      this.etag,
      this.keepAlive,
      this.xAcsRequestId,
      this.xAcsTraceId});

  Headers.fromJson(Map<String, dynamic> json) {
    accessControlAllowOrigin = json['access-control-allow-origin'];
    accessControlExposeHeaders = json['access-control-expose-headers'];
    connection = json['connection'];
    contentLength = json['content-length'];
    contentType = json['content-type'];
    date = json['date'];
    etag = json['etag'];
    keepAlive = json['keep-alive'];
    xAcsRequestId = json['x-acs-request-id'];
    xAcsTraceId = json['x-acs-trace-id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['access-control-allow-origin'] = accessControlAllowOrigin;
    data['access-control-expose-headers'] = accessControlExposeHeaders;
    data['connection'] = connection;
    data['content-length'] = contentLength;
    data['content-type'] = contentType;
    data['date'] = date;
    data['etag'] = etag;
    data['keep-alive'] = keepAlive;
    data['x-acs-request-id'] = xAcsRequestId;
    data['x-acs-trace-id'] = xAcsTraceId;
    return data;
  }
}

class Body {
  AssumedRoleUser? assumedRoleUser;
  Credentials? credentials;
  String? requestId;

  Body({this.assumedRoleUser, this.credentials, this.requestId});

  Body.fromJson(Map<String, dynamic> json) {
    assumedRoleUser = json['AssumedRoleUser'] != null
        ? AssumedRoleUser.fromJson(json['AssumedRoleUser'])
        : null;
    credentials = json['Credentials'] != null
        ? Credentials.fromJson(json['Credentials'])
        : null;
    requestId = json['RequestId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (assumedRoleUser != null) {
      data['AssumedRoleUser'] = assumedRoleUser!.toJson();
    }
    if (credentials != null) {
      data['Credentials'] = credentials!.toJson();
    }
    data['RequestId'] = requestId;
    return data;
  }
}

class AssumedRoleUser {
  String? arn;
  String? assumedRoleId;

  AssumedRoleUser({this.arn, this.assumedRoleId});

  AssumedRoleUser.fromJson(Map<String, dynamic> json) {
    arn = json['Arn'];
    assumedRoleId = json['AssumedRoleId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['Arn'] = arn;
    data['AssumedRoleId'] = assumedRoleId;
    return data;
  }
}

class Credentials {
  String? accessKeyId;
  String? accessKeySecret;
  String? expiration;
  String? securityToken;

  Credentials(
      {this.accessKeyId,
      this.accessKeySecret,
      this.expiration,
      this.securityToken});

  Credentials.fromJson(Map<String, dynamic> json) {
    accessKeyId = json['AccessKeyId'];
    accessKeySecret = json['AccessKeySecret'];
    expiration = json['Expiration'];
    securityToken = json['SecurityToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['AccessKeyId'] = accessKeyId;
    data['AccessKeySecret'] = accessKeySecret;
    data['Expiration'] = expiration;
    data['SecurityToken'] = securityToken;
    return data;
  }
}
