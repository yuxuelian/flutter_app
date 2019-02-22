import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/store/UserStore.dart';
import 'package:scoped_model/scoped_model.dart';

import 'LoginPage.dart';
import 'home/DisableCardWidget.dart';
import 'home/EnableCardWidget.dart';
import 'home/MineWidget.dart';

class HomePage extends StatefulWidget {
  @override
  State createState() => HomeState();
}

class HomeState extends State<HomePage> {
  /// 记录当前页
  int mCurrentIndex = 0;

  static const MINE_INDEX = 1;

  void clickTabItem(int index, bool isLogin) {
    if (index == MINE_INDEX) {
      // 点击  我的
      if (isLogin) {
        // 已登录 选择到我的
        setState(() {
          mCurrentIndex = MINE_INDEX;
        });
      } else {
        // 未登录(跳转到登录页面)
        LoginPage.toLoginPage(context).then((res) {
          print(res);
        });
      }
    } else {
      setState(() {
        mCurrentIndex = index;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    this.mCurrentIndex = 0;
  }

  Widget _getBodyWidget(int currentIndex, bool isLogin) {
    Widget res;
    switch (mCurrentIndex) {
      case 0:
        res = isLogin ? EnableCardWidget() : DisableCardWidget();
        break;
      case 1:
        res = MemberWidget();
        break;
      default:
        res = null;
        break;
    }
    return res;
  }

  @override
  Widget build(BuildContext context) {
    print("HomeState   build");
    return ScopedModelDescendant<BaseUserStore>(builder: (context, child, model) {
      if (!model.isLogin) {
        // 退出登录(主动选择到首页)
        mCurrentIndex = 0;
      }
      return Container(
        color: Colors.white,
        child: DefaultTextStyle(
          style: CupertinoTheme.of(context).textTheme.textStyle,
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: _getBodyWidget(mCurrentIndex, model.isLogin),
              ),
              CupertinoTabBar(
                currentIndex: mCurrentIndex,
                backgroundColor: Color(0xFF222222),
                activeColor: Color(0xFFEB891A),
                inactiveColor: Colors.white,
                border: Border(top: BorderSide(color: Colors.black, width: 2)),
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.home),
                    title: Text('首页'),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.profile_circled),
                    title: Text('我的'),
                  ),
                ],
                onTap: (index) {
                  clickTabItem(index, model.isLogin);
                },
              ),
            ],
          ),
        ),
      );
    });
  }

  @override
  void didUpdateWidget(HomePage oldWidget) {
    super.didUpdateWidget(oldWidget);
    print("didUpdateWidget");
  }

  @override
  void deactivate() {
    super.deactivate();
    print("deactivate");
  }

  @override
  void dispose() {
    super.dispose();
    print("dispose");
  }

  @override
  void reassemble() {
    super.reassemble();
    print("reassemble");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("didChangeDependencies");
  }
}
