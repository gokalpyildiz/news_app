//part of ile maine bağlayabilirdik sadece main ulaşsın diye ama şimdilik böyle yaptık
// ignore_for_file: lines_longer_than_80_chars

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

import 'package:news_app/firebase_options.dart';

import 'package:news_app/product/initialize/app_cache.dart';

@immutable
//sadece mainden görülmesi için part part of da kulllanabiliriz
class ApplicationStart {
  const ApplicationStart._();
  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await DeviceUtility.deviceInit();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    FirebaseUIAuth.configureProviders([
      EmailAuthProvider(),
      //google facebook gibi login işlemleri için de paketlerini eklemek gerekiyor
      //client id dokumanda da söylüyor google.info plist mi ney onun içinde varmış.
      GoogleProvider(clientId: '')
    ]);
    await AppCache.instance.setup();
  }
}
