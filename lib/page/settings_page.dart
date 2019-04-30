import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../main.dart';
import '../store/user_store.dart';
import '../widget/include.dart';
import 'package:provide/provide.dart';

import 'web_view_page.dart';

class SettingsPage extends StatelessWidget {
  /// 跳转到设置页面
  static Future<T> start<T extends Object>(BuildContext context) {
    return Navigator.of(context, rootNavigator: true).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => SettingsPage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) => MyApp.createTransition(animation, child),
        transitionDuration: Duration(milliseconds: 400),
      ),
    );
  }

  /// 显示确认退出对话框
  void _showAlertDialog(BuildContext context) {
    showDialog<bool>(
      context: context,
      builder: (BuildContext context) => MessageDialogWidget(
            message: '确定退出登录吗?',
            leftBtnText: '取消',
            rightBtnText: '确定',
          ),
    ).then((resValue) {
      // 返回值
      if (resValue != null && resValue) {
        // 点击了确定(退出当前页,并返回 true )
        Navigator.of(context, rootNavigator: true).pop(true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var menuList = <Widget>[
      Padding(
        padding: EdgeInsets.only(top: 30),
      ),
      // logo
      Center(
        child: Image.asset('assets/login_logo.png', width: 180),
      ),
      Padding(
        padding: EdgeInsets.only(top: 30),
      ),
    ];

    <MenuItemData>[
      MenuItemData(0, '手机号', 'assets/icon_mine_phone.png'),
      MenuItemData(1, '版本信息', 'assets/icon_mine_setting.png'),
      MenuItemData(2, '检查更新', 'assets/icon_check_update.png'),
//      MenuItemData(3, '修改密码', 'assets/icon_set_pwd.png'),
      MenuItemData(4, '用户协议', 'assets/icon_license.png'),
      MenuItemData(5, '使用说明', 'assets/icon_mine_user.png'),
    ].forEach((menuItemData) {
      menuList.add(MenuItem(menuItemData));
      menuList.add(CupLineWidget());
    });

    // 移出最后一个Widget分割线
    menuList.removeLast();

    return Scaffold(
      backgroundColor: Color(0xFFF0F0F0),
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('个人信息', style: TextStyle(fontSize: 16, color: Colors.white)),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              children: menuList,
            ),
          ),
          // 退出登录按钮
          Container(
            padding: EdgeInsets.all(20),
            child: StateButtonWidget(
              child: Container(
                height: 40,
                child: Center(
                  child: Text(
                    '退出登录',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              onTap: () {
                // 登录成功 修改全局变量
                _showAlertDialog(context);
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

class MenuItemData {
  final int id;
  final String label;
  final String icon;

  MenuItemData(this.id, this.label, this.icon);
}

class MenuItem extends StatefulWidget {
  /// menuItem的显示数据
  final MenuItemData menuItemData;

  MenuItem(this.menuItemData);

  @override
  State<StatefulWidget> createState() => MenuItemState(menuItemData);
}

class MenuItemState extends State<MenuItem> {
  final MenuItemData menuItemData;

  MenuItemState(this.menuItemData);

  @override
  Widget build(BuildContext context) {
    return StateButtonWidget(
      child: Container(
        height: 40,
        child: Row(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 20),
            ),
            Image.asset(menuItemData.icon, width: 20),
            Padding(
              padding: EdgeInsets.only(left: 6),
            ),
            Text(menuItemData.label),
            Expanded(
              child: Container(),
            ),
            Provide<BaseUserStore>(builder: (context, child, userStore) {
              if (menuItemData.id == 0) {
                return Text(userStore.userBean?.username ?? '---');
              } else if (menuItemData.id == 1) {
                return Text('1.0.0');
              }
              return Text('');
            }),
            Padding(
              padding: EdgeInsets.only(left: 6),
            ),
            Image.asset('assets/right_back.png', width: 16),
            Padding(
              padding: EdgeInsets.only(right: 20),
            ),
          ],
        ),
      ),
      onTap: () {
        // TODO 点击 menu 项
        switch (menuItemData.id) {
          case 0:
            break;
          case 1:
            break;
          case 2:
            break;
          case 3:
            break;
          case 4:
            WebViewPage.start(context, '用户协议', 'https://api.yishi-ai.com/static/html/license.html').then((res) {
              print(res);
            });
            break;
          case 5:
            WebViewPage.start(context, '使用说明', 'https://api.yishi-ai.com/static/file/direction/index.html').then((res) {
              print(res);
            });
            break;
          default:
            break;
        }
      },
      statePressed: BoxDecoration(color: Color(0xFFD0D0D0)),
    );
  }
}

/// 分割线
class CupLineWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1,
      margin: EdgeInsets.only(left: 20, right: 20),
      color: Color(0xFF999999),
    );
  }
}
