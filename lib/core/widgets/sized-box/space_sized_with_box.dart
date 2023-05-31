// ignore_for_file: always_put_required_named_parameters_first

import 'package:flutter/material.dart';
import 'package:news_app/core/extensions/context_extension.dart';

class SpaceSizedWidthBox extends StatelessWidget {
  const SpaceSizedWidthBox({super.key, required this.width}) : assert(width > 0 && width <= 1);
  final double width;
  @override
  Widget build(BuildContext context) => SizedBox(width: context.width * width);
}
