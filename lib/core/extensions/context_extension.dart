// ignore_for_file: lines_longer_than_80_chars

import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';

import '../constants/responsivity_constants.dart';
import '../widgets/sized-box/space_sized_height_box.dart';
import '../widgets/sized-box/space_sized_with_box.dart';

extension ContextExtension on BuildContext {
  MediaQueryData get mediaQuery => MediaQuery.of(this);
  // TextTheme get textTheme => Theme.of(this).textTheme;
  TextTheme get primaryTextTheme => Theme.of(this).primaryTextTheme;

  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  ThemeData get appTheme => Theme.of(this);
  MaterialColor get randomColor => Colors.primaries[Random().nextInt(17)];

  bool get isKeyBoardOpen => MediaQuery.of(this).viewInsets.bottom > 0;
  Brightness get appBrightness => MediaQuery.of(this).platformBrightness;
}

extension MediaQueryExtensions on BuildContext {
  double get height => mediaQuery.size.height;
  double get width => mediaQuery.size.width;

  double get lowValue => height * 0.01;
  double get normalValue => height * 0.02;
  double get mediumValue => height * 0.04;
  double get highValue => height * 0.1;

  double dynamicWidth(double val) => width * val;
  double dynamicHeight(double val) => height * val;
}

extension DeviceOSExtension on BuildContext {
  bool get isAndroidDevice => Platform.isAndroid;
  bool get isIOSDevice => Platform.isIOS;
  bool get isWindowsDevice => Platform.isWindows;
  bool get isLinuxDevice => Platform.isLinux;
  bool get isMacOSDevicec => Platform.isMacOS;
}

//Device Screen Type By Width(300-600-900)
//Values from https://flutter.dev/docs/development/ui/layout/building-adaptive-apps
extension ContextDeviceTypeExtension on BuildContext {
  bool get isSmallScreen =>
      width >= ResponsivityConstants.instance.smallScreenSize && width < ResponsivityConstants.instance.mediumScreenSize ? true : false;

  bool get isMediumScreen =>
      width >= ResponsivityConstants.instance.mediumScreenSize && width < ResponsivityConstants.instance.largeScreenSize ? true : false;

  bool get isLargeScreen => width >= ResponsivityConstants.instance.largeScreenSize ? true : false;
}

extension DurationExtension on BuildContext {
  Duration get durationLow => const Duration(milliseconds: 500);
  Duration get durationNormal => const Duration(seconds: 1);
  Duration get durationSlow => const Duration(seconds: 2);
}

extension PaddingExtensionsAll on BuildContext {
  EdgeInsets get paddingLowAll => EdgeInsets.all(lowValue);
  EdgeInsets get paddingNormalAll => EdgeInsets.all(normalValue);
  EdgeInsets get paddingMediumAll => EdgeInsets.all(mediumValue);
  EdgeInsets get paddingHighAll => EdgeInsets.all(highValue);

  EdgeInsets get horizontalPaddingLow => EdgeInsets.symmetric(horizontal: lowValue);
  EdgeInsets get horizontalPaddingNormal => EdgeInsets.symmetric(horizontal: normalValue);
  EdgeInsets get horizontalPaddingMedium => EdgeInsets.symmetric(horizontal: mediumValue);
  EdgeInsets get horizontalPaddingHigh => EdgeInsets.symmetric(horizontal: highValue);

  EdgeInsets get verticalPaddingLow => EdgeInsets.symmetric(vertical: lowValue);
  EdgeInsets get verticalPaddingNormal => EdgeInsets.symmetric(vertical: normalValue);
  EdgeInsets get verticalPaddingMedium => EdgeInsets.symmetric(vertical: mediumValue);
  EdgeInsets get verticalPaddingHigh => EdgeInsets.symmetric(vertical: highValue);
}

extension SizedBoxExtension on BuildContext {
  Widget get emptySizedWidthBoxLow => const SpaceSizedWidthBox(width: 0.01);
  Widget get emptySizedWidthBoxLow3x => const SpaceSizedWidthBox(width: 0.03);
  Widget get emptySizedWidthBoxNormal => const SpaceSizedWidthBox(width: 0.05);
  Widget get emptySizedWidthBoxHigh => const SpaceSizedWidthBox(width: 0.1);

