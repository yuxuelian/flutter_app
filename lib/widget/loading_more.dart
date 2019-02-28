import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadMoreState {
  const LoadMoreState._(this.stateText);

  final String stateText;

  static const LoadMoreState loading = LoadMoreState._('正在加载...');
  static const LoadMoreState loadEnd = LoadMoreState._('没有更多数据');
  static const LoadMoreState loadError = LoadMoreState._('加载失败,点击重试');
}

class LoadingMoreWidget extends StatelessWidget {
  final LoadMoreState loadState;

  LoadingMoreWidget(this.loadState);

  @override
  Widget build(BuildContext context) {
    Widget show;
    switch (loadState) {
      case LoadMoreState.loading:
        show = Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            CupertinoActivityIndicator(radius: 14.0),
            Padding(padding: EdgeInsets.only(left: 10)),
            Text(loadState.stateText, style: TextStyle(fontSize: 16, color: Color(0xFF606060))),
          ],
        );
        break;
      case LoadMoreState.loadEnd:
        // 没有更多数据
        show = Text(loadState.stateText, style: TextStyle(fontSize: 16, color: Color(0xFF606060)));
        break;
      case LoadMoreState.loadError:
        show = Text(loadState.stateText, style: TextStyle(fontSize: 16, color: Color(0xFF606060)));
        break;
    }

    return Container(
      height: 60,
      decoration: BoxDecoration(color: Colors.transparent, border: Border(top: BorderSide(color: Color(0xFFD0D0D0)))),
      child: Center(child: show),
    );
  }
}
