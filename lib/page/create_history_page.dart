import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provide/provide.dart';

import '../bean/index.dart';
import '../http/request_method.dart';
import '../main.dart';
import '../store/user_store.dart';
import '../utils/refresh_widget_build.dart';
import '../widget/empty_widget.dart';
import '../widget/qr_history_item.dart';

const _LIMIT = 10;

class CreateHistoryPage extends StatefulWidget {
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
  var qrCodeBeanList = <QrCodeBean>[];

  var currentPage = 0;

  @override
  void initState() {
    super.initState();
    _requestData(false);
  }

  Future<void> _requestData(bool isAppend) async {
    // 延时一下
    await Future.delayed(const Duration(milliseconds: 500));
    final userStore = Provide.value<BaseUserStore>(context);
    final sceneId = userStore.selectedCommunity.id;
    try {
      final res = await RequestApi.queryQrCodeHistoryList(sceneId, currentPage * _LIMIT, _LIMIT);
      if (isAppend) {
        currentPage++;
        // 追加
        setState(() {
          qrCodeBeanList.addAll(res.results);
        });
      } else {
        currentPage = 0;
        // 清空重新赋值
        setState(() {
          qrCodeBeanList = res.results;
        });
      }
    } catch (error) {
      // 加载失败
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    final slivers = <Widget>[
      CupertinoSliverRefreshControl(
        // 重新加载数据
        onRefresh: () {
          // 重新从第 0 页开始加载
          return _requestData(false);
        },
        builder: buildRefreshWidget,
      ),
    ];

    if (qrCodeBeanList.isNotEmpty) {
      slivers.add(SliverList(
        delegate: SliverChildBuilderDelegate((context, index) => QrHistoryItem(qrCodeBeanList[index]), childCount: qrCodeBeanList.length),
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
