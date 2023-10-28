import 'package:flutter/material.dart';
import 'package:instagram_flutter/provider/user_provider.dart';
import 'package:instagram_flutter/utils/global_variable.dart';
import 'package:provider/provider.dart';

class ResponsiveLayout extends StatefulWidget {
  final Widget mobilescreenlayout;
  final Widget webscreenlayout;
  const ResponsiveLayout(
      {super.key,
      required this.mobilescreenlayout,
      required this.webscreenlayout});

  @override
  State<ResponsiveLayout> createState() => _ResponsiveLayoutState();
}

class _ResponsiveLayoutState extends State<ResponsiveLayout> {
  @override
  void initState() {
    super.initState();
    addData();
  }

  addData() async {
    UserProvider _userprovider = Provider.of(context, listen: false);
    await _userprovider.refreshUser();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, Constraints) {
        if (Constraints.maxWidth > webscreensize) {
          return widget.webscreenlayout;
        }
        return widget.mobilescreenlayout;
      },
    );
  }
}
