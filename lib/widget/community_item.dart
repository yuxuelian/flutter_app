import 'package:flutter/material.dart';
import 'package:provide/provide.dart';

import '../bean/index.dart';
import '../page/scene_home_page.dart';
import '../store/user_store.dart';

class CommunityItemWidget extends StatefulWidget {
  final Community community;
  final bool enable;

  CommunityItemWidget(this.community, {bool enable}) : this.enable = enable ?? true;

  @override
  State<StatefulWidget> createState() => CommunityItemState();
}

class CommunityItemState extends State<CommunityItemWidget> {
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      color: Colors.white,
      splashColor: Colors.transparent,
      highlightColor: Color(0xFFD0D0D0),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      padding: EdgeInsets.all(0),
      child: Container(
        height: 40,
        decoration: BoxDecoration(border: Border(top: BorderSide(color: Color(0xFFD0D0D0)))),
        child: Row(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 20),
            ),
            Image.asset('assets/icon_community.png', width: 20),
            Padding(
              padding: EdgeInsets.only(left: 10),
            ),
            Text(
              '${widget.community.address} -> ${widget.community.name}',
              style: TextStyle(fontSize: 14, color: Color(0xFF303030)),
            ),
          ],
        ),
      ),
      onPressed: () {
        if (widget.enable) {
          // 记录点击的index
          final userStore = Provide.value<BaseUserStore>(context);
          userStore.selectedCommunity = widget.community;
          // 跳转到场景主页
          SceneHomePage.start(context);
        }
      },
    );
  }
}
