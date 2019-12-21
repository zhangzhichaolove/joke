import 'dart:async';

import 'package:flutter/material.dart';
import 'package:joke/widget/banner_item.dart';

class BannerView extends StatefulWidget {
  final double height;
  final List<BannerItem> banners;

  const BannerView({Key key, this.height, this.banners}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _BannerViewState(height, banners);
  }
}

class _BannerViewState extends State<BannerView> {
  final double height;
  final List<BannerItem> banners;
  Timer timer;
  PageController controller;

  _BannerViewState(this.height, this.banners);

  @override
  void initState() {
    super.initState();
    controller = PageController(initialPage: 0);
    start();
  }

  start() {
    stop();
    if (banners != null && banners.length > 0) {
      timer = Timer.periodic(Duration(milliseconds: 3000), (timer) {
        controller.animateToPage((controller.page.toInt() + 1) % banners.length,
            duration: Duration(milliseconds: 300), curve: Curves.linear);
      });
    }
  }

  stop() {
    timer?.cancel();
    timer = null;
  }

  @override
  void dispose() {
    super.dispose();
    stop();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black12,
      height: height,
      child: Stack(
        children: <Widget>[getViewPager()],
      ),
    );
  }

  Widget getViewPager() {
    return PageView.builder(
        itemCount: banners != null ? banners.length : 0,
        controller: controller,
        itemBuilder: (context, index) {
          return InkWell(
            child: Image.network(banners[index].imgUrl, fit: BoxFit.cover),
            onTap: () {},
          );
        });
  }
}
