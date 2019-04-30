import 'package:flutter/material.dart';
import 'package:scan_access/widget/logo.dart';
import 'package:scan_access/widget/state_button.dart';

import '../login_page.dart';

class DisableCardWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => DisableCardState();
}

class DisableCardState extends State<DisableCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF202020),
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: false,
        title: Text('我的电子门禁卡', style: TextStyle(fontSize: 16)),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: Container(
          width: 330,
          height: 480,
          child: Material(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Color(0xFFE0E0E0),
            elevation: 0,
            child: Column(
              children: <Widget>[
                LogoWidget(),
                Container(width: double.infinity, height: 1, color: Color(0xFF606060)),
                Expanded(
                  child: Container(),
                ),
                Center(
                  child: Text(
                    '状态:未登录',
                    style: TextStyle(fontSize: 16, color: Color(0xFF303030)),
                  ),
                ),
                Expanded(
                  child: Container(),
                ),
                Center(child: Image.asset('assets/qr_code_placeholder.png', width: 300)),
                Expanded(
                  child: Container(),
                ),
                Center(
                  child: StateButtonWidget(
                    child: Container(
                      width: 300,
                      height: 40,
                      child: Center(
                        child: Text(
                          '登录',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    onTap: () {
                      // 跳转到登录页面
                      LoginPage.start(context).then((res) {
                        print(res);
                      });
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
                Expanded(
                  child: Container(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
