import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter_app/page/home/main/MainPage.dart';
import 'package:flutter_app/page/home/mine/MinePage.dart';

class HomePage extends StatefulWidget {
  @override
  State createState() => HomeState();
}

class HomeState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    print("build");
    return WillPopScope(
      onWillPop: () => Future<bool>.value(true),
      child: DefaultTextStyle(
        style: CupertinoTheme.of(context).textTheme.textStyle,
        child: CupertinoTabScaffold(
          tabBar: CupertinoTabBar(
            backgroundColor: Color(0xFF222222),
            activeColor: Color(0xFFEB891A),
            inactiveColor: Colors.white,
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
          ),
          tabBuilder: (BuildContext context, int index) {
            assert(index >= 0 && index <= 1);
            switch (index) {
              case 0:
                return CupertinoTabView(
                    builder: (BuildContext context) => MainPage());
              case 1:
                return CupertinoTabView(
                    builder: (BuildContext context) => MinePage());
            }
            return null;
          },
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    print("initState");
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
