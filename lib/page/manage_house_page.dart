import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provide/provide.dart';

import '../main.dart';
import '../store/user_store.dart';
import '../widget/community_item.dart';
import '../widget/empty_widget.dart';

class ManageHousePage extends StatefulWidget {
  static Future<T> start<T extends Object>(BuildContext context) {
    return Navigator.of(context, rootNavigator: true).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => ManageHousePage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) => MyApp.createTransition(animation, child),
        transitionDuration: Duration(milliseconds: 400),
      ),
    );
  }

  @override
  State<StatefulWidget> createState() => ManageHouseState();
}

class ManageHouseState extends State<ManageHousePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF0F0F0),
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('我的房屋', style: TextStyle(fontSize: 16, color: Colors.white)),
        centerTitle: true,
        elevation: 0,
      ),
      body: Provide<BaseUserStore>(builder: (context, child, userStore) {
        final houseMember = userStore.selectedCommunity.house_member;
        final slivers = <Widget>[];
        if (houseMember.isNotEmpty) {
          slivers.add(SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                if (index == 0) {
                  return CommunityItemWidget(userStore.selectedCommunity, enable: false);
                } else {
                  final memberItem = houseMember[index - 1];
                  return Container(
                    height: 40,
                    decoration: BoxDecoration(color: Colors.white, border: Border(top: BorderSide(color: Color(0xFF606060), width: 1))),
                    padding: EdgeInsets.only(left: 30, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(memberItem.fullHouseName, style: TextStyle(color: Color(0xFF606060), fontSize: 14)),
                        Text(memberItem.type_name, style: TextStyle(color: Color(0xFF606060), fontSize: 14)),
                      ],
                    ),
                  );
                }
              },
              childCount: houseMember.length + 1,
            ),
          ));
        } else {
          slivers.add(SliverToBoxAdapter(child: EmptyWidget()));
        }
        return CustomScrollView(slivers: slivers);
      }),
    );
  }
}
