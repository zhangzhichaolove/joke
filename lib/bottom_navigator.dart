import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:joke/common/common_color.dart';
import 'package:joke/common/common_dio.dart';
import 'package:joke/pages/choice/choice_page.dart';
import 'package:joke/pages/default_page.dart';
import 'package:joke/pages/discover/discover_page.dart';
import 'package:joke/pages/mine/mine_page.dart';

class BottomNavigator extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => BottomNavigatorState();
}

class BottomNavigatorState extends State<BottomNavigator> {
  PageController pageController;

  // 记录当前 tab 选择位置
  int tabIndex = 0;
  var tabImages;
  var tabPages;

  final tabTextStyleNormal = TextStyle(color: Color(CommonColor.main_color));
  final tabTextStyleSelected =
      TextStyle(color: Color(CommonColor.secondary_color));
  final tabTitles = <String>['精选', '发现', '我的'];

  var body;
  var appBar;

  @override
  void initState() {
    super.initState();
    _getVersion();
    pageController = new PageController(initialPage: this.tabIndex);
    tabImages ??= [
      [
        getTabImage('images/ic_chosen_normal.png'),
        getTabImage('images/ic_chosen_selected.png')
      ],
      [
        getTabImage('images/ic_find_normal.png'),
        getTabImage('images/ic_find_selected.png')
      ],
      [
        getTabImage('images/ic_mine_normal.png'),
        getTabImage('images/ic_mine_selected.png')
      ],
    ];
    tabPages ??= [
      ChoicePage(title: '精选'),
      DiscoverPage(title: '发现'),
      MinePage(title: '我的')
    ];
  }

  void _getVersion() {
    var param = {'versionType': 'android'};
    CommonDio.instance.getJson("v1/getVersion",
        parameters: param, method: CommonDio.GET, onSuccess: (data) {
      print('获取到版本信息：$data');
    });
  }

  Image getTabImage(imagePath) =>
      Image.asset(imagePath, width: 22, height: 22, fit: BoxFit.cover);

  Image getTabIcon(int index) {
    if (tabIndex == index) {
      return tabImages[index][1];
    }
    return tabImages[index][0];
  }

  TextStyle getTabTextStyle(int index) {
    if (tabIndex == index) {
      return tabTextStyleSelected;
    }
    return tabTextStyleNormal;
  }

  Text getTabTitle(index) => Text(
        tabTitles[index],
      );

  void onTap(int index) {
    setState(() {
      this.tabIndex = index;
    });
    pageController.animateToPage(index,
        duration: const Duration(milliseconds: 300), curve: Curves.ease);
  }

  void onPageChanged(int page) {
    setState(() {
      this.tabIndex = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    body = IndexedStack(
      children: tabPages,
      index: tabIndex,
    );
    body = PageView(
      children: tabPages,
      controller: pageController,
      onPageChanged:
          onPageChanged, /*physics: new NeverScrollableScrollPhysics(),*/
    );
    appBar = new AppBar(
      title: getTabTitle(tabIndex),
      centerTitle: true,
    );
    return Scaffold(
      appBar: null,
      body: this.body,
      //bottomNavigationBar: CupertinoTabBar(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(CommonColor.bottom_navigation_bar_bg),
        items: [
          BottomNavigationBarItem(
              icon: getTabIcon(0),
              title: getTabTitle(0),
              backgroundColor: Color(CommonColor.bottom_navigation_bar_bg)),
          BottomNavigationBarItem(
              icon: getTabIcon(1),
              title: getTabTitle(1),
              backgroundColor: Color(CommonColor.bottom_navigation_bar_bg)),
          BottomNavigationBarItem(
              icon: getTabIcon(2),
              title: getTabTitle(2),
              backgroundColor: Color(CommonColor.bottom_navigation_bar_bg)),
        ],
        currentIndex: tabIndex,
        type: BottomNavigationBarType.fixed,
        onTap: onTap,
      ),
    );
  }
}
