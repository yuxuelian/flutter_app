import 'package:flutter/material.dart';

class EmptyWidget extends StatefulWidget {
  final Widget child;

  EmptyWidget({Key key, this.child}) : super(key: key);

  _EmptyWidgetState createState() => _EmptyWidgetState();
}

class _EmptyWidgetState extends State<EmptyWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 360,
      height: 500,
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Image.asset('assets/icon_empty.png', width: 150),
          Padding(padding: EdgeInsets.only(top: 10)),
          Text('这里空空如也......', style: TextStyle(fontSize: 18, color: Color(0xFF2196F3))),
        ],
      ),
    );
  }
}
