import 'package:exchange/common/services/services.dart';
import 'package:exchange/common/values/values.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConfigStore extends GetxController {
  static ConfigStore get to => Get.find();

  bool isFirstOpen = false;

  // PackageInfo? _platform;
  // String get version => _platform?.version ?? '-';
  bool get isRelease => const bool.fromEnvironment("dart.vm.product");
  Locale locale = const Locale('zh', 'CN');
  List<Locale> languages = const [
    Locale('en', 'US'),
    Locale('zh', 'CN'),
  ];

  @override
  void onInit() {
    super.onInit();
    isFirstOpen = StorageService.to.getBool(storageDeviceFirstOpenKey);
  }

  Future<void> getPlatform() async {
    // _platform = await PackageInfo.fromPlatform();
  }

  // 标记用户已打开APP
  Future<bool> saveAlreadyOpen() {
    return StorageService.to.setBool(storageDeviceFirstOpenKey, false);
  }

  void onInitLocale() {
    var langCode = StorageService.to.getString(storageLanguageCodeKey);
    if (langCode.isEmpty) return;
    var index = languages.indexWhere((element) {
      return element.languageCode == langCode;
    });
    if (index < 0) return;
    locale = languages[index];
  }

  void onLocaleUpdate(Locale value) {
    locale = value;
    Get.updateLocale(value);
    StorageService.to.setString(storageLanguageCodeKey, value.languageCode);
  }
}
