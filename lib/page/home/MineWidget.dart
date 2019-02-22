import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/store/UserStore.dart';
import 'package:flutter_app/widget/CommunityItemWidget.dart';
import 'package:flutter_app/widget/StateButtonWidget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scoped_model/scoped_model.dart';

import '../SettingsPage.dart';

// 已登录显示的页面
class MemberWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MemberState();
  }
}

class MemberState extends State<MemberWidget> {
  Future<File> _imageFile;

  void _onImageButtonPressed(ImageSource source) {
    setState(() {
      _imageFile = ImagePicker.pickImage(source: source);
    });
  }

  List<Widget> _createSheetDialogWidget(List<String> contents) {
    List<Widget> itemWidgets = [];
    for (int i = 0; i < contents.length; i++) {
      itemWidgets.add(CupertinoActionSheetAction(
        child: Text(contents[i]),
        onPressed: () {
          Navigator.of(context, rootNavigator: true).pop(i);
        },
      ));
    }
    return itemWidgets;
  }

  void _showSheetDialog({@required BuildContext context, @required Widget child}) {
    showCupertinoModalPopup<int>(
      context: context,
      builder: (BuildContext context) => child,
    ).then((int value) {
      if (value != null) {
        switch (value) {
          case 0:
            // 拍照
            _onImageButtonPressed(ImageSource.camera);
            break;
          case 1:
            // 相册
            _onImageButtonPressed(ImageSource.gallery);
            break;
          default:
            break;
        }
      }
    });
  }

  /// 预览选择的图片
  Widget _previewImage() {
    return FutureBuilder<File>(
        future: _imageFile,
        builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
          if (snapshot.connectionState == ConnectionState.done && snapshot.data != null) {
            return Image.file(snapshot.data);
          } else if (snapshot.error != null) {
            return const Text(
              'Error picking image.',
              textAlign: TextAlign.center,
            );
          } else {
            return const Text(
              'You have not yet picked an image.',
              textAlign: TextAlign.center,
            );
          }
        });
  }

  /// 获取刷新布局
  Widget buildRefreshWidget(
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
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Container(),
              ),
              Icon(
                CupertinoIcons.down_arrow,
                color: CupertinoColors.inactiveGray,
                size: 28.0,
              ),
              Padding(padding: EdgeInsets.only(left: 10)),
              Text(
                "下拉刷新...",
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF606060),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(),
              ),
            ],
          ),
        );
        break;
      case RefreshIndicatorMode.armed:
      case RefreshIndicatorMode.refresh:
        res = Opacity(
          opacity: opacityCurve.transform(min(pulledExtent / refreshIndicatorExtent, 1.0)),
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Container(),
              ),
              CupertinoActivityIndicator(radius: 14.0),
              Padding(padding: EdgeInsets.only(left: 10)),
              Text(
                "正在刷新...",
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF606060),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(),
              ),
            ],
          ),
        );
        break;
      case RefreshIndicatorMode.done:
        res = Opacity(
          opacity: opacityCurve.transform(min(pulledExtent / refreshIndicatorExtent, 1.0)),
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Container(),
              ),
              CupertinoActivityIndicator(radius: 14.0),
              Padding(padding: EdgeInsets.only(left: 10)),
              Text(
                "刷新结束...",
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF606060),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(),
              ),
            ],
          ),
        );
        break;
      default:
        break;
    }
    return res;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Image.asset("images/mine_top_bg.png"),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: AppBar(
                title: Text(
                  "标题",
                  style: TextStyle(fontSize: 16),
                ),
                backgroundColor: Colors.transparent,
                centerTitle: true,
                elevation: 0,
                actions: <Widget>[
                  ScopedModelDescendant<BaseUserStore>(
                    builder: (context, child, model) => StateButtonWidget(
                          child: Container(
                            padding: EdgeInsets.all(12),
                            child: Image.asset("images/setting.png"),
                          ),
                          onTap: () {
                            SettingsPage.toSettings(context, model).then((resultValue) {
                              print(resultValue);
                              if (resultValue != null && resultValue) {
                                // TODO  清除用户状态数据等操作
                                /// 确实点击了退出登录按钮
                                model.setLogin(false);
                              }
                            });
                          },
                          stateEnabled: BoxDecoration(color: Colors.transparent),
                          statePressed: BoxDecoration(color: Color(0x33909090)),
                        ),
                  )
                ],
              ),
            ),
            Positioned(
              bottom: 35,
              child: GestureDetector(
                onTap: () {
                  _showSheetDialog(
                    context: context,
                    child: CupertinoActionSheet(
                      actions: _createSheetDialogWidget(["拍照", "相册"]),
                      cancelButton: CupertinoActionSheetAction(
                        child: const Text('取消'),
                        onPressed: () {
                          Navigator.of(context, rootNavigator: true).pop(-1);
                        },
                      ),
                    ),
                  );
                },
                // 显示圆形图片
                child: Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("images/header_icon_placeholder.png"),
                      fit: BoxFit.cover,
                    ),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
          ],
        ),
        Expanded(
          flex: 1,
          child: CustomScrollView(
            slivers: <Widget>[
              CupertinoSliverRefreshControl(
                onRefresh: () {
                  print("开始下拉刷新");
                  return Future<void>.delayed(const Duration(seconds: 2)).then<void>((_) {
                    if (mounted) {
                      setState(() {
                        print("下拉刷新完成");
                      });
                    }
                  });
                },
                builder: buildRefreshWidget,
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return CommunityItemWidget();
                  },
                  childCount: 30,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
