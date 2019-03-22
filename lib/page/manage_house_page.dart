import 'package:flutter/material.dart';
import 'package:scan_access/main.dart';

class ManageHousePage extends StatefulWidget {
  /// 跳转到设置页面
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
        title: Text('管理房屋', style: TextStyle(fontSize: 16, color: Colors.white)),
        centerTitle: true,
        elevation: 0,
      ),
      body: Center(
        child: Text('管理房屋'),
      ),
    );
  }
}
