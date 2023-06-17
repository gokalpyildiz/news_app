// ignore_for_file: lines_longer_than_80_chars

import 'package:news_app/product/initialize/app_cache.dart';

enum CacheItems {
  token;

  String get read => AppCache.instance.sharedPreference.getString(name) ?? '';
  Future<bool> write(String value) => AppCache.instance.sharedPreference.setString(name, value);
}
