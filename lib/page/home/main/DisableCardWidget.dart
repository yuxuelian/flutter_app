import 'package:flutter/material.dart';

class DisableCardWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("未登录"),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView(
        children: <Widget>[Text("测试")],
      ),
    );
  }
}
