import 'package:flutter/material.dart';
import 'package:scan_access/widget/logo.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';

import 'custom_alert_dialog.dart';
import 'state_button.dart';

class CreateQrDialogWidget extends StatelessWidget {
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
                decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xFFD0D0D0)))),
                padding: EdgeInsets.only(left: 20),
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  maxLength: 16,
                  autofocus: false,
                  decoration: InputDecoration(
                    // 主要目的是隐藏Counter
                    counter: Container(),
                    icon: Image.asset('images/icon_user.png', width: 20),
                    hintText: '请输入姓名(非必填)',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(top: 12, bottom: 12),
                  ),
                  style: TextStyle(fontSize: 16),
                  scrollPadding: EdgeInsets.all(0),
                ),
              ),
              Container(
                decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xFFD0D0D0)))),
                padding: EdgeInsets.only(left: 20),
                child: TextFormField(
                  keyboardType: TextInputType.phone,
                  maxLength: 11,
                  autofocus: false,
                  decoration: InputDecoration(
                    // 主要目的是隐藏Counter
                    counter: Container(),
                    icon: Image.asset('images/icon_phone.png', width: 20),
                    hintText: '请输入手机号(非必填)',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(top: 12, bottom: 12),
                  ),
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Container(
                decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xFFD0D0D0)))),
                padding: EdgeInsets.only(left: 20),
                child: GestureDetector(
                  onTap: () {
                    // 显示日期选择对话框
                    DatePicker.showDatePicker(context, onConfirm: (year, month, date) {
                      print(year);
                      print(month);
                      print(date);
                    });
                  },
                  child: Container(
                    height: 40,
                    child: Row(
                      children: <Widget>[
                        Center(
                          child: Image.asset('images/icon_validate_time.png', width: 20),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 16),
                        ),
                        Center(
                          child: Text('请设置过期时间'),
                        ),
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
                      Center(
                        child: Image.asset('images/icon_house.png', width: 20),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 16),
                      ),
                      Center(
                        child: Text('请选择房屋'),
                      ),
                      Expanded(
                        child: Container(),
                      ),
                      PopupMenuButton<String>(
                        padding: const EdgeInsets.all(8),
                        icon: const Icon(Icons.arrow_drop_down),
                        itemBuilder: (context) => <PopupMenuItem<String>>[
                              PopupMenuItem(
                                value: "测试1",
                                child: Text("测试1"),
                              ),
                              PopupMenuItem(
                                value: "测试2",
                                child: Text("测试2"),
                              ),
                              PopupMenuItem(
                                value: "测试3",
                                child: Text("测试3"),
                              ),
                              PopupMenuItem(
                                value: "测试4",
                                child: Text("测试4"),
                              ),
                            ],
                        onSelected: (String res) {
                          print(res);
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: 40,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: StateButtonWidget(
                        child: Center(child: Text('生成历史', style: TextStyle(fontSize: 14, color: Color(0xFF606060)))),
                        onTap: () {
                          // 点击生成历史
                          Navigator.of(context, rootNavigator: true).pop(false);
                        },
                      ),
                    ),
                    Container(
                      width: 1,
                      color: Color(0xFFD0D0D0),
                      child: Column(),
                    ),
                    Expanded(
                      child: Center(child: Text('立即生成', style: TextStyle(fontSize: 14, color: Color(0xFFEB891A)))),
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
