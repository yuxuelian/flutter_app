import 'package:flutter/material.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';
import 'package:scoped_model/scoped_model.dart';

import '../bean/index.dart';
import '../page/visitor_qr_code_page.dart';
import '../store/user_store.dart';
import 'custom_alert_dialog.dart';
import 'logo.dart';

class CreateQrDialogWidget extends StatefulWidget {
  @override
  State createState() => _CreateQrDialogState();
}

class _CreateQrDialogState extends State<CreateQrDialogWidget> {
  HouseMember _dropDownValue;

  @override
  Widget build(BuildContext context) {
    return CustomDialogWidget(
      content: Container(
        width: 260,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            LogoWidget(),
            Container(
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
                    child: TextField(
                      keyboardType: TextInputType.text,
                      maxLength: 6,
                      autofocus: false,
                      cursorWidth: 1,
                      decoration: InputDecoration(
                        // 主要目的是隐藏Counter
                        counter: Container(),
                        hintText: '请输入姓名(非必填)',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(top: 10),
                      ),
                      style: TextStyle(fontSize: 16),
                      scrollPadding: EdgeInsets.all(0),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xFFD0D0D0)))),
              padding: EdgeInsets.only(left: 20),
              height: 40,
              child: Row(
                children: <Widget>[
                  Image.asset('assets/icon_phone.png', width: 20),
                  Padding(
                    padding: EdgeInsets.only(left: 16),
                  ),
                  Text('请设置过期时间'),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xFFD0D0D0)))),
              padding: EdgeInsets.only(left: 20),
              height: 40,
              child: GestureDetector(
                onTap: () {
                  // 显示日期选择对话框
                  DatePicker.showDatePicker(context, onConfirm: (year, month, date) {
                    print(year);
                    print(month);
                    print(date);
                  });
                },
                child: Row(
                  children: <Widget>[
                    Image.asset('assets/icon_validate_time.png', width: 20),
                    Padding(
                      padding: EdgeInsets.only(left: 16),
                    ),
                    Text('请设置过期时间'),
                  ],
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xFFD0D0D0)))),
              padding: EdgeInsets.only(left: 20),
              height: 40,
              child: Row(
                children: <Widget>[
                  Image.asset('assets/icon_house.png', width: 20),
                  Padding(
                    padding: EdgeInsets.only(left: 16),
                  ),
                  ScopedModelDescendant(builder: (context, child, BaseUserStore userStore) {
                    return DropdownButton<HouseMember>(
                      value: _dropDownValue,
                      elevation: 0,
                      isDense: true,
                      hint: SizedBox(
                        width: 190,
                        child: Text('请选择房屋', style: TextStyle(color: Color(0xFF303030)), overflow: TextOverflow.ellipsis),
                      ),
                      onChanged: (HouseMember newValue) {
                        setState(() {
                          _dropDownValue = newValue;
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
                        child: Text('生成历史', style: TextStyle(fontSize: 14, color: Color(0xFF606060))),
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
                        child: Text('立即生成', style: TextStyle(fontSize: 14, color: Color(0xFFEB891A))),
                        onPressed: () {
                          // TODO 联网创建访客二维码

                          // TODO 关闭当前页面
                          Navigator.of(context).pop();
                          // TODO 跳转到访客二维码显示二面
                          VisitorQrCodePage.start(context);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