  Widget get emptySizedHeightBoxLow => const SpaceSizedHeightBox(height: 0.01);
  Widget get emptySizedHeightBoxLow3x => const SpaceSizedHeightBox(height: 0.03);
  Widget get emptySizedHeightBoxNormal => const SpaceSizedHeightBox(height: 0.05);
  Widget get emptySizedHeightBoxHigh => const SpaceSizedHeightBox(height: 0.1);
}

extension RadiusExtension on BuildContext {
  Radius get lowRadius => Radius.circular(width * 0.02);
  Radius get normalRadius => Radius.circular(width * 0.05);
  Radius get highRadius => Radius.circular(width * 0.1);
}

extension BorderExtension on BuildContext {
  BorderRadius get normalBorderRadius => BorderRadius.all(Radius.circular(width * 0.05));
  BorderRadius get lowBorderRadius => BorderRadius.all(Radius.circular(width * 0.02));
  BorderRadius get highBorderRadius => BorderRadius.all(Radius.circular(width * 0.1));
  BorderRadius get highTopBorderRadius => const BorderRadius.only(
        topLeft: Radius.circular(40),
        topRight: Radius.circular(40),
      );
  BorderRadius get highCustomTopBorderRadius => BorderRadius.only(
        topLeft: Radius.circular(width * 0.1),
        topRight: Radius.circular(width * 0.1),
      );
  RoundedRectangleBorder get roundedRectangleBorderLow => RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(lowValue)));

  RoundedRectangleBorder get roundedRectangleAllBorderNormal => RoundedRectangleBorder(borderRadius: BorderRadius.circular(normalValue));

  RoundedRectangleBorder get roundedRectangleBorderNormal =>
      RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(normalValue)));

  RoundedRectangleBorder get roundedRectangleBorderMedium =>
      RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(mediumValue)));

  RoundedRectangleBorder get roundedRectangleBorderHigh =>
      RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(highValue)));
}

// extension NavigationExtension on BuildContext {
//   NavigatorState get navigation => Navigator.of(this);

//   Future<void> pop() async {
//     await navigation.maybePop();
//   }

//   Future<T?> navigateName<T>(String path, {Object? data}) async {
//     return await navigation.pushNamed<T>(path, arguments: data);
//   }

//   Future<T?> navigateToReset<T>(String path, {Object? data}) async {
//     return await navigation.pushNamedAndRemoveUntil(path, (route) => false, arguments: data);
//   }

//   Future<dynamic> navigateToPage(Widget page, {Object? extra, SlideType type = SlideType.DEFAULT}) async {
//     return await navigation.push(type.route(page, RouteSettings(arguments: extra)));
//   }
// }

extension PaddingExtensionsSymmetric on BuildContext {
  EdgeInsets get paddingLowVertical => EdgeInsets.symmetric(vertical: lowValue);
  EdgeInsets get paddingNormalVertical => EdgeInsets.symmetric(vertical: normalValue);
  EdgeInsets get paddingMediumVertical => EdgeInsets.symmetric(vertical: mediumValue);
  EdgeInsets get paddingHighVertical => EdgeInsets.symmetric(vertical: highValue);

  EdgeInsets get paddingLowHorizontal => EdgeInsets.symmetric(horizontal: lowValue);
  EdgeInsets get paddingNormalHorizontal => EdgeInsets.symmetric(horizontal: normalValue);
  EdgeInsets get paddingMediumHorizontal => EdgeInsets.symmetric(horizontal: mediumValue);
  EdgeInsets get paddingHighHorizontal => EdgeInsets.symmetric(horizontal: highValue);
}

extension PageExtensions on BuildContext {
  Color get randomColor => Colors.primaries[Random().nextInt(17)];
}

extension ThemeExtensions on BuildContext {
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => theme.textTheme;
  ColorScheme get colors => theme.colorScheme;
}
