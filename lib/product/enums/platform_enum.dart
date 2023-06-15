import 'dart:io';

enum PlatformEnum {
  android,
  ios;

  static String get versionName {
    if (Platform.isAndroid) {
      return PlatformEnum.android.name;
    }
    if (Platform.isIOS) {
      return PlatformEnum.ios.name;
    }
    throw Exception('Platform unused please check!');
  }
}
