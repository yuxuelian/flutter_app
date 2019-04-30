import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provide/provide.dart';

import '../../bean/index.dart';
import '../../http/request_method.dart';
import '../../store/user_store.dart';
import '../../utils/prefs_util.dart';
import '../../utils/refresh_widget_build.dart';
import '../../widget/community_item.dart';
import '../../widget/pic_selection.dart';
import '../../widget/state_button.dart';
import '../settings_page.dart';

// 已登录显示的页面
class MineWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MineState();
}

class MineState extends State<MineWidget> {
  Future<File> _onImageButtonPressed(ImageSource source) {
    return ImagePicker.pickImage(source: source);
  }

  Future<File> _showSheetDialog(BuildContext context) async {
    final value = await showModalBottomSheet<int>(
      context: context,
      builder: (context) => PicSelection(),
    );
    if (value != null) {
      ImageSource imageSource;
      switch (value) {
        case 0:
          // 拍照
          imageSource = ImageSource.camera;
          break;
        case 1:
          // 相册
          imageSource = ImageSource.gallery;
          break;
        default:
          return null;
      }
      // 获取一张图片
      File sourceImgFile = await _onImageButtonPressed(imageSource);
      if (sourceImgFile != null) {
        // 启动裁剪
        return ImageCropper.cropImage(
          sourcePath: sourceImgFile.path,
          toolbarTitle: '裁剪图片',
          toolbarColor: Colors.blue,
          ratioX: 1,
          ratioY: 1,
          circleShape: true,
          maxWidth: 300,
          maxHeight: 300,
        );
      }
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    _requestData();
  }

  Future<void> _requestData() async {
    // 延时一下
    await Future.delayed(const Duration(milliseconds: 500));
    final userStore = Provide.value<BaseUserStore>(context);
    if (userStore.isLogin) {
      try {
        // 开始刷新token
        LoginResultBean loginResult = await RequestApi.refreshToken();
        // 获取用户小区信息
        List<Community> communityList = await RequestApi.queryUserHouse();
        // 存储
        await PrefsUtil.saveToken(loginResult.token);
        await PrefsUtil.saveUserBean(loginResult.user);
        // 更新一下user
        userStore.userBean = loginResult.user;
        // 存储 communityList
        userStore.communityList = communityList;
      } catch (error) {
        print(error);
      }
    }
  }

  Future<void> toSettings() async {
    final resultValue = await SettingsPage.start(context);
    if (resultValue != null && resultValue) {
      // 清空本地存储
      await PrefsUtil.clear();
      final userStore = Provide.value<BaseUserStore>(context);
      // 确实点击了退出登录按钮
      userStore.isLogin = false;
      userStore.userBean = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Provide<BaseUserStore>(builder: (context, child, userStore) {
      return Column(
        children: <Widget>[
          Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Image.asset('assets/mine_top_bg.png', width: 360),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: AppBar(
                  title: Text(userStore.userBean.nickname, style: TextStyle(fontSize: 16, color: Colors.white)),
                  backgroundColor: Colors.transparent,
                  centerTitle: true,
                  elevation: 0,
                  actions: <Widget>[
                    StateButtonWidget(
                      child: Container(
                        padding: EdgeInsets.all(12),
                        child: Image.asset('assets/setting.png'),
                      ),
                      onTap: toSettings,
                      statePressed: BoxDecoration(color: Color(0x33909090)),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 35,
                child: GestureDetector(
                  onTap: () async {
                    final imgFile = await _showSheetDialog(context);
                    if (imgFile != null) {
                      Uint8List bytes = await imgFile.readAsBytes();
                      final base64 = 'data:image/png;base64,' + base64Encode(bytes);
                      try {
                        // 调用修改头像接口
                        final res = await RequestApi.alterInfo({'avatar': base64});
                        if (res != null) {
                          // 修改头像地址
                          userStore.userBean?.avatar = res['avatar'];
                          userStore.userBean = userStore.userBean;
                          Fluttertoast.showToast(msg: '修改头像成功', textColor: Colors.white, backgroundColor: Colors.green);
                        }
                      } catch (e) {
                        print(e);
                        Fluttertoast.showToast(msg: '修改头像失败', textColor: Colors.white, backgroundColor: Colors.red);
                      }
                    }
                  },
                  // 显示圆形图片
                  child: SizedBox(
                    width: 70,
                    height: 70,
                    child: ClipOval(
                      child: () {
                        final avatarUrl = userStore.userBean?.avatar;
                        if (avatarUrl != null && avatarUrl.startsWith("http")) {
                          return Image.network(avatarUrl);
                        } else {
                          return Image.asset('assets/header_icon_placeholder.png');
                        }
                      }(),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Container(
              color: Color(0xFFF0F0F0),
              child: CustomScrollView(
                slivers: <Widget>[
                  CupertinoSliverRefreshControl(
                    onRefresh: _requestData,
                    builder: buildRefreshWidget,
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => CommunityItemWidget(userStore.communityList[index]),
                      childCount: userStore.communityList?.length ?? 0,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('MineWidget didChangeDependencies');
  }

  @override
  void didUpdateWidget(MineWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    print('MineWidget didUpdateWidget');
  }

  @override
  void reassemble() {
    super.reassemble();
    print('MineWidget reassemble');
  }

  @override
  void deactivate() {
    super.deactivate();
    print('MineWidget deactivate');
  }

  @override
  void dispose() {
    super.dispose();
    print('MineWidget dispose');
  }
}
