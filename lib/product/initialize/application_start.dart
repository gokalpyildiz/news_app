//part of ile maine bağlayabilirdik sadece main ulaşsın diye ama şimdilik böyle yaptık
// ignore_for_file: lines_longer_than_80_chars

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

import 'package:news_app/firebase_options.dart';

@immutable
class ApplicationStart {
  const ApplicationStart._();
  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    FirebaseUIAuth.configureProviders([
      EmailAuthProvider(),
      //google facebook gibi login işlemleri için de paketlerini eklemek gerekiyor
      GoogleProvider(clientId: '')
    ]);
    await DeviceUtility.deviceInit();
  }
}
