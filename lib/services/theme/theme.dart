import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:task_manager_app/services/theme/colors.dart';

setSystemChrome() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: primary,
    statusBarColor: primary,
    systemNavigationBarIconBrightness: Brightness.light,
    statusBarIconBrightness: Brightness.light,
    systemNavigationBarDividerColor: transparent,
  ));
}

ThemeData appTheme = ThemeData(
  useMaterial3: false,
  brightness: Brightness.light,
  primaryColor: primary,
  primarySwatch: mainMaterialColor,
  fontFamily: 'Ubuntu',
);
