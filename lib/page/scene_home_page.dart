import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scan_access/main.dart';
import 'package:scan_access/widget/include.dart';
import 'package:scan_access/widget/state_button.dart';

import 'create_history_page.dart';
import 'manage_house_page.dart';
import 'manage_member_page.dart';

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
  Widget _buildMenuButton(String icon, String label, GestureTapCallback onTap) {
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
                    child: Container(),
                  ),
                  Center(
                    child: Image.asset(icon, width: 60),
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

  /// 显示二维码生成对话框
  void _showCreateQrDialog(BuildContext context) {
    showDialog<bool>(context: context, builder: (BuildContext context) => CreateQrDialogWidget()).then((resValue) {
      if (resValue != null) {
        if (resValue) {
          // 点击了生成按钮
//        Navigator.of(context, rootNavigator: true).pop();
        } else {
          // 跳转到 二维码生成历史 界面
          CreateHistoryPage.toCreateHistory(context).then((res) {});
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('场景主页', style: TextStyle(fontSize: 16, color: Colors.white)),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView(
        children: <Widget>[
          Image.asset('images/scene_title_img.png', width: 360),
          Row(
            children: <Widget>[
              Expanded(
                child: Container(),
              ),
              _buildMenuButton('images/icon_home_qr_code1.png', '生成访客二维码', () {
                // TODO 显示二维码生成对话框
                _showCreateQrDialog(context);
              }),
              _buildMenuButton('images/icon_home_qr_code2.png', '租住人员注册', () {
                // TODO 跳转到租客注册界面
                ManageMemberPage.toManageMember(context);
              }),
              Expanded(
                child: Container(),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Container(),
              ),
              _buildMenuButton('images/icon_home_house.png', '我的房屋', () {
                // TODO 查看我的房屋
                ManageHousePage.toManageHouse(context);
              }),
              _buildMenuButton('images/icon_home_family.png', '家庭人员注册', () {
                // TODO 注册家庭成员
                ManageMemberPage.toManageMember(context);
              }),
              Expanded(
                child: Container(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
