import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:joke/common/common_color.dart';
import 'package:joke/router/router_manager.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/ball_pulse_header.dart';
import 'package:flutter_easyrefresh/ball_pulse_footer.dart';

void main() {
  Router router = new Router();
  RouterManager.configureRouter(router);
  RouterManager.router = router;
  runApp(AppRoot());
  SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  );
  SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  //BallPulseHeader,MaterialHeader
  EasyRefresh.defaultHeader = BallPulseHeader();
  //BallPulseFooter,MaterialFooter
  EasyRefresh.defaultFooter = BallPulseFooter();
}

class AppRoot extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AppRootPageState();
}

class _AppRootPageState extends State<AppRoot> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primaryColor: Color(CommonColor.secondary_color),
          accentColor: Color(CommonColor.secondary_color)),
      onGenerateRoute: RouterManager.router.generator,
    );
  }
}
