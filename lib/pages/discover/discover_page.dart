import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:joke/widget/sample_list_item_widget.dart';
import 'package:joke/widget/empty_widget.dart';

class DiscoverPage extends StatefulWidget {
  final String title;

  const DiscoverPage({Key key, this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return DiscoverPageState(title);
  }
}

class DiscoverPageState extends State<DiscoverPage>
    with AutomaticKeepAliveClientMixin {
  EasyRefreshController _controller = EasyRefreshController();
  final String title;
  var appBar;
  int _count = 0;

  DiscoverPageState(this.title);

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
        body: new EasyRefresh.custom(
          emptyWidget: this._count == 0 ? EmptyWidget() : null,
          enableControlFinishRefresh: true,
          enableControlFinishLoad: true,
          firstRefresh: true,
          controller: _controller,
          slivers: <Widget>[
            SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                return SampleListItem();
              }, childCount: _count),
            )
          ],
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
