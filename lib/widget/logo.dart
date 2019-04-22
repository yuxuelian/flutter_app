import 'package:flutter/material.dart';

class LogoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      padding: EdgeInsets.only(left: 20),
      child: Row(
        children: <Widget>[
          Container(
            width: 60,
            height: 60,
            child: Center(
              child: Image.asset('assets/icon_logo.png', width: 50),
            ),
            decoration: BoxDecoration(
              color: Color(0xFFF0F0F0),
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10),
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Image.asset('assets/show_qr_code_top_img.png', width: 90),
                Text(
                  '一石酷码通',
                  style: TextStyle(color: Color(0xFF606060), fontSize: 16),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
