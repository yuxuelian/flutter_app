import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import '../utils/refresh_widget_build.dart';
import '../widget/empty_widget.dart';
import '../widget/member_input_dialog.dart';
import '../widget/state_button.dart';
import '../widget/member_item.dart';

class ManageMemberPage extends StatefulWidget {
  /// 跳转到设置页面
  static Future<T> start<T extends Object>(BuildContext context) {
    return Navigator.of(context, rootNavigator: true).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => ManageMemberPage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) => MyApp.createTransition(animation, child),
        transitionDuration: Duration(milliseconds: 400),
      ),
    );
  }

  @override
  State<StatefulWidget> createState() => ManageMemberState();
}

class ManageMemberState extends State<ManageMemberPage> {
  List<String> memberList = [
    '1',
    '1',
    '1',
    '1',
    '1',
  ];

  /// 显示二维码生成对话框
  void _showMemberInputDialog(BuildContext context) {
    showDialog<bool>(context: context, builder: (BuildContext context) => MemberInputDialogWidget()).then((resValue) {});
  }

  @override
  Widget build(BuildContext context) {
    final slivers = <Widget>[
      CupertinoSliverRefreshControl(
        onRefresh: () {
          return Future.delayed(const Duration(seconds: 2));
        },
        builder: buildRefreshWidget,
      ),
    ];
    if (memberList.isNotEmpty) {
      slivers.add(SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return MemberItem(
              () {
                print("点击MemberItem");
              },
              "王开波",
              "15682070710",
              "业主",
              "1-1-1=1",
              "2019-04-22 16:22:50",
            );
          },
          childCount: memberList.length,
        ),
      ));
    } else {
      slivers.add(SliverToBoxAdapter(
        child: EmptyWidget(),
      ));
    }
    return Scaffold(
      backgroundColor: Color(0xFFF0F0F0),
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('注册新成员', style: TextStyle(fontSize: 16, color: Colors.white)),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: CustomScrollView(
              slivers: slivers,
            ),
          ),
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 20, top: 10),
            child: StateButtonWidget(
              child: Container(
                width: 340,
                height: 40,
                child: Center(
                  child: Text(
                    '注册新成员',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              onTap: () {
                _showMemberInputDialog(context);
              },
              stateEnabled: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(7)),
                gradient: LinearGradient(colors: <Color>[Color(0xFF05A8F1), Color(0xFF25EAA6)]),
              ),
              statePressed: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(7)),
                gradient: LinearGradient(colors: <Color>[Color(0xFF0558F1), Color(0xFF00D080)]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
