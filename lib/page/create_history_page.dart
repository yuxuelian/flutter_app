import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scan_access/main.dart';
import 'package:scan_access/widget/qr_history_item.dart';

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
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(
                CupertinoIcons.down_arrow,
                color: CupertinoColors.inactiveGray,
                size: 28.0,
              ),
              Padding(padding: EdgeInsets.only(left: 10)),
              Text(
                '下拉刷新...',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF606060),
                ),
              )
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
                child: Container(),
              ),
              CupertinoActivityIndicator(radius: 14.0),
              Padding(padding: EdgeInsets.only(left: 10)),
              Text(
                '正在刷新...',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF606060),
                ),
              ),
              Expanded(
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
                child: Container(),
              ),
              CupertinoActivityIndicator(radius: 14.0),
              Padding(padding: EdgeInsets.only(left: 10)),
              Text(
                '刷新结束...',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF606060),
                ),
              ),
              Expanded(
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
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('生成历史', style: TextStyle(fontSize: 16, color: Colors.white)),
        centerTitle: true,
        elevation: 0,
      ),
      body: CustomScrollView(
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
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return QrHistoryItem();
              },
              childCount: 30,
            ),
          ),
        ],
      ),
    );
  }
}
