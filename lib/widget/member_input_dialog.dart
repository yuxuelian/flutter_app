import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provide/provide.dart';

import '../bean/index.dart';
import '../store/user_store.dart';
import '../widget/date_picker.dart';
import '../widget/single_picker.dart';
import 'custom_alert_dialog.dart';
import 'logo.dart';

const _validateTypeList = ['常住人员', '临时人员'];

class MemberInputDialogWidget extends StatefulWidget {
  final Widget child;

  MemberInputDialogWidget({Key key, this.child}) : super(key: key);

  _MemberInputDialogWidgetState createState() => _MemberInputDialogWidgetState();
}

class _MemberInputDialogWidgetState extends State<MemberInputDialogWidget> {
  int _selectValidateTypeIndex;
  HouseMember _selectHouseMember;
  DateTime _selectDateTime;

  Widget _buildLine1(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xFFD0D0D0)), top: BorderSide(color: Color(0xFFD0D0D0)))),
      padding: EdgeInsets.only(left: 20),
      height: 40,
      child: Row(
        children: <Widget>[
          Image.asset('assets/icon_user.png', width: 20),
          Padding(
            padding: EdgeInsets.only(left: 16),
          ),
          Expanded(
            child: CupertinoTextField(
              maxLines: 1,
              autofocus: false,
              padding: EdgeInsets.all(0),
              placeholder: '请输入手机号(必填)',
              keyboardType: TextInputType.text,
              style: TextStyle(fontSize: 14, color: Color(0xFF303030)),
              decoration: BoxDecoration(border: Border()),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLine2(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xFFD0D0D0)))),
      padding: EdgeInsets.only(left: 20),
      height: 40,
      child: Provide<BaseUserStore>(builder: (context, child, userStore) {
        return GestureDetector(
          onTap: () async {
            final resIndex = await SinglePicker.showSinglePicker(context, _validateTypeList, (index) {});
            if (resIndex != null) {
              setState(() {
                _selectValidateTypeIndex = resIndex;
              });
            }
          },
          child: Row(
            children: <Widget>[
              Image.asset('assets/icon_validate_time.png', width: 20),
              Padding(
                padding: EdgeInsets.only(left: 16),
              ),
              Text(_selectValidateTypeIndex == null ? '请选择过期类型' : _validateTypeList[_selectValidateTypeIndex], style: TextStyle(color: Color(0xFF303030))),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildLine3(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xFFD0D0D0)))),
      padding: EdgeInsets.only(left: 20),
      height: 40,
      child: GestureDetector(
        onTap: () async {
          // 显示日期选择对话框
          final resDateTime = await DatePicker.showDatePicker(
            context,
            DateTime.now(),
            DateTime.now(),
            DateTime.utc(2030, 10, 1),
            (selectDateTime) {},
          );
          if (resDateTime != null) {
            setState(() {
              _selectDateTime = resDateTime;
            });
          }
        },
        child: Row(
          children: <Widget>[
            Image.asset('assets/icon_validate.png', width: 20),
            Padding(
              padding: EdgeInsets.only(left: 16),
            ),
            Text(_selectDateTime == null ? '请设置过期时间' : _selectDateTime.toString().split('.')[0]),
          ],
        ),
      ),
    );
  }

  Widget _buildLine4(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xFFD0D0D0)))),
      padding: EdgeInsets.only(left: 20),
      height: 40,
      child: Provide<BaseUserStore>(builder: (context, child, userStore) {
        return GestureDetector(
          onTap: () async {
            final houseMemberList = userStore.selectedCommunity.house_member;
            final showStringList = houseMemberList.map<String>((value) => value.fullHouseName).toList();
            final resIndex = await SinglePicker.showSinglePicker(context, showStringList, (index) {});
            if (resIndex != null) {
              setState(() {
                _selectHouseMember = houseMemberList[resIndex];
              });
            }
          },
          child: Row(
            children: <Widget>[
              Image.asset('assets/icon_house.png', width: 20),
              Padding(
                padding: EdgeInsets.only(left: 16),
              ),
              Text(_selectHouseMember == null ? '请选择房屋' : _selectHouseMember.fullHouseName, style: TextStyle(color: Color(0xFF303030))),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildBtn(BuildContext context) {
    return Container(
      height: 40,
      child: Row(
        children: <Widget>[
          Expanded(
            child: ConstrainedBox(
              constraints: BoxConstraints.expand(),
              child: FlatButton(
                color: Colors.transparent,
                splashColor: Colors.transparent,
                highlightColor: Color(0xFFD0D0D0),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15))),
                child: Text('取消', style: TextStyle(fontSize: 14, color: Color(0xFF606060))),
                onPressed: () {
                  // 点击生成历史
                  Navigator.of(context, rootNavigator: true).pop(false);
                },
              ),
            ),
          ),
          Container(
            width: 1,
            color: Color(0xFFD0D0D0),
            child: Column(),
          ),
          Expanded(
            child: ConstrainedBox(
              constraints: BoxConstraints.expand(),
              child: FlatButton(
                color: Colors.transparent,
                splashColor: Colors.transparent,
                highlightColor: Color(0xFFD0D0D0),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomRight: Radius.circular(15))),
                child: Text('确定', style: TextStyle(fontSize: 14, color: Color(0xFFEB891A))),
                onPressed: () {},
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomDialogWidget(
      content: Container(
        width: 260,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              LogoWidget(),
              _buildLine1(context),
              _buildLine2(context),
              _buildLine3(context),
              _buildLine4(context),
              _buildBtn(context),
            ],
          ),
        ),
      ),
    );
  }
}
