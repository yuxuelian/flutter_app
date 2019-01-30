import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/page/SettingsPage.dart';
import 'package:flutter_app/store/UserStore.dart';
import 'package:scoped_model/scoped_model.dart';

// 已登录显示的页面
class LoginedWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoggedState();
  }
}

class LoggedState extends State<LoginedWidget> {
  /// 跳转到设置页面
  void _toSettings(BaseUserStore model) {
    Navigator.of(context, rootNavigator: true)
        .push(MaterialPageRoute(builder: (context) {
      return SettingsPage();
    })).then((resultValue) {
      print(resultValue);
      if (resultValue != null && resultValue) {
        // TODO  清除用户状态数据等操作

        /// 确实点击了退出登录按钮
        model.setLogin(false);
      }
    });
  }

  void _showSheetDialog(
      {@required BuildContext context, @required Widget child}) {
    showCupertinoModalPopup<int>(
      context: context,
      builder: (BuildContext context) => child,
    ).then((int value) {
      if (value != null) {
        print(value);
      }
    });
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
              ),
            ),
            Positioned(
              bottom: 35,
              child: GestureDetector(
                onTap: () {
                  _showSheetDialog(
                    context: context,
                    child: CupertinoActionSheet(
                        actions: <Widget>[
                          CupertinoActionSheetAction(
                            child: const Text('拍照'),
                            onPressed: () {
                              Navigator.of(context, rootNavigator: true).pop(1);
                            },
                          ),
                          CupertinoActionSheetAction(
                            child: const Text('相册'),
                            onPressed: () {
                              Navigator.of(context, rootNavigator: true).pop(2);
                            },
                          ),
                        ],
                        cancelButton: CupertinoActionSheetAction(
                          child: const Text('取消'),
                          onPressed: () {
                            Navigator.of(context, rootNavigator: true).pop(0);
                          },
                        )),
                  );
                },
                child: Image.asset(
                  "images/header_icon_placeholder.png",
                  width: 70,
                ),
              ),
            ),
            Positioned(
                right: 20,
                top: 35,
                child: ScopedModelDescendant<BaseUserStore>(
                  builder: (context, child, model) => GestureDetector(
                        onTap: () {
                          _toSettings(model);
                        },
                        child: Image.asset(
                          "images/setting.png",
                          width: 30,
                        ),
                      ),
                )),
          ],
        ),
        Expanded(
          flex: 1,
          child: CustomScrollView(
            slivers: <Widget>[
              CupertinoSliverRefreshControl(
                onRefresh: () {
                  print("开始下拉刷新");
                  return Future<void>.delayed(const Duration(seconds: 2))
                    ..then<void>((_) {
                      if (mounted) {
                        setState(() => print("下拉刷新完成"));
                      }
                    });
                },
              ),
              SliverSafeArea(
                top: false,
                // Top safe area is consumed by the navigation bar.
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return Text("测试  $index");
                    },
                    childCount: 50,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
