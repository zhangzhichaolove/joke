import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_header.dart';
import 'package:flutter_easyrefresh/material_footer.dart';
import 'package:flutter_easyrefresh/ball_pulse_header.dart';
import 'package:flutter_easyrefresh/ball_pulse_footer.dart';
import 'package:joke/widget/sample_list_item.dart';
import 'package:joke/widget/empty_widget.dart';

class DefaultPage extends StatefulWidget {
  final String title;

  const DefaultPage({Key key, this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return DefaultPageState(title);
  }
}

class DefaultPageState extends State<DefaultPage> with AutomaticKeepAliveClientMixin {
  EasyRefreshController _controller = EasyRefreshController();
  final String title;
  var appBar;
  int _count = 0;

  DefaultPageState(this.title);

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
            itemBuilder: (context, index) {
              return SampleListItem();
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
