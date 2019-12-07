import 'package:flutter/material.dart';

class DefaultPage extends StatelessWidget {
  final String title;

  const DefaultPage({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(title),
    );
  }
}
