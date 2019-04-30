import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:scan_access/store/user_store.dart';

import '../utils/prefs_util.dart';
import 'home/disable_card_widget.dart';
import 'home/enable_card_widget.dart';
import 'home/mine_widget.dart';
import 'login_page.dart';

const _MINE_INDEX = 1;

class HomePage extends StatefulWidget {
  @override
  State createState() => HomeState();
}

class HomeState extends State<HomePage> {
  /// 记录当前页
  int mCurrentIndex = 0;

  void clickTabItem(int index) {
    if (index == _MINE_INDEX) {
      final userStore = Provide.value<BaseUserStore>(context);
      // 点击  我的
      if (userStore.isLogin) {
        // 已登录 选择到我的
        setState(() {
          mCurrentIndex = _MINE_INDEX;
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
    // 修改内存中的UserBean
    final userStore = Provide.value<BaseUserStore>(context);
    userStore.isLogin = userBean != null;
    userStore.userBean = userBean;
  }

  @override
  Widget build(BuildContext context) {
    return Provide<BaseUserStore>(
      builder: (context, child, userStore) {
        // child  这个 child就是上面创建的child
        if (!userStore.isLogin) {
          // 退出登录(主动选择到首页)
          mCurrentIndex = 0;
        }
        return Column(
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
        );
      },
    );
  }
}
