import 'package:flutter/material.dart';
import 'package:instagram_flutter/utils/dimension_screen.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget mobilescreenlayout;
  final Widget webscreenlayout;
  const ResponsiveLayout(
      {super.key,
      required this.mobilescreenlayout,
      required this.webscreenlayout});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, Constraints) {
      if (Constraints.maxWidth > webscreensize) {
        return webscreenlayout;
      }
      return mobilescreenlayout;
    });
  }
}
