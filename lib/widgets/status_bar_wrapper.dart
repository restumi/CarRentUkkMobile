import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class StatusBarWrapper extends StatelessWidget {
  final Widget child;
  final bool lightStatusBar;

  const StatusBarWrapper({
    super.key,
    required this.child,
    this.lightStatusBar = true, // true = icon putih, false = icon hitam
  });

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: lightStatusBar ? Brightness.light : Brightness.dark,
        statusBarBrightness: lightStatusBar ? Brightness.dark : Brightness.light,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: lightStatusBar ? Brightness.light : Brightness.dark,
      ),
      child: child,
    );
  }
}
