import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/main.dart';
import 'package:flutter_app/page/ManageHousePage.dart';
import 'package:flutter_app/page/ManageMemberPage.dart';
import 'package:flutter_app/widget/LogoWidget.dart';
import 'package:flutter_app/widget/StateButtonWidget.dart';

class SceneHomePage extends StatelessWidget {
  static Future<T> toSceneHomePage<T extends Object>(BuildContext context) {
    return Navigator.of(context, rootNavigator: true).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
          // 要跳转的页面
          return SceneHomePage();
        },
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          // 返回一个动画
          return MyApp.createTransition(animation, child);
        },
        transitionDuration: Duration(milliseconds: 400),
      ),
    );
  }

  /// 创建按钮的方法
  Widget createMenuButton(String icon, String label, GestureTapCallback onTap) {
    return Container(
      width: 170,
      height: 134,
      child: Center(
        child: Card(
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15.0))),
          child: StateButtonWidget(
            child: Container(
              width: 154,
              height: 120,
              child: Column(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Container(),
                  ),
                  Center(
                    child: Image.asset(
                      icon,
                      width: 60,
                    ),
                  ),
                  Center(
                    child: Text(
                      label,
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF606060),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(),
                  ),
                ],
              ),
            ),
            stateEnabled: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            statePressed: BoxDecoration(
              color: Color(0xFFD0D0D0),
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            onTap: onTap,
          ),
        ),
      ),
    );
  }

  /// 显示确认退出对话框
  void _showAlertDialog({@required BuildContext context, @required Widget child}) {
    showDialog<bool>(context: context, builder: (BuildContext context) => child).then((resValue) {
      if (resValue) {
//        Navigator.of(context, rootNavigator: true).pop();
      }
    });
  }

  Widget createDialogWidget() {
    return AlertDialog(
      content: Container(
        width: 280,
        height: 300,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
        ),
        child: Column(
          children: <Widget>[
            LogoWidget(),
            Container(
              decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xFFD0D0D0)))),
              padding: EdgeInsets.only(left: 20, right: 20),
              child: TextFormField(
                keyboardType: TextInputType.phone,
                maxLength: 11,
                decoration: InputDecoration(
                  // 主要目的是隐藏Counter
                  counter: Container(),
                  icon: Image.asset(
                    "images/icon_user.png",
                    width: 26,
                  ),
                  hintText: "请输入手机号",
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 6, bottom: 6),
                ),
                style: TextStyle(fontSize: 16),
                scrollPadding: EdgeInsets.all(0),
              ),
            ),
            Container(
              decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xFFD0D0D0)))),
              padding: EdgeInsets.only(left: 20, right: 20),
              child: TextFormField(
                keyboardType: TextInputType.phone,
                maxLength: 11,
                decoration: InputDecoration(
                  // 主要目的是隐藏Counter
                  counter: Container(),
                  icon: Image.asset(
                    "images/icon_phone.png",
                    width: 26,
                  ),
                  hintText: "请输入手机号",
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 6, bottom: 6),
                ),
                style: TextStyle(fontSize: 16),
              ),
            ),
            Container(
              decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xFFD0D0D0)))),
              padding: EdgeInsets.only(left: 20, right: 20),
              child: TextFormField(
                keyboardType: TextInputType.phone,
                maxLength: 11,
                decoration: InputDecoration(
                  // 主要目的是隐藏Counter
                  counter: Container(),
                  icon: Image.asset(
                    "images/icon_validate_time.png",
                    width: 26,
                  ),
                  hintText: "请输入手机号",
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 6, bottom: 6),
                ),
                style: TextStyle(fontSize: 16),
              ),
            ),
            Container(
              decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xFFD0D0D0)))),
              padding: EdgeInsets.only(left: 20, right: 20),
              child: TextFormField(
                keyboardType: TextInputType.phone,
                maxLength: 11,
                decoration: InputDecoration(
                  // 主要目的是隐藏Counter
                  counter: Container(),
                  icon: Image.asset(
                    "images/icon_house.png",
                    width: 26,
                  ),
                  hintText: "请输入手机号",
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 6, bottom: 6),
                ),
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
      contentPadding: EdgeInsets.all(0),
      backgroundColor: Colors.transparent,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("场景主页", style: TextStyle(fontSize: 16, color: Colors.white)),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView(
        children: <Widget>[
          Image.asset("images/scene_title_img.png", width: 360),
          Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Container(),
              ),
              createMenuButton("images/icon_home_qr_code1.png", "生成访客二维码", () {
                // TODO 显示二维码生成对话框
                _showAlertDialog(
                  context: context,
                  child: createDialogWidget(),
                );
              }),
              createMenuButton("images/icon_home_qr_code2.png", "租住人员注册", () {
                // TODO 跳转到租客注册界面
                ManageMemberPage.toManageMember(context);
              }),
              Expanded(
                flex: 1,
                child: Container(),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Container(),
              ),
              createMenuButton("images/icon_home_house.png", "我的房屋", () {
                // TODO 查看我的房屋
                ManageHousePage.toManageHouse(context);
              }),
              createMenuButton("images/icon_home_family.png", "家庭人员注册", () {
                // TODO 注册家庭成员
                ManageMemberPage.toManageMember(context);
              }),
              Expanded(
                flex: 1,
                child: Container(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
