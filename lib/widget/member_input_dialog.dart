import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

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
              Container(
                decoration: BoxDecoration(border: Border(top: BorderSide(color: Color(0xFFD0D0D0)), bottom: BorderSide(color: Color(0xFFD0D0D0)))),
                padding: EdgeInsets.only(left: 20),
                child: TextFormField(
                  keyboardType: TextInputType.phone,
                  maxLength: 11,
                  autofocus: false,
                  decoration: InputDecoration(
                    // 主要目的是隐藏Counter
                    counter: Container(),
                    icon: Image.asset('assets/icon_phone.png', width: 20),
                    hintText: '请输入手机号(必填)',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(top: 12, bottom: 12),
                  ),
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Container(
                decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xFFD0D0D0)))),
                padding: EdgeInsets.only(left: 20),
                height: 40,
                child: ScopedModelDescendant(builder: (context, child, BaseUserStore userStore) {
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
              ),
              Container(
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
              ),
              Container(
                decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xFFD0D0D0)))),
                padding: EdgeInsets.only(left: 20),
                height: 40,
                child: ScopedModelDescendant(builder: (context, child, BaseUserStore userStore) {
                  return GestureDetector(
                    onTap: () async {
                      final houseMemberList = userStore.selectedCommunity.house_member;
                      final showStringList = houseMemberList.map<String>((value) => value.fullHouseName).toList();
                      final resIndex = await SinglePicker.showSinglePicker(context, showStringList, (index) {});
                      if (resIndex != -1) {
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
              ),
              Container(
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
