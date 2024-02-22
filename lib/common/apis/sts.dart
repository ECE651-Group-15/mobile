import 'package:exchange/common/entities/entities.dart';
import 'package:exchange/common/utils/utils.dart';

class StsApi {
  static Future<StsAuthResponseEntity> getStsAuth() async {
    const url =
        'https://exchange-vwdpdyrqzw.cn-hangzhou.fcapp.run/api/v1/auth/sts';
    var response = await HttpUtil().post(url);
    return StsAuthResponseEntity.fromJson(response);
  }
}
