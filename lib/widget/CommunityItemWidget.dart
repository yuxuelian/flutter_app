import 'package:flutter/material.dart';

import '../page/SceneHomePage.dart';
import 'StateButtonWidget.dart';

class CommunityItemWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CommunityItemState();
}

class CommunityItemState extends State<CommunityItemWidget> {
  @override
  Widget build(BuildContext context) {
    return StateButtonWidget(
      child: Container(
        height: 40,
        decoration: BoxDecoration(color: Colors.transparent, border: Border(top: BorderSide(color: Color(0xFFD0D0D0)))),
        child: Row(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 20),
            ),
            Center(
              child: Image.asset(
                "images/icon_community.png",
                width: 20,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10),
            ),
            Center(
              child: Text(
                "成都->汇锦广场",
                style: TextStyle(fontSize: 14, color: Colors.black),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(),
            ),
            Center(
              child: Image.asset(
                "images/right_back.png",
                width: 16,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 20),
            )
          ],
        ),
      ),
      stateEnabled: BoxDecoration(color: Colors.transparent),
      statePressed: BoxDecoration(color: Color(0xFFD0D0D0)),
      onTap: () {
        // 跳转到场景主页
        SceneHomePage.toSceneHomePage(context);
      },
    );
  }
}
