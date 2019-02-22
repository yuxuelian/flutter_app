import 'package:flutter/material.dart';

class LogoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      padding: EdgeInsets.only(left: 20),
      decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xFFD0D0D0)))),
      child: Row(
        children: <Widget>[
          Container(
            width: 60,
            height: 60,
            child: Center(
              child: Image.asset("images/icon_logo.png", width: 50),
            ),
            decoration: BoxDecoration(
              color: Color(0xFFF0F0F0),
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10),
          ),
          Column(
            children: <Widget>[
              //  Column 高度会撑满父容器
              // 前后加 Expanded  的目的是使中间的内容居中
              Expanded(
                flex: 1,
                child: Container(),
              ),
              Image.asset("images/show_qr_code_top_img.png", width: 90),
              Text(
                "一石酷码通",
                style: TextStyle(color: Color(0xFF606060), fontSize: 16),
              ),
              Expanded(
                flex: 1,
                child: Container(),
              )
            ],
          ),
          Expanded(
            flex: 1,
            child: Container(),
          ),
        ],
      ),
    );
  }
}
