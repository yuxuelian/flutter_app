import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:scan_access/main.dart';
import 'package:scan_access/widget/include.dart';
import '../bean/index.dart';
import '../store/user_store.dart';
import 'create_history_page.dart';
import 'manage_house_page.dart';
import 'manage_member_page.dart';

class SceneHomePage extends StatelessWidget {
  static Future<T> start<T extends Object>(BuildContext context) {
    return Navigator.of(context, rootNavigator: true).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => SceneHomePage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) => MyApp.createTransition(animation, child),
        transitionDuration: Duration(milliseconds: 400),
      ),
    );
  }

  /// 创建按钮的方法
  Widget _buildMenuButton(String icon, String label, VoidCallback onPressed) {
    return Container(
      width: 170,
      height: 134,
      alignment: Alignment.center,
      child: SizedBox(
        width: 154,
        height: 120,
        child: RaisedButton(
          padding: EdgeInsets.all(0),
          color: Colors.white,
          highlightColor: Color(0xFFD0D0D0),
          splashColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          onPressed: onPressed,
          elevation: 2,
          highlightElevation: 2,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Image.asset(icon, width: 60),
              Text(
                label,
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF606060),
                ),
              ),
            ],
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
          CreateHistoryPage.start(context).then((res) {});
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final userStore = Provide.value<BaseUserStore>(context);
    return Scaffold(
      backgroundColor: Color(0xFFF0F0F0),
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(userStore.selectedCommunity.name, style: TextStyle(fontSize: 16, color: Colors.white)),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: <Widget>[
          Image.asset('assets/scene_title_img.png', width: 360),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _buildMenuButton('assets/icon_home_qr_code1.png', '生成访客二维码', () {
                // TODO 显示二维码生成对话框
                _showCreateQrDialog(context);
              }),
              _buildMenuButton('assets/icon_home_qr_code2.png', '租住人员注册', () {
                final houseMemberList = <HouseMember>[];
                userStore.selectedCommunity.house_member.forEach((houseMember) {
                  // 业主下面才有租客
                  if (houseMember.type == HouseMember.ENABLE_CREATE_MEMBER) {
                    houseMemberList.add(houseMember);
                  }
                });
                // TODO 跳转到租客注册界面
                ManageMemberPage.start(context, HouseMember.TENANT, '租客管理', houseMemberList);
              }),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _buildMenuButton('assets/icon_home_house.png', '我的房屋', () {
                // TODO 查看我的房屋
                ManageHousePage.start(context);
              }),
              _buildMenuButton('assets/icon_home_family.png', '家庭人员注册', () {
                final houseMemberList = <HouseMember>[];
                userStore.selectedCommunity.house_member.forEach((houseMember) {
                  // 业主和租客下面才有家庭成员
                  if (houseMember.type == HouseMember.ENABLE_CREATE_MEMBER || houseMember.type == HouseMember.TENANT) {
                    houseMemberList.add(houseMember);
                  }
                });
                // TODO 注册家庭成员
                ManageMemberPage.start(context, HouseMember.ENABLE_INVITE_VISITOR, '家庭成员管理', houseMemberList);
              }),
            ],
          ),
        ],
      ),
    );
  }
}
