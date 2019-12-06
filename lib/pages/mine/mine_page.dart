import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:joke/common/common_constant.dart';
import 'package:joke/widget/list_item.dart';
import 'package:joke/widget/top_bar_clipper.dart';

///个人中心
class MinePage extends StatefulWidget {
  final String title;

  const MinePage({Key key, this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return MinePageState();
  }
}

class MinePageState extends State<MinePage> with AutomaticKeepAliveClientMixin {
  EasyRefreshController _controller = EasyRefreshController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "个人中心",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 0.0,
      ),
      body: Stack(
        children: <Widget>[
          Container(
            height: double.infinity,
            child: Column(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Container(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          EasyRefresh.custom(
            controller: _controller,
            slivers: <Widget>[
              SliverList(
                delegate: SliverChildListDelegate([
                  // 顶部栏
                  new Stack(
                    children: <Widget>[
                      Container(
                        width: double.infinity,
                        height: 220.0,
                        color: Colors.white,
                      ),
                      ClipPath(
                        clipper: new TopBarClipper(CommonConstant.width, 200.0),
                        child: new SizedBox(
                          width: double.infinity,
                          height: 200.0,
                          child: new Container(
                            width: double.infinity,
                            height: 220.0,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                      // 名字
                      Container(
                        margin: new EdgeInsets.only(top: 40.0),
                        child: new Center(
                          child: new Text(
                            'PeakChao',
                            style: new TextStyle(
                                fontSize: 30.0, color: Colors.white),
                          ),
                        ),
                      ),
                      // 图标
                      Container(
                        margin: new EdgeInsets.only(top: 100.0),
                        child: new Center(
                            child: new Container(
                          width: 100.0,
                          height: 100.0,
                          child: new PreferredSize(
                            child: new Container(
                              child: new ClipOval(
                                child: new Container(
                                  color: Colors.white,
                                  child: new Image.asset(
                                      'images/ic_find_selected.png'),
                                ),
                              ),
                            ),
                            preferredSize: new Size(80.0, 80.0),
                          ),
                        )),
                      ),
                    ],
                  ),
                  // 内容
                  Container(
                    width: double.infinity,
                    color: Colors.white,
                    padding: EdgeInsets.all(10.0),
                    child: Card(
                        color: Colors.blue,
                        child: Container(
                          padding: EdgeInsets.all(10.0),
                          child: Column(
                            children: <Widget>[
                              ListItem(
                                icon: Icon(
                                  Icons.supervised_user_circle,
                                  color: Colors.white,
                                ),
                                title: 'QQ',
                                titleColor: Colors.white,
                                describe: '309324904',
                                describeColor: Colors.white,
                                onPressed: () {
//                        launch(
//                            'mqqopensdkapi://bizAgent/qm/qr?url=http%3A%2F%2Fqm.qq.com%2Fcgi-bin%2Fqm%2Fqr%3Ffrom%3Dapp%26p%3Dandroid%26k%3DMNLtkvnn4n28UIB0gEgm2-WBmqmGWk0Q');
                                },
                              ),
                              ListItem(
                                icon: Icon(
                                  Icons.http,
                                  color: Colors.white,
                                ),
                                title: 'github',
                                titleColor: Colors.white,
                                describe: 'https://github.com/zhangzhichaolove',
                                describeColor: Colors.white,
                                onPressed: () {
                                  //launch('https://github.com/zhangzhichaolove');
                                },
                              )
                            ],
                          ),
                        )),
                  ),
                  Container(
                    width: double.infinity,
                    color: Colors.white,
                    padding: EdgeInsets.all(10.0),
                    child: Card(
                        color: Colors.green,
                        child: Container(
                          padding: EdgeInsets.all(10.0),
                          child: Column(
                            children: <Widget>[
                              ListItem(
                                icon: Icon(
                                  Icons.person,
                                  color: Colors.white,
                                ),
                                title: 'phone',
                                titleColor: Colors.white,
                                describe: '13594347817',
                                describeColor: Colors.white,
                              ),
                              ListItem(
                                icon: EmptyIcon(),
                                title: '性别',
                                titleColor: Colors.white,
                                describe: '男',
                                describeColor: Colors.white,
                              ),
                              ListItem(
                                icon: EmptyIcon(),
                                title: '城市',
                                titleColor: Colors.white,
                                describe: '中国-成都',
                                describeColor: Colors.white,
                              )
                            ],
                          ),
                        )),
                  ),
                  Container(
                    width: double.infinity,
                    color: Colors.white,
                    padding: EdgeInsets.all(10.0),
                    child: Card(
                        color: Colors.teal,
                        child: Container(
                          padding: EdgeInsets.all(10.0),
                          child: Column(
                            children: <Widget>[
                              ListItem(
                                icon: Icon(
                                  Icons.phone,
                                  color: Colors.white,
                                ),
                                title: 'phone',
                                titleColor: Colors.white,
                                describe: '13594347817',
                                describeColor: Colors.white,
                              ),
                              ListItem(
                                icon: EmptyIcon(),
                                title: 'email',
                                titleColor: Colors.white,
                                describe: 'admin@peakchao.com',
                                describeColor: Colors.white,
                                onPressed: () {
//                        launch(
//                            'mailto:admin@peakchao.com?subject=主题&body=内容');
                                },
                              )
                            ],
                          ),
                        )),
                  ),
                ]),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
