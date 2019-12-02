import 'package:flutter/material.dart';
import 'package:joke/common/common_color.dart';

class EmptyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            'images/icon_no_data.png',
            width: 80.0,
            height: 80.0,
          ),
          Padding(
            padding: EdgeInsets.only(top: 5.0),
            child: Text(
              '暂无数据',
              style: TextStyle(color: Color(CommonColor.tips_color), fontSize: 18.0),
            ),
          )
        ],
      ),
    );
  }
}
