import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/main.dart';
import 'package:flutter_app/store/UserStore.dart';
import 'package:flutter_app/widget/StateButtonWidget.dart';
import 'package:scoped_model/scoped_model.dart';

import 'WebViewPage.dart';

class SettingsPage extends StatelessWidget {
  /// 跳转到设置页面
  static Future<T> toSettings<T extends Object>(BuildContext context, BaseUserStore model) {
    return Navigator.of(context, rootNavigator: true).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
          // 要跳转的页面
          return SettingsPage();
        },
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          // 返回一个动画
          return MyApp.createTransition(animation, child);
        },
        transitionDuration: Duration(milliseconds: 400),
      ),
    );
  }

  /// 显示确认退出对话框
  void _showAlertDialog({@required BuildContext context, @required Widget child}) {
    showCupertinoDialog<bool>(context: context, builder: (BuildContext context) => child).then((resValue) {
      if (resValue) {
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
        child: Image.asset(
          "images/login_logo.png",
          width: 180,
        ),
      ),
      Padding(
        padding: EdgeInsets.only(top: 30),
      ),
    ];

    <MenuItemData>[
      MenuItemData(0, "手机号", "images/icon_mine_phone.png"),
      MenuItemData(1, "版本信息", "images/icon_mine_setting.png"),
      MenuItemData(2, "检查更新", "images/icon_check_update.png"),
      MenuItemData(3, "修改密码", "images/icon_set_pwd.png"),
      MenuItemData(4, "用户协议", "images/icon_license.png"),
      MenuItemData(5, "使用说明", "images/icon_mine_user.png"),
    ].forEach((menuItemData) {
      menuList.add(MenuItem(menuItemData));
      menuList.add(CupLineWidget());
    });

    // 移出最后一个Widget分割线
    menuList.removeLast();

    return Scaffold(
      appBar: AppBar(
        title: Text("个人信息"),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 1,
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
                    "退出登录",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              onTap: () {
                // 登录成功 修改全局变量
                _showAlertDialog(
                  context: context,
                  child: CupertinoAlertDialog(
                    title: const Text('提示:'),
                    content: const Text('确定退出登录吗?'),
                    actions: <Widget>[
                      CupertinoDialogAction(
                        child: const Text('取消'),
                        onPressed: () {
                          Navigator.pop(context, false);
                        },
                      ),
                      CupertinoDialogAction(
                        child: const Text('确定'),
                        onPressed: () {
                          Navigator.pop(context, true);
                        },
                      ),
                    ],
                  ),
                );
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
  State<StatefulWidget> createState() {
    return MenuItemState(menuItemData);
  }
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
              flex: 1,
              child: Container(),
            ),
            ScopedModelDescendant<BaseUserStore>(builder: (context, child, model) {
              if (menuItemData.id == 0) {
                return Text(model.getUserInfo.phone);
              } else if (menuItemData.id == 1) {
                return Text(model.getUserInfo.version);
              }
              return Text("");
            }),
            Padding(
              padding: EdgeInsets.only(left: 6),
            ),
            Image.asset("images/right_back.png", width: 16),
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
            WebViewPage.toWebViewPage(context, "用户协议", "https://www.baidu.com").then((res) {
              print(res);
            });
            break;
          case 5:
            WebViewPage.toWebViewPage(context, "使用说明", "https://www.baidu.com").then((res) {
              print(res);
            });
            break;
          default:
            break;
        }
      },
      stateEnabled: BoxDecoration(color: Colors.transparent),
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
