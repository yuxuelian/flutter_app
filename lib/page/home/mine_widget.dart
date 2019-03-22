import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scan_access/store/user_store.dart';
import 'package:scan_access/widget/community_item.dart';
import 'package:scan_access/widget/state_button.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../bean/index.dart';
import '../../http/request_method.dart';
import '../../prefs/prefs_util.dart';
import '../../store/user_store.dart';
import '../settings_page.dart';

// 已登录显示的页面
class MineWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MineState();
}

class MineState extends State<MineWidget> {
  File _avatarFile;

  Future<File> _onImageButtonPressed(ImageSource source) {
    return ImagePicker.pickImage(source: source);
  }

  Future<File> _showSheetDialog(BuildContext context) async {
    final value = await showModalBottomSheet<int>(
      context: context,
      builder: (context) {
        return Container(
          color: Colors.transparent,
          padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              FlatButton(
                color: Colors.white,
                splashColor: Colors.transparent,
                highlightColor: Color(0xFFD0D0D0),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                padding: EdgeInsets.all(0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(7),
                  topRight: Radius.circular(7),
                )),
                onPressed: () {
                  Navigator.of(context).pop(0);
                },
                child: Container(
                  height: 40,
                  width: double.infinity,
                  child: Center(
                    child: Text('拍照', style: TextStyle(fontSize: 16, color: Color(0xFFEB891A))),
                  ),
                ),
              ),
              Container(height: 1, color: Color(0xFF909090)),
              FlatButton(
                color: Colors.white,
                splashColor: Colors.transparent,
                highlightColor: Color(0xFFD0D0D0),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                padding: EdgeInsets.all(0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(7),
                  bottomRight: Radius.circular(7),
                )),
                onPressed: () {
                  Navigator.of(context).pop(1);
                },
                child: Container(
                  height: 40,
                  width: double.infinity,
                  child: Center(
                    child: Text('相册', style: TextStyle(fontSize: 16, color: Color(0xFFEB891A))),
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 10)),
              FlatButton(
                color: Colors.white,
                splashColor: Colors.transparent,
                highlightColor: Color(0xFFD0D0D0),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                padding: EdgeInsets.all(0),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(7))),
                onPressed: () {
                  Navigator.of(context).pop(-1);
                },
                child: Container(
                  height: 40,
                  width: double.infinity,
                  child: Center(
                    child: Text('取消', style: TextStyle(fontSize: 16, color: Color(0xFF909090))),
                  ),
                ),
              ),
            ],
          ),
        );
      },
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

  /// 获取刷新布局
  Widget _buildRefreshWidget(
    BuildContext context,
    RefreshIndicatorMode refreshState,
    double pulledExtent,
    double refreshTriggerPullDistance,
    double refreshIndicatorExtent,
  ) {
    const Curve opacityCurve = Interval(0.4, 0.8, curve: Curves.easeInOut);
    Widget res;
    switch (refreshState) {
      case RefreshIndicatorMode.inactive:
      case RefreshIndicatorMode.drag:
        res = Opacity(
          opacity: opacityCurve.transform(min(pulledExtent / refreshTriggerPullDistance, 1.0)),
          child: Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(
                  CupertinoIcons.down_arrow,
                  color: CupertinoColors.inactiveGray,
                  size: 28.0,
                ),
                Padding(padding: EdgeInsets.only(left: 10)),
                Text('下拉刷新...', style: TextStyle(fontSize: 16, color: Color(0xFF606060))),
              ],
            ),
          ),
        );
        break;
      case RefreshIndicatorMode.armed:
      case RefreshIndicatorMode.refresh:
        res = Opacity(
          opacity: opacityCurve.transform(min(pulledExtent / refreshIndicatorExtent, 1.0)),
          child: Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                CupertinoActivityIndicator(radius: 14.0),
                Padding(padding: EdgeInsets.only(left: 10)),
                Text('正在刷新...', style: TextStyle(fontSize: 16, color: Color(0xFF606060))),
              ],
            ),
          ),
        );
        break;
      case RefreshIndicatorMode.done:
        res = Opacity(
          opacity: opacityCurve.transform(min(pulledExtent / refreshIndicatorExtent, 1.0)),
          child: Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                CupertinoActivityIndicator(radius: 14.0),
                Padding(padding: EdgeInsets.only(left: 10)),
                Text('刷新结束...', style: TextStyle(fontSize: 16, color: Color(0xFF606060))),
              ],
            ),
          ),
        );
        break;
      default:
        break;
    }
    return res;
  }

  @override
  void initState() {
    super.initState();
    _requestData();
  }

  Future<void> _requestData() async {
    BaseUserStore userStore = ScopedModel.of(context);
    print(userStore.toString());
    if (userStore.isLogin) {
      try {
        // 延时一下
        await Future.delayed(const Duration(seconds: 1));
        // 开始刷新token
        LoginResultBean loginResult = await RequestApi.refreshToken();
        print(loginResult);
        // 获取用户小区信息
        List<Community> communityList = await RequestApi.queryUserHouse();
        print(communityList);

        // 存储
        await PrefsUtil.saveToken(loginResult.token);
        await PrefsUtil.saveUserBean(loginResult.user);

        // 更新model
        BaseUserStore userStore = ScopedModel.of(context);
        // 更新一下user
        userStore.userBean = loginResult.user;
        // 存储 communityList
        userStore.communityList = communityList;
        print(communityList);
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
      BaseUserStore userStore = ScopedModel.of(context);
      // 确实点击了退出登录按钮
      userStore.isLogin = false;
      userStore.userBean = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Image.asset('images/mine_top_bg.png', width: 360),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: AppBar(
                title: Text('标题', style: TextStyle(fontSize: 16, color: Colors.white)),
                backgroundColor: Colors.transparent,
                centerTitle: true,
                elevation: 0,
                actions: <Widget>[
                  StateButtonWidget(
                    child: Container(
                      padding: EdgeInsets.all(12),
                      child: Image.asset('images/setting.png'),
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
                    setState(() {
                      // 显示图片到界面
                      _avatarFile = imgFile;
                    });
                  }
                },
                // 显示圆形图片
                child: SizedBox(
                  width: 70,
                  height: 70,
                  child: ClipOval(
                    child: _avatarFile == null ? Image.asset('images/header_icon_placeholder.png') : Image.file(_avatarFile),
                  ),
                ),
              ),
            ),
          ],
        ),
        Expanded(
          child: Container(
            color: Color(0xFFF0F0F0),
            child: ScopedModelDescendant(
              builder: (context, child, BaseUserStore userStore) => CustomScrollView(
                    slivers: <Widget>[
                      CupertinoSliverRefreshControl(
                        onRefresh: _requestData,
                        builder: _buildRefreshWidget,
                      ),
                      SliverSafeArea(
                        top: false, // Top safe area is consumed by the navigation bar.
                        sliver: SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              return CommunityItemWidget(userStore.communityList[index]);
                            },
                            childCount: userStore.communityList?.length ?? 0,
                          ),
                        ),
                      ),
                    ],
                  ),
            ),
          ),
        ),
      ],
    );
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
