// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:news_app/core/extensions/context_extension.dart';

class SpaceSizedHeightBox extends StatelessWidget {
  // ignore: always_put_required_named_parameters_first
  const SpaceSizedHeightBox({super.key, required this.height}) : assert(height > 0 && height <= 1);
  final double height;

  @override
  Widget build(BuildContext context) => SizedBox(height: context.height * height);
}
