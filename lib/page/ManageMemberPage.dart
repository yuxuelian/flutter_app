import 'package:flutter/material.dart';
import 'package:flutter_app/main.dart';

class ManageMemberPage extends StatefulWidget {
  /// 跳转到设置页面
  static Future<T> toManageMember<T extends Object>(BuildContext context) {
    return Navigator.of(context, rootNavigator: true).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
          // 要跳转的页面
          return ManageMemberPage();
        },
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          // 返回一个动画
          return MyApp.createTransition(animation, child);
        },
        transitionDuration: Duration(milliseconds: 400),
        ),
      );
  }

  @override
  State<StatefulWidget> createState() {
    return ManageMemberState();
  }
}

class ManageMemberState extends State<ManageMemberPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("管理人员"),
        centerTitle: true,
        elevation: 0,
      ),
      body: Center(
        child: Text("管理人员"),
      ),
    );
  }
}
