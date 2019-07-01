import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'calculator/app.dart';

void main() {
  // 设置状态栏颜色
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
  // 强制竖屏
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(App());
}
