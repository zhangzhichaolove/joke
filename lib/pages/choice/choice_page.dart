import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:joke/common/common_dio.dart';
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
  List<BannerItem> banners = new List();
  int _count = 1;

  ChoicePagePageState(this.title);

  @override
  void initState() {
    super.initState();
    this._getBanner();
  }

  void _getBanner() {
    var param = {'page': 1};
    CommonDio.instance.getJson("v1/getBanner",
        parameters: param, method: CommonDio.GET, onSuccess: (data) {
      List<BannerItem> list = new List();
      data.forEach((item) {
        list.add(new BannerItem(imgUrl: item["bannerImage"]));
      });
      setState(() {
        banners = list;
      });
    });
  }

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
          firstRefresh: true,
          enableControlFinishRefresh: true,
          enableControlFinishLoad: false,
          controller: _controller,
          headerIndex: 0,
          child: ListView.builder(
            padding: EdgeInsets.all(0.0),
            //shrinkWrap: true,
            itemBuilder: (context, index) {
              return index == 0
                  ? BannerView(
                      height: 200,
                      banners: this.banners,
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
