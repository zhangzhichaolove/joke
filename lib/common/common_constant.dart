import 'package:flutter/material.dart';

class CommonConstant {
  static double width;

  static double height;

  static double topPadding;

  static double bottomPadding;

  static double contentHeight;

  static init(BuildContext context) {
    //window.physicalSize
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    topPadding = MediaQuery.of(context).padding.top;
    bottomPadding = MediaQuery.of(context).padding.bottom;
    contentHeight = height - topPadding - bottomPadding;
  }
}
