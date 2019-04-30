import 'package:flutter/material.dart';

class Logo2Widget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      padding: EdgeInsets.only(left: 20),
      child: Row(
        children: <Widget>[
          Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                width: 50,
                height: 50,
                child: Center(
                  child: Image.asset('assets/icon_logo.png', width: 40),
                ),
                decoration: BoxDecoration(
                  color: Color(0xFFF0F0F0),
                  borderRadius: BorderRadius.all(Radius.circular(7)),
                ),
              ),
              Text('一石酷码通', style: TextStyle(fontSize: 16, color: Color(0xFF606060)))
            ],
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text('门禁摄像头扫此访客二维码开门', style: TextStyle(fontSize: 14, color: Color(0xFF606060))),
                Padding(padding: EdgeInsets.only(top: 10)),
                Text('扫码距离15cm-60cm', style: TextStyle(fontSize: 14, color: Color(0xFF606060))),
              ],
            ),
          )
        ],
      ),
    );
  }
}
