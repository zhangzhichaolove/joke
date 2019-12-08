import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_header.dart';
import 'package:flutter_easyrefresh/material_footer.dart';
import 'package:flutter_easyrefresh/ball_pulse_header.dart';
import 'package:flutter_easyrefresh/ball_pulse_footer.dart';
import 'package:joke/widget/banner_item.dart';
import 'package:joke/widget/banner_widget.dart';
import 'package:joke/widget/sample_list_item_widget.dart';
import 'package:joke/widget/empty_widget.dart';

class ChoicePage extends StatefulWidget {
  final String title;

  const ChoicePage({Key key, this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ChoicePagePageState(title);
  }
}

class ChoicePagePageState extends State<ChoicePage>
    with AutomaticKeepAliveClientMixin {
  EasyRefreshController _controller = EasyRefreshController();
  final String title;
  var appBar;
  int _count = 0;

  ChoicePagePageState(this.title);

  @override
  Widget build(BuildContext context) {
    appBar = new AppBar(
      title: Text(
        title,
      ),
      centerTitle: true,
    );
//    _controller.callRefresh();
//    _controller.callLoad();
    List<BannerItem> list = new List();
    list.add(new BannerItem(
        imgUrl:
            'https://preview.qiantucdn.com/58pic/28/49/27/56858PIC2RNZyWeWB2Y5C_PIC2018.jpg!w1024_new_small'));
    list.add(new BannerItem(
        imgUrl:
            'https://preview.qiantucdn.com/58pic/32/96/95/2658PIC58PIC458PIC6Kd518zaUSY_PIC2018.png!w1024_new_small'));
    list.add(new BannerItem(
        imgUrl:
            'https://preview.qiantucdn.com/58pic/32/83/89/09R58PIC3Z1586MX5855d_PIC2018.png!w1024_new_small'));
    return Scaffold(
        appBar: appBar,
        body: new EasyRefresh(
          emptyWidget: this._count == 0 ? EmptyWidget() : null,
          enableControlFinishRefresh: true,
          enableControlFinishLoad: true,
          controller: _controller,
          //BallPulseHeader,MaterialHeader
          header: BallPulseHeader(),
          //BallPulseFooter,MaterialFooter
          footer: BallPulseFooter(),
          child: ListView.builder(
            padding: EdgeInsets.all(0.0),
            //shrinkWrap: true,
            itemBuilder: (context, index) {
              return index == 0
                  ? BannerView(
                      height: 200,
                      banners: list,
                    )
                  : SampleListItem();
            },
            itemCount: _count,
          ),
          onRefresh: () async {
            await Future.delayed(Duration(seconds: 2), () {
              _controller.finishRefresh(success: true);
              _controller.resetLoadState();
              setState(() {
                _count = 10;
              });
            });
          },
          onLoad: () async {
            await Future.delayed(Duration(seconds: 2), () {
              _controller.finishLoad(success: true, noMore: _count > 10);
              setState(() {
                _count += 10;
              });
            });
          },
        ));
  }

  @override
  bool get wantKeepAlive => true;
}