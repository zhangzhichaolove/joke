import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:joke/bottom_navigator.dart';
import 'package:joke/pages/default_page.dart';
import 'package:joke/pages/splash_page.dart';

class RouterManager {
  static Router router;

  /// 启动/欢迎页
  static const String splash = "/";

  /// 底部导航
  static const String navigator = "/navigator";

  /// 登陆页面
  static const String login = "/login";

  static void configureRouter(Router router) {
    router.notFoundHandler = new Handler(
        // ignore: missing_return
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      print("未找到路由!");
    });

    router.define(splash, handler: new Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return SplashPage();
    }));
    router.define(navigator, handler: new Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return BottomNavigator();
    }));
    router.define(login, handler: new Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      String title = params['title']?.first;
      return DefaultPage(
        title: title,
      );
    }));
  }
}
