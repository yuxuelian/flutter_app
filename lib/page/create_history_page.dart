import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import '../utils/refresh_widget_build.dart';
import '../widget/empty_widget.dart';
import '../widget/qr_history_item.dart';

class CreateHistoryPage extends StatefulWidget {
  /// 跳转到设置页面
  static Future<T> start<T extends Object>(BuildContext context) {
    return Navigator.of(context, rootNavigator: true).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => CreateHistoryPage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) => MyApp.createTransition(animation, child),
        transitionDuration: Duration(milliseconds: 400),
      ),
    );
  }

  @override
  State<StatefulWidget> createState() => CreateHistoryState();
}

class CreateHistoryState extends State<CreateHistoryPage> {
  List<String> historyList = [];

  @override
  Widget build(BuildContext context) {
    final slivers = <Widget>[
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
        builder: buildRefreshWidget,
      ),
    ];

    if (historyList.isNotEmpty) {
      slivers.add(SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return QrHistoryItem();
          },
          childCount: historyList.length,
        ),
      ));
    } else {
      slivers.add(SliverToBoxAdapter(
        child: EmptyWidget(),
      ));
    }
    return Scaffold(
      backgroundColor: Color(0xFFF0F0F0),
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('生成历史', style: TextStyle(fontSize: 16, color: Colors.white)),
        centerTitle: true,
        elevation: 0,
      ),
      body: CustomScrollView(
        slivers: slivers,
      ),
    );
  }
}
