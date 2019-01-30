import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/store/UserStore.dart';
import 'package:scoped_model/scoped_model.dart';

class SettingsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SettingsState();
  }
}

class SettingsState extends State<SettingsPage> {
  /// 退出登录按钮松开时的背景颜色
  final normalColor =
      LinearGradient(colors: <Color>[Color(0xFF05A8F1), Color(0xFF25EAA5)]);

  /// 退出登录按钮按下时的背景颜色
  final pressedColor =
      LinearGradient(colors: <Color>[Color(0xFF0558F1), Color(0xFF00EAA5)]);

  /// 按钮按下时的颜色变化
  Gradient btnGradient;

  @override
  void initState() {
    super.initState();
    btnGradient = normalColor;
  }

  void _showAlertDialog(
      {@required BuildContext context, @required Widget child}) {
    showCupertinoDialog<bool>(
        context: context,
        builder: (BuildContext context) => child).then((resValue) {
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
            child: GestureDetector(
              onTapUp: (details) {
                setState(() {
                  // 松开
                  btnGradient = normalColor;
                });
              },
              onTapCancel: () {
                setState(() {
                  // 按下
                  btnGradient = normalColor;
                });
              },
              onTapDown: (details) {
                setState(() {
                  // 按下
                  btnGradient = pressedColor;
                });
              },
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
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(7)),
                    gradient: btnGradient),
                height: 40,
                child: Center(
                  child: Text(
                    "退出登录",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
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
  // menuItem松手时的背景颜色
  final normalBgColor = Colors.transparent;

  /// menuItem按下时的背景颜色
  final pressedColor = Color(0xFFD0D0D0);

  Color itemBgColor;

  final MenuItemData menuItemData;

  MenuItemState(this.menuItemData);

  @override
  void initState() {
    itemBgColor = normalBgColor;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapUp: (details) {
        setState(() {
          // 松开
          itemBgColor = normalBgColor;
        });
      },
      onTapCancel: () {
        setState(() {
          // 按下
          itemBgColor = normalBgColor;
        });
      },
      onTapDown: (details) {
        setState(() {
          // 按下
          itemBgColor = pressedColor;
        });
      },
      onTap: () {
        // 点击时
        print(menuItemData.id);
      },
      child: Container(
        color: itemBgColor,
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
            ScopedModelDescendant<BaseUserStore>(
                builder: (context, child, model) {
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
    );
  }
}

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
