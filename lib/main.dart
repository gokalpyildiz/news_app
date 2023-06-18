// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/feature/home/view/home_view.dart';
import 'package:news_app/product/constants/index.dart';
import 'package:news_app/product/initialize/app_builder.dart';
import 'package:news_app/product/initialize/app_theme.dart';
import 'package:news_app/product/initialize/application_start.dart';

Future<void> main() async {
  await ApplicationStart.init();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) => AppBuilder(child).build(),
      title: StringConstants.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme(context).theme,
      home: const HomeView(),
    );
  }
}
