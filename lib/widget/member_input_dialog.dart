import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../bean/index.dart';
import '../store/user_store.dart';
import 'custom_alert_dialog.dart';
import 'logo.dart';

class MemberInputDialogWidget extends StatefulWidget {
  final Widget child;

  MemberInputDialogWidget({Key key, this.child}) : super(key: key);

  _MemberInputDialogWidgetState createState() => _MemberInputDialogWidgetState();
}

class _MemberInputDialogWidgetState extends State<MemberInputDialogWidget> {
  String _dropDownValue1 = '长期有效';
  HouseMember _dropDownValue2;

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
                child: Container(
                  height: 40,
                  child: Row(
                    children: <Widget>[
                      Image.asset('assets/icon_validate_time.png', width: 20),
                      Padding(
                        padding: EdgeInsets.only(left: 16),
                      ),
                      ScopedModelDescendant(builder: (context, child, BaseUserStore userStore) {
                        return DropdownButton<String>(
                          value: _dropDownValue1,
                          elevation: 0,
                          isDense: true,
                          hint: SizedBox(
                            width: 190,
                            child: Text('选择有效期长短', style: TextStyle(color: Color(0xFF303030)), overflow: TextOverflow.ellipsis),
                          ),
                          onChanged: (String newValue) {
                            setState(() {
                              _dropDownValue1 = newValue;
                            });
                          },
                          items: ['长期有效', '短期有效'].map<DropdownMenuItem<String>>((value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Container(
                                width: 190,
                                color: Colors.white,
                                height: double.infinity,
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    value,
                                    style: TextStyle(color: Color(0xFF303030)),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        );
                      }),
                    ],
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xFFD0D0D0)))),
                padding: EdgeInsets.only(left: 20),
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    height: 40,
                    child: Row(
                      children: <Widget>[
                        Image.asset('assets/icon_validate.png', width: 20),
                        Padding(
                          padding: EdgeInsets.only(left: 16),
                        ),
                        Text('请设置过期时间'),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xFFD0D0D0)))),
                padding: EdgeInsets.only(left: 20),
                child: Container(
                  height: 40,
                  child: Row(
                    children: <Widget>[
                      Image.asset('assets/icon_house.png', width: 20),
                      Padding(
                        padding: EdgeInsets.only(left: 16),
                      ),
                      ScopedModelDescendant(builder: (context, child, BaseUserStore userStore) {
                        return DropdownButton<HouseMember>(
                          value: _dropDownValue2,
                          elevation: 0,
                          isDense: true,
                          hint: SizedBox(
                            width: 190,
                            child: Text('请选择房屋', style: TextStyle(color: Color(0xFF303030)), overflow: TextOverflow.ellipsis),
                          ),
                          onChanged: (HouseMember newValue) {
                            setState(() {
                              _dropDownValue2 = newValue;
                            });
                          },
                          items: userStore.selectedCommunity.house_member.map<DropdownMenuItem<HouseMember>>((value) {
                            return DropdownMenuItem<HouseMember>(
                              value: value,
                              child: Container(
                                width: 190,
                                color: Colors.white,
                                height: double.infinity,
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    value.fullName,
                                    style: TextStyle(color: Color(0xFF303030)),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        );
                      }),
                    ],
                  ),
                ),
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
