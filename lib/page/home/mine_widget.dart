import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scan_access/store/user_store.dart';
import 'package:scan_access/widget/community_item.dart';
import 'package:scan_access/widget/loading_more.dart';
import 'package:scan_access/widget/state_button.dart';
import 'package:scoped_model/scoped_model.dart';

import '../settings_page.dart';

// 已登录显示的页面
class MineWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MineState();
}

class MineState extends State<MineWidget> {
  File _avatarFile;

  List<int> items = List.generate(5, (i) => i);

  LoadMoreState loadMoreState = LoadMoreState.loading;

  // 是否正在加载更多
  bool _isLoadingMore = false;
  ScrollController _scrollController;

  Future<File> _onImageButtonPressed(ImageSource source) {
    return ImagePicker.pickImage(source: source);
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

  Future<File> _showSheetDialog(BuildContext context) async {
    final value = await showCupertinoModalPopup<int>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
            actions: _createSheetDialogWidget(['拍照', '相册']),
            cancelButton: CupertinoActionSheetAction(
              child: const Text('取消'),
              onPressed: () {
                // 取消情况,返回 null
                Navigator.of(context, rootNavigator: true).pop(-1);
              },
            ),
          ),
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
    _scrollController = TrackingScrollController(keepScrollOffset: false);
    _scrollController.addListener(() async {
      var position = _scrollController.position;
      print("position.pixels = ${position.pixels}");
      print("position.maxScrollExtent = ${position.maxScrollExtent}");
      if (position.pixels == position.maxScrollExtent) {
        print("滑动到底部");
        if (!_isLoadingMore) {
          // 执行加载更多
          _isLoadingMore = true;
          List<int> newEntries = await fakeRequest(items.length, items.length + 10);
          setState(() {
            items.addAll(newEntries);
          });
          // 下一个请求可以开始了
          _isLoadingMore = false;
        }
      }
    });
  }

  Future<List<int>> fakeRequest(int from, int to) async {
    return Future.delayed(Duration(seconds: 5), () {
      return List.generate(to - from, (i) => i + from);
    });
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
                  ScopedModelDescendant<BaseUserStore>(
                    builder: (context, child, model) => StateButtonWidget(
                          child: Container(
                            padding: EdgeInsets.all(12),
                            child: Image.asset('images/setting.png'),
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
                          statePressed: BoxDecoration(color: Color(0x33909090)),
                        ),
                  )
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
                child: Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: _avatarFile == null ? AssetImage('images/header_icon_placeholder.png') : FileImage(_avatarFile),
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
          child: CustomScrollView(
            controller: _scrollController,
            slivers: <Widget>[
              CupertinoSliverRefreshControl(
                onRefresh: () {
                  print('开始下拉刷新');
                  return Future<void>.delayed(const Duration(seconds: 2)).then<void>((_) {
                    if (mounted) {
                      setState(() {
                        print('下拉刷新完成');
                      });
                    }
                  });
                },
                builder: _buildRefreshWidget,
              ),
              SliverSafeArea(
                top: false, // Top safe area is consumed by the navigation bar.
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      if (index < items.length) {
                        // 前面的item项
                        return CommunityItemWidget(index);
                      } else {
                        // 最后一个 显示加载更多
                        return LoadingMoreWidget(loadMoreState);
                      }
                    },
                    addSemanticIndexes: true,
                    // 比 items 要多一项  主要是为了加上最后一个  加载 widget
                    childCount: items.length + 1,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  void didUpdateWidget(MineWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    print('MineWidget didUpdateWidget');
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

  @override
  void reassemble() {
    super.reassemble();
    print('MineWidget reassemble');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('MineWidget didChangeDependencies');
  }
}
