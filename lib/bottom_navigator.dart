import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:joke/common/common_color.dart';
import 'package:joke/pages/default_page.dart';

class BottomNavigator extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => BottomNavigatorState();
}

class BottomNavigatorState extends State<BottomNavigator> {
  // 记录当前 tab 选择位置
  int tabIndex = 0;
  var tabImages;
  var tabPages;

  final tabTextStyleNormal = TextStyle(color: Color(CommonColor.main_color));
  final tabTextStyleSelected =
      TextStyle(color: Color(CommonColor.secondary_color));
  final tabTitles = <String>['精选', '发现', '我的'];

  var body;

  @override
  void initState() {
    super.initState();
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
      DefaultPage(title: '精选'),
      DefaultPage(title: '发现'),
      DefaultPage(title: '我的')
    ];
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
        style: getTabTextStyle(index),
      );

  void onTap(int index) {
    setState(() {
      tabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    body = IndexedStack(
      children: tabPages,
      index: tabIndex,
    );
    return Scaffold(
      body: this.body,
      //bottomNavigationBar: CupertinoTabBar(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(CommonColor.tips_color),
        items: [
          BottomNavigationBarItem(
              icon: getTabIcon(0),
              title: getTabTitle(0),
              backgroundColor: Color(CommonColor.tips_color)),
          BottomNavigationBarItem(
              icon: getTabIcon(1),
              title: getTabTitle(1),
              backgroundColor: Color(CommonColor.tips_color)),
          BottomNavigationBarItem(
              icon: getTabIcon(2),
              title: getTabTitle(2),
              backgroundColor: Color(CommonColor.tips_color)),
        ],
        currentIndex: tabIndex,
        type: BottomNavigationBarType.fixed,
        onTap: onTap,
      ),
    );
  }
}
