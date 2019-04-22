import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scan_access/store/user_store.dart';
import 'package:scoped_model/scoped_model.dart';

import 'login_page.dart';
import 'home/disable_card_widget.dart';
import 'home/enable_card_widget.dart';
import 'home/mine_widget.dart';
import '../prefs/prefs_util.dart';

class HomePage extends StatefulWidget {
  @override
  State createState() => HomeState();
}

class HomeState extends State<HomePage> {
  /// 记录当前页
  int mCurrentIndex = 0;

  static const MINE_INDEX = 1;

  void clickTabItem(int index) {
    BaseUserStore baseUserStore = ScopedModel.of(context);
    final isLogin = baseUserStore.isLogin;
    if (index == MINE_INDEX) {
      // 点击  我的
      if (isLogin) {
        // 已登录 选择到我的
        setState(() {
          mCurrentIndex = MINE_INDEX;
        });
      } else {
        // 未登录(跳转到登录页面)
        LoginPage.start(context);
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
    _initUserStore();
  }

  Future<void> _initUserStore() async {
    // 获取本地存储的用户信息
    final userBean = await PrefsUtil.getUserBean();
    final loginState = userBean != null;
    // 修改内存中的UserBean
    BaseUserStore userStore = ScopedModel.of(context);
    userStore.userBean = userBean;
    userStore.isLogin = loginState;
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<BaseUserStore>(builder: (context, child, userStore) {
      if (!userStore.isLogin) {
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
                child: IndexedStack(
                  children: <Widget>[
                    userStore.isLogin ? EnableCardWidget() : DisableCardWidget(),
                    userStore.isLogin ? MineWidget() : Container(),
                  ],
                  index: mCurrentIndex,
                ),
              ),
              CupertinoTabBar(
                currentIndex: mCurrentIndex,
                backgroundColor: Color(0xFF202020),
                activeColor: Color(0xFFEB891A),
                inactiveColor: Colors.white,
                border: Border(top: BorderSide(color: Color(0xFF303030), width: 2)),
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: ImageIcon(AssetImage('assets/navigation_home_normal.png')),
                    title: Text('首页', style: TextStyle(fontSize: 13)),
                  ),
                  BottomNavigationBarItem(
                    icon: ImageIcon(AssetImage('assets/navigation_mine_normal.png')),
                    title: Text('我的', style: TextStyle(fontSize: 13)),
                  ),
                ],
                onTap: clickTabItem,
              ),
            ],
          ),
        ),
      );
    });
  }
}
