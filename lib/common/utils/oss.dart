import 'package:dio/dio.dart';
import 'package:exchange/common/apis/api.dart';
import 'package:flutter_oss_aliyun/flutter_oss_aliyun.dart';

late Client client;

Future<void> initializeClient() async {
  client = Client.init(
    ossEndpoint: "oss-us-east-1.aliyuncs.com",
    bucketName: "ece-651",
    authGetter: _authGetter,
    dio: Dio(BaseOptions(connectTimeout: const Duration(minutes: 1))),
  );
}

Future<Auth> _authGetter() async {
  final response = await StsApi.getStsAuth();

  var body = response.data!.body!;
  var accessKey = body.credentials!.accessKeyId!;
  var accessSecret = body.credentials!.accessKeySecret!;
  var secureToken = body.credentials!.securityToken!;
  var expire = body.credentials!.expiration!;
  // print({
  //   "accessKey": accessKey,
  //   "accessSecret": accessSecret,
  //   "secureToken": secureToken,
  //   "expire": expire,
  // });

  return Auth(
    accessKey: accessKey,
    accessSecret: accessSecret,
    secureToken: secureToken,
    expire: expire,
  );
}
