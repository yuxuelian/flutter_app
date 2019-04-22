import 'dart:math';
import 'package:flutter/cupertino.dart';

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