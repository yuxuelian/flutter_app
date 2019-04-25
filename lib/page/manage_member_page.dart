import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../bean/index.dart';
import '../http/request_method.dart';
import '../main.dart';
import '../utils/refresh_widget_build.dart';
import '../widget/empty_widget.dart';
import '../widget/member_input_dialog.dart';
import '../widget/member_item.dart';
import '../widget/state_button.dart';

class ManageMemberPage extends StatefulWidget {
  static Future<T> start<T extends Object>(BuildContext context, int type, String typeName, List<HouseMember> validHouseMember) {
    return Navigator.of(context, rootNavigator: true).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => ManageMemberPage(type, typeName, validHouseMember),
        transitionsBuilder: (context, animation, secondaryAnimation, child) => MyApp.createTransition(animation, child),
        transitionDuration: Duration(milliseconds: 400),
      ),
    );
  }

  final int type;
  final String typeName;

  final List<HouseMember> validHouseMember;

  ManageMemberPage(this.type, this.typeName, this.validHouseMember);

  @override
  State<StatefulWidget> createState() => ManageMemberState();
}

class ManageMemberState extends State<ManageMemberPage> {
  var memberList = <MemberBean>[];

  // 用于标记是否正在加载  isLoading  = true  表示正在加载中  false 表示已经停止加载
//  var isLoading = true;

  /// 显示二维码生成对话框
  void _showMemberInputDialog(BuildContext context) {
    showDialog<bool>(context: context, builder: (BuildContext context) => MemberInputDialogWidget()).then((resValue) {});
  }

  @override
  void initState() {
    super.initState();
    _requestData();
  }

  Future<void> _requestData() async {
    var map = widget.validHouseMember.map((houseMember) {
      return RequestApi.queryMemberList(houseMember.id, widget.type);
    });
    try {
      final res = await Future.wait(map);
      final temp = <MemberBean>[];
      res.forEach((itemMemberList) {
        temp.addAll(itemMemberList);
      });
      setState(() {
        memberList = temp;
      });
    } catch (error) {
      // 加载失败
    }
  }

  @override
  Widget build(BuildContext context) {
    final slivers = <Widget>[
      CupertinoSliverRefreshControl(
        // 触发下拉加载,重新请求一次数据
        onRefresh: _requestData,
        builder: buildRefreshWidget,
      ),
    ];
    if (memberList.isNotEmpty) {
      slivers.add(SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final memberBean = memberList[index];
            return MemberItem(
              () {
                print('memberBean = $memberBean');
              },
              memberBean.user.nickname,
              memberBean.user.username,
              memberBean.type_name,
              memberBean.fullHouseName,
              memberBean.expire,
            );
          },
          childCount: memberList.length,
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
        title: Text(widget.typeName, style: TextStyle(fontSize: 16, color: Colors.white)),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: CustomScrollView(
              slivers: slivers,
            ),
          ),
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 20, top: 10),
            child: StateButtonWidget(
              child: Container(
                width: 340,
                height: 40,
                child: Center(
                  child: Text(
                    '注册新成员',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              onTap: () {
                _showMemberInputDialog(context);
              },
              stateEnabled: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(7)),
                gradient: LinearGradient(colors: <Color>[Color(0xFF05A8F1), Color(0xFF25EAA6)]),
              ),
              statePressed: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(7)),
                gradient: LinearGradient(colors: <Color>[Color(0xFF0558F1), Color(0xFF00D080)]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
